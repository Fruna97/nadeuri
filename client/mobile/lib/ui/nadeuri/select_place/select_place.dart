import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/domain/model/place/place.dart';
import 'package:mobile/ui/core/app_snack_bar.dart';
import 'package:mobile/ui/nadeuri/select_place/select_place_view_model.dart';
import 'package:provider/provider.dart';

enum _BottomSheetState { empty, list, selected }

class SelectPlacePage extends StatefulWidget {
  final SelectPlaceViewModel _selectPlaceViewModel;

  const SelectPlacePage({super.key, required SelectPlaceViewModel selectPlaceViewModel})
    : _selectPlaceViewModel = selectPlaceViewModel;

  @override
  State<SelectPlacePage> createState() => _SelectPlacePageState();
}

class _SelectPlacePageState extends State<SelectPlacePage> {
  GoogleMapController? _googleMapController;
  final DraggableScrollableController _draggableScrollableController = DraggableScrollableController();

  CameraPosition _cameraPosition = CameraPosition(target: LatLng(36.3508, 127.3850), zoom: 15);
  double _currentSize = 0.5;
  Place? _selectedPlace;

  Set<Marker> get _markers => widget._selectPlaceViewModel.places.map((place) {
    final bool isSelectedMarker = place.id == _selectedPlace?.id;
    return Marker(
      markerId: MarkerId(place.id),
      infoWindow: isSelectedMarker
          ? InfoWindow(title: place.displayName, snippet: place.primaryTypeDisplayName)
          : InfoWindow.noText,
      position: LatLng(place.latitude, place.longitude),
      icon: isSelectedMarker
          ? BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure)
          : BitmapDescriptor.defaultMarker,
      onTap: () {
        setState(() {
          _selectedPlace = place;
        });
      },
    );
  }).toSet();

  _BottomSheetState get _bottomSheetState {
    if (widget._selectPlaceViewModel.places.isEmpty) return _BottomSheetState.empty;
    if (_selectedPlace == null) return _BottomSheetState.list;
    return _BottomSheetState.selected;
  }

  double get _mapBottomPadding => switch (_bottomSheetState) {
    _BottomSheetState.empty || _BottomSheetState.selected => MediaQuery.of(context).size.height * 0.25,
    _BottomSheetState.list => MediaQuery.of(context).size.height * _currentSize,
  };

  @override
  void initState() {
    super.initState();

    widget._selectPlaceViewModel.textSearch.addListener(_onTextSearchFailed);
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _bottomSheetState == _BottomSheetState.empty,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }

        if (_bottomSheetState == _BottomSheetState.selected) {
          setState(() {
            _selectedPlace = null;
          });
          return;
        }

        if (_bottomSheetState == _BottomSheetState.list) {
          widget._selectPlaceViewModel.clearPlace();
          return;
        }
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: SearchBar(
            leading: const Icon(Icons.search),
            elevation: WidgetStatePropertyAll<double?>(0),
            onSubmitted: (value) {
              if (value.isEmpty) return;

              _selectedPlace = null;
              widget._selectPlaceViewModel.textSearch.execute((
                value,
                _cameraPosition.target.latitude,
                _cameraPosition.target.longitude,
              ));
            },
          ),
        ),
        body: Stack(
          children: [
            ListenableBuilder(
              listenable: widget._selectPlaceViewModel,
              builder: (context, child) {
                return GoogleMap(
                  onMapCreated: (controller) {
                    _googleMapController = controller;
                  },
                  onCameraMove: (position) {
                    _cameraPosition = position;
                  },
                  initialCameraPosition: _cameraPosition,
                  markers: _markers,
                  padding: EdgeInsets.only(bottom: _mapBottomPadding),
                );
              },
            ),
          ],
        ),
        bottomSheet: ListenableBuilder(
          listenable: widget._selectPlaceViewModel,
          builder: (context, child) {
            return switch (_bottomSheetState) {
              _BottomSheetState.empty => SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Center(
                  child: Text(
                    "검색을 통해 장소를 추가해보세요!",
                    style: Theme.of(context).textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              _BottomSheetState.selected => SizedBox(
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.25,
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                _selectedPlace!.displayName ?? "-",
                                style: Theme.of(context).textTheme.titleLarge,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 24),
                              Text(
                                _selectedPlace!.primaryTypeDisplayName ?? "-",
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                _selectedPlace!.formattedAddress ?? "-",
                                style: Theme.of(context).textTheme.bodySmall,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        FilledButton(
                          onPressed: () {
                            Navigator.pop<Place>(context, _selectedPlace);
                          },
                          child: const Text("추가하기"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              _BottomSheetState.list => _showPlacesSheet(),
            };
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    widget._selectPlaceViewModel.textSearch.removeListener(_onTextSearchFailed);

    super.dispose();
  }

  Widget _showPlacesSheet() {
    return DraggableScrollableSheet(
      initialChildSize: 0.5,
      minChildSize: 0.2,
      maxChildSize: 0.5,
      expand: false,
      snap: true,
      snapSizes: [0.2, 0.5],
      controller: _draggableScrollableController,
      builder: (context, scrollController) {
        return Column(
          children: [
            /// Drag Handle
            GestureDetector(
              onVerticalDragUpdate: (details) {
                /// 드래그 포인터 위치를 백분율로 변환하여 이동
                final double newPixelSize = _draggableScrollableController.pixels - details.delta.dy;
                _currentSize = _draggableScrollableController.pixelsToSize(newPixelSize).clamp(0.0, 1.0);
                _draggableScrollableController.jumpTo(_currentSize);
              },
              onVerticalDragEnd: (details) {
                /// 현재 사이즈에 가까운 snap size로 이동
                final double newSize = (0.2 - _currentSize).abs() < (0.5 - _currentSize).abs() ? 0.2 : 0.5;
                setState(() {
                  _currentSize = newSize;
                });
                _draggableScrollableController.animateTo(
                  _currentSize,
                  duration: const Duration(milliseconds: 150),
                  curve: Curves.linear,
                );
              },
              behavior: HitTestBehavior.opaque,
              child: Center(
                widthFactor: double.infinity,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 12),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(color: Colors.grey),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                controller: scrollController,
                itemCount: widget._selectPlaceViewModel.places.length,
                itemBuilder: (context, index) {
                  Place place = widget._selectPlaceViewModel.places[index];
                  return ListTile(
                    onTap: () {
                      setState(() {
                        _selectedPlace = place;
                        _googleMapController!.animateCamera(
                          CameraUpdate.newLatLng(LatLng(place.latitude, place.longitude)),
                        );
                      });
                    },
                    isThreeLine: true,
                    title: Text(place.displayName ?? "-"),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          place.primaryTypeDisplayName ?? "-",
                          style: Theme.of(context).textTheme.bodyMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          place.formattedAddress ?? "-",
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void _onTextSearchFailed() {
    if (widget._selectPlaceViewModel.textSearch.completed && widget._selectPlaceViewModel.places.isEmpty) {
      context.read<AppSnackBar>().showSnackBar("검색한 장소가 없습니다.");
      return;
    }

    if (widget._selectPlaceViewModel.textSearch.error) {
      context.read<AppSnackBar>().showSnackBar("장소 검색에 실패했습니다. 나중에 다시 시도해 주세요!");
      return;
    }
  }
}
