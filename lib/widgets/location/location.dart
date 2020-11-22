import 'package:avmv005/Model/place.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController _controller;
  //Harita üzerindeki işaretlerimizi modelden çekmek için kullanılacak boş listemizi oluşturuyoruz.
  List<Marker> allMarkers = [];
  PageController _pageController;
  int prevPage;
  LocationData locData;
  static LatLng _initialPosition;

  //Kullanıcının lokasyonunu alacağımız fonksiyon
  Future<void> _getCurrentUserLocation() async {
    locData = await Location().getLocation();
    print("latitude" + locData.latitude.toString());
    print("longitude" + locData.longitude.toString());
    setState(() {
      _initialPosition = LatLng(locData.latitude, locData.longitude);
    });
  }

  Future<void> goToCurrentUserLocation() async {
    _controller.moveCamera(CameraUpdate.newLatLngZoom(_initialPosition, 15.0));
  }

  @override
  void initState() {
    super.initState();
    //Yukarıda oluşturduğumuz allMarkers listesini dolduruyoruz.
    placeAvms.forEach((element) {
      allMarkers.add(Marker(
          markerId: MarkerId(element.shopName),
          draggable: false,
          infoWindow:
              InfoWindow(title: element.shopName, snippet: element.address),
          position: element.locationCoords));
    });
    _pageController = PageController(initialPage: 1, viewportFraction: 0.8)
      ..addListener(_onScroll);
    _getCurrentUserLocation();
  }

  void _onScroll() {
    if (_pageController.page.toInt() != prevPage) {
      prevPage = _pageController.page.toInt();
      moveCamera();
    }
  }

  _avmList(index) {
    return AnimatedBuilder(
      animation: _pageController,
      builder: (BuildContext context, Widget widget) {
        double value = 1;
        if (_pageController.position.haveDimensions) {
          value = _pageController.page - index;
          value = (1 - (value.abs() * 0.3) + 0.06).clamp(0.0, 1.0);
        }
        return Center(
          child: SizedBox(
            height: Curves.easeInOut.transform(value) * 125.0,
            width: Curves.easeInOut.transform(value) * 350.0,
            child: widget,
          ),
        );
      },
      child: InkWell(
          onTap: () {
            // moveCamera();
          },
          child: Stack(children: [
            Center(
                child: Container(
                    margin: EdgeInsets.symmetric(
                      horizontal: 10.0,
                      vertical: 20.0,
                    ),
                    height: 125.0,
                    width: 275.0,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black54,
                            offset: Offset(0.0, 4.0),
                            blurRadius: 10.0,
                          ),
                        ]),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            color: Colors.white),
                        child: Row(children: [
                          Container(
                              height: 90.0,
                              width: 90.0,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(10.0),
                                      topLeft: Radius.circular(10.0)),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                          placeAvms[index].thumbNail),
                                      fit: BoxFit.cover))),
                          SizedBox(width: 5.0),
                          Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  placeAvms[index].shopName,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  placeAvms[index].address,
                                  style: TextStyle(
                                      fontSize: 12.0,
                                      fontWeight: FontWeight.w600),
                                ),
                              ])
                        ]))))
          ])),
    );
  }

  void mapCreated(controller) {
    setState(() {
      _controller = controller;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _initialPosition == null
          ? Container(
              child: Center(
                child: Text(
                  'loading map..',
                  style: TextStyle(
                      fontFamily: 'Avenir-Medium', color: Colors.grey[400]),
                ),
              ),
            )
          : Container(
              child: Stack(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - 50.0,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initialPosition, zoom: 15.0),
                      markers: Set.from(allMarkers),
                      onMapCreated: mapCreated,
                    ),
                  ),
                  Positioned(
                    bottom: 20.0,
                    child: Container(
                      height: 950.0,
                      width: MediaQuery.of(context).size.width,
                      child: PageView.builder(
                        controller: _pageController,
                        itemCount: placeAvms.length,
                        itemBuilder: (BuildContext context, int index) {
                          return _avmList(index);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    height: 1100,
                    child: Row(
                      children: <Widget>[
                        FlatButton.icon(
                          onPressed: goToCurrentUserLocation,
                          icon: Icon(Icons.location_on),
                          label: Text('Current Location'),
                          textColor: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  moveCamera() {
    _controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
        target: placeAvms[_pageController.page.toInt()].locationCoords,
        zoom: 14.0,
        bearing: 45.0,
        tilt: 45.0)));
  }
}
