import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:team_g/constants/constants.dart';
import 'package:team_g/presentation/review/add_review_page.dart';

class PostPage extends ConsumerWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    TextEditingController _searchController = TextEditingController();

    return Scaffold(
      // appBar: AppBar(
      //   elevation: 0.5,
      //   backgroundColor: Colors.grey[200],
      //   title: TextField(
      //     controller: _searchController,
      //     cursorColor: Palette.yellow,
      //     decoration: InputDecoration(
      //         fillColor: Colors.grey[200],
      //         contentPadding: EdgeInsets.symmetric(vertical: 15),
      //         hintText: 'エリア・ジャンルなど',
      //         hintStyle: const TextStyle(color: Colors.grey),
      //         border: InputBorder.none,
      //         prefixIcon: Icon(Icons.search, color: Colors.black),
      //         suffixIcon: TextButton(
      //           child: const Text("詳細条件"),
      //           onPressed: () {
      //             // clearSearch();
      //           },
      //         )),
      //   ),
      // ),
      body: SafeArea(
          child: Container(
              width: MediaQuery.of(context).size.width,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10.0,
                                  spreadRadius: 1.0,
                                  offset: Offset(10, 10))
                            ],
                          ),
                          child: Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              alignment: Alignment.centerLeft,
                              child: TextFormField(
                                // 検索フォーム
                                onChanged: (value) {},
                                decoration: InputDecoration(
                                  prefixIcon: IconButton(
                                    color: Colors.grey[500],
                                    icon: Icon(Icons.arrow_back_ios_new),
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  hintText: '場所を検索',
                                  hintStyle: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                  border: InputBorder.none,
                                ),
                              ))),
                    ],
                  ),
                ),
              ]))),
      floatingActionButton: FloatingActionButton(
        heroTag: "HomeScreen",
        child: const Icon(
          Icons.post_add,
          color: Colors.white,
          size: 32.0,
        ),
        onPressed: () {
          Navigator.push(
              context,
              CupertinoPageRoute(
                  builder: (context) => CreateReviewScreen(
                        currentUserId: currentUserId,
                      )));
        },
      ),
    );
  }
}

class MapView extends HookWidget {
  final Completer<GoogleMapController> _mapController = Completer();
  // 初期表示位置を渋谷駅に設定
  // final Position _initialPosition = Position(
  //   latitude: 35.658034,
  //   longitude: 139.701636,
  //   timestamp: DateTime.now(),
  //   altitude: 0,
  //   accuracy: 0,
  //   heading: 0,
  //   floor: null,
  //   speed: 0,
  //   speedAccuracy: 0,
  // );

  @override
  Widget build(BuildContext context) {
    // 初期表示座標のMarkerを設定
    final initialMarkers = {
      // _initialPosition.timestamp.toString(): Marker(
      //   markerId: MarkerId(_initialPosition.timestamp.toString()),
      //   position: LatLng(_initialPosition.latitude, _initialPosition.longitude),
      // ),
    };
    // final position = useState<Position>(_initialPosition);
    // final markers = useState<Map<String, Marker>>(initialMarkers);

    // _setCurrentLocation(position, markers);
    // _animateCamera(position);

    return Scaffold(
      body: GoogleMap(
        mapType: MapType.normal,
        myLocationButtonEnabled: false,
        // 初期表示位置は渋谷駅に設定
        initialCameraPosition: CameraPosition(
          target: LatLng(0.0, 1.0),
          zoom: 14.4746,
        ),
        onMapCreated: _mapController.complete,
        // markers: markers.value.values.toSet(),
      ),
    );
  }

  // Future<void> _setCurrentLocation(ValueNotifier<Position> position,
  //     ValueNotifier<Map<String, Marker>> markers) async {
  //   final currentPosition = await Geolocator.getCurrentPosition(
  //     desiredAccuracy: LocationAccuracy.high,
  //   );

  //   const decimalPoint = 3;
  //   // 過去の座標と最新の座標の小数点第三位で切り捨てた値を判定
  //   if ((position.value.latitude).toStringAsFixed(decimalPoint) !=
  //           (currentPosition.latitude).toStringAsFixed(decimalPoint) &&
  //       (position.value.longitude).toStringAsFixed(decimalPoint) !=
  //           (currentPosition.longitude).toStringAsFixed(decimalPoint)) {
  //     // 現在地座標にMarkerを立てる
  //     final marker = Marker(
  //       markerId: MarkerId(currentPosition.timestamp.toString()),
  //       position: LatLng(currentPosition.latitude, currentPosition.longitude),
  //     );
  //     markers.value.clear();
  //     markers.value[currentPosition.timestamp.toString()] = marker;
  //     // 現在地座標のstateを更新する
  //     position.value = currentPosition;
  //   }
  // }

  // Future<void> _animateCamera(ValueNotifier<Position> position) async {
  //   final mapController = await _mapController.future;
  //   // 現在地座標が取得できたらカメラを現在地に移動する
  //   await mapController.animateCamera(
  //     CameraUpdate.newLatLng(
  //       LatLng(position.value.latitude, position.value.longitude),
  //     ),
  //   );
  // }
}
