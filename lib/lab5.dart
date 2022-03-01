import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      debugShowCheckedModeBanner: false,

      home: MyTestMap(

      ),
    );
  }
}

class MyTestMap extends StatefulWidget {
  @override
  _MyTestMapState createState() => _MyTestMapState();
}

class _MyTestMapState extends State<MyTestMap> {

  final Set<Marker> _markers = {};

  LatLng _initialcameraposition = LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  Location _location = Location();


  void _onMapCreated(GoogleMapController _cntlr)
  {

    setState(() {
      _markers.add(
          Marker(markerId: MarkerId('id-1'),
              position: LatLng(42.00437873001569, 21.391706433446643),
              infoWindow: InfoWindow(
                  title: 'MARKER',
                  snippet: 'Place number 1'
              )
          )
      );

    });

    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!),zoom: 14),
        ),
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:
      AppBar(
        title: Text("Google Map"),
        leading: Icon(
          Icons.menu,

        ),

        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.arrow_forward)),
          // Padding(
          //     padding: EdgeInsets.only(right: 20.0),
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: Icon(
          //         Icons.search,
          //         size: 26.0,
          //       ),
          //     )
          // ),
          // Padding(
          //     padding: EdgeInsets.only(right: 20.0),
          //     child: GestureDetector(
          //       onTap: () {},
          //       child: Icon(
          //           Icons.more_vert
          //       ),
          //     )
          // ),
        ],
      ),
      body: Container(
        //margin: new EdgeInsets.only(left: 20,top: 150,right: 20,bottom: 60),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [

            GoogleMap(
              initialCameraPosition: CameraPosition(target: _initialcameraposition),
              mapType: MapType.normal,
              onMapCreated: _onMapCreated,
              markers: _markers,
              myLocationEnabled: true,
            ),
          ],
        ),

      ),
    );
  }


}