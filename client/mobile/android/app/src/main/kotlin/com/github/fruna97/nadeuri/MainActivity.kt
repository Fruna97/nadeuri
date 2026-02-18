package com.github.fruna97.nadeuri

import android.content.pm.PackageManager
import android.os.Bundle
import android.os.PersistableBundle
import com.google.android.gms.maps.model.LatLng
import com.google.android.libraries.places.api.Places
import com.google.android.libraries.places.api.model.CircularBounds
import com.google.android.libraries.places.api.model.Place
import com.google.android.libraries.places.api.net.PlacesClient
import com.google.android.libraries.places.api.net.SearchByTextRequest
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.launch
import kotlinx.coroutines.tasks.await
import org.json.JSONArray
import org.json.JSONObject

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.github.fruna97"
    val placesClient: PlacesClient by lazy {
        val apiKey = packageManager.getApplicationInfo(
            context.packageName, PackageManager.GET_META_DATA
        ).metaData.getString("com.google.android.geo.API_KEY")
        Places.initializeWithNewPlacesApiEnabled(this, apiKey!!)
        Places.createClient(this)
    }

    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)

        // 임의 호출을 통해 by lazy 초기화 시점 제어
        placesClient
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "searchByText" -> {
                    val textQuery = call.argument<String>("textQuery") ?: ""
                    val latitude = call.argument<Double>("latitude")
                    val longitude = call.argument<Double>("longitude")

                    if (textQuery.isEmpty()) {
                        result.error("EMPTY_TEXT_QUERY", "textQuery가 제공되어야 합니다", null)
                        return@setMethodCallHandler
                    }
                    val searchCenter = if (latitude != null && longitude != null) LatLng(latitude, longitude) else null

                    CoroutineScope(Dispatchers.Main).launch {
                        try {
                            result.success(searchByText(textQuery, searchCenter))
                        } catch (e: Exception) {
                            e.printStackTrace()
                            result.error("UNAVAILABLE", e.message, null)
                        }
                    }
                }
            }
        }
    }

    /**
     * 주어진 [textQuery]로 장소들을 검색하고, 장소들의 정보를 JSON 형식으로 반환합니다.
     *
     * 장소 검색에는 Places SDK를 사용하므로,
     * 사용하기전에 API 키를 담아 [Places.initializeWithNewPlacesApiEnabled()]를 호출하여 Places SDK를 초기화 해야 합니다.
     *
     * @param [textQuery] 검색할 문자열
     * @param [searchCenter] 검색에 사용할 좌표. null이면 IP 편향이 사용됩니다.
     */
    private suspend fun searchByText(textQuery: String, searchCenter: LatLng?): String {
        val builder = SearchByTextRequest.builder(
            textQuery, listOf(
                Place.Field.DISPLAY_NAME,
                Place.Field.FORMATTED_ADDRESS,
                Place.Field.ID,
                Place.Field.LOCATION,
                Place.Field.PRIMARY_TYPE_DISPLAY_NAME
            )
        ).setMaxResultCount(20)
        if (searchCenter != null) {
            builder.setLocationBias(CircularBounds.newInstance(searchCenter, 500.0))
        }
        val searchByTextRequest = builder.build()
        val searchByTextResponse = placesClient.searchByText(searchByTextRequest).await()

        val jsonArray = JSONArray()
        searchByTextResponse.places.forEach { place ->
            val jsonObject = JSONObject().apply {
                put("displayName", place.displayName)
                put("formattedAddress", place.formattedAddress)
                put("id", place.id)
                put("latitude", place.location?.latitude)
                put("longitude", place.location?.longitude)
                put("primaryTypeDisplayName", place.primaryTypeDisplayName)
            }
            jsonArray.put(jsonObject)
        }
        return jsonArray.toString()
    }
}
