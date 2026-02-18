import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mobile/ui/nadeuri/select_place/select_place_view_model.dart';

class SelectPlacePage extends StatefulWidget {
  final SelectPlaceViewModel _selectPlaceViewModel;

  const SelectPlacePage({super.key, required SelectPlaceViewModel selectPlaceViewModel})
    : _selectPlaceViewModel = selectPlaceViewModel;

  @override
  State<SelectPlacePage> createState() => _SelectPlacePageState();
}

class _SelectPlacePageState extends State<SelectPlacePage> {
  final Completer<GoogleMapController> _googleMapController = Completer<GoogleMapController>();
  final DraggableScrollableController _draggableScrollableController = DraggableScrollableController();

  CameraPosition _cameraPosition = CameraPosition(target: LatLng(36.3508, 127.3850), zoom: 15);
  double _currentSize = 0.2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: SearchBar(
          leading: const Icon(Icons.search),
          elevation: WidgetStatePropertyAll<double?>(0),
          onSubmitted: (value) async {},
        ),
      ),
      body: Stack(
        children: [
          ListenableBuilder(
            listenable: widget._selectPlaceViewModel,
            builder: (context, child) {
              return GoogleMap(
                initialCameraPosition: _cameraPosition,
                onMapCreated: (controller) {
                  _googleMapController.complete(controller);
                },
                onCameraMove: (position) {
                  _cameraPosition = position;
                },
              );
            },
          ),
        ],
      ),
      bottomSheet: DraggableScrollableSheet(
        initialChildSize: _currentSize,
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
                  _currentSize = newSize;
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
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return ListTile(title: Text("장소 $index"));
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
