import 'dart:collection';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:http/http.dart' as http;
import 'package:mobile_app_hack/appTheme.dart';
import 'package:mobile_app_hack/date_format/predictions_date.dart';
import 'package:mobile_app_hack/home.dart';
import 'package:mobile_app_hack/sign_up/home_pages.dart';


class PlaceDetails extends StatefulWidget {
  PredictionsDate predictionsDate1;
  PlaceDetails(PredictionsDate predictionsDatee) {
    this.predictionsDate1 = predictionsDatee;
  }

  @override
  _PlaceDetailsState createState() => _PlaceDetailsState(predictionsDate1);
}

class _PlaceDetailsState extends State<PlaceDetails> {
  PredictionsDate predictionsDate;
  _PlaceDetailsState(predictionsDatee) {
    this.predictionsDate = predictionsDatee;
  }
  var marker = HashSet<Marker>();
  TextEditingController search;
  List count = [];
  List prediction_list = [];
  final String url = 'https://maps.googleapis.com/maps/api/place/details/json?';
  var save;
  String name = " ", address = " ", phone = " ";
  double lng = 31, lat = 30;
  BitmapDescriptor custom_marker;
  getcustomMarker() async {
    custom_marker = await BitmapDescriptor.fromAssetImage(
        ImageConfiguration.empty, "assets/icn_round_location_pin.png");
  }

  initState() {
    super.initState();
    getData();
    getcustomMarker();
  }

  int x = 5;
  Future<List> getData() async {
    prediction_list.clear();
    http.Response response = await http
        .get(url +
            'key=AIzaSyB-PBPHzbYC90YVPMuEaM7cCMpEhayuZ4I'
                '&place_id=${predictionsDate.place_id}'
                '&language=en')
        .then((response) {
      save = json.decode(response.body);

      setState(() {
        lng = save['result']['geometry']['location']['lng'];
        lat = save['result']['geometry']['location']['lat'];
        name = save['result']['name'];
        phone = save['result']['international_phone_number'];
        address = save['result']['formatted_address'];
        marker.add(
          Marker(
              markerId: MarkerId(predictionsDate.place_id.toString()),
              position: LatLng(lat, lng),
              infoWindow: InfoWindow(
                  title: predictionsDate.main_text,
                  snippet: phone,
                  onTap: () {}),
              icon: custom_marker),
        );
      });
    });
    return prediction_list;
    // return save1;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.height;

    int t2 = address.length;
    if (address.length > w / 25) t2 = (w / 25).toInt();
    return Scaffold(
      backgroundColor: AppTheme.white,
      body: Container(
        margin: EdgeInsets.all(20),
        alignment: Alignment.center,
        child: ListView(

          children: [
            Container(
              height: 400,
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey, width: 2),
                color: AppTheme.white,
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(15),
                    child: Text(
                      predictionsDate.main_text,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    height: 150,
                    width: MediaQuery.of(context).size.width ,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: GoogleMap(
                      mapType: MapType.normal,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(lat, lng),
                        zoom: 20,
                      ),
                      onMapCreated: (google_map_controller) {
                        setState(() {
                          marker.add(
                            Marker(
                                markerId: MarkerId(predictionsDate.place_id),
                                position: LatLng(lat, lng),
                                infoWindow: InfoWindow(
                                    title: predictionsDate.main_text,
                                    snippet: phone,
                                    onTap: () {}),
                                icon: custom_marker),
                          );
                        });
                      },
                      markers: marker,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('assets/icn_details.png'),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "  Company Addess",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "  " + address.substring(0, t2) + "...",
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 5,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Colors.black45,
                                  inherit: true),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image(
                          image: AssetImage('assets/icn_user.png'),
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Company Reception",
                              style:
                                  TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "$name\n$phone",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.black45),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              alignment: Alignment.center,
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: AppTheme.mix),
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Home()));
                    });
                  },
                  child: Text(
                    'Next',
                    style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  )),
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: MediaQuery.of(context).size.width * .8,
              decoration: BoxDecoration(
                border: Border.all(color: AppTheme.textcolor, width: 3),
                color: AppTheme.white,
                borderRadius: BorderRadius.all(Radius.circular(15)),
              ),
              child: FlatButton(
                  onPressed: () {
                    setState(() {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => HomePages()));
                    });
                  },
                  child: Text(
                    'Search Again',
                    style: TextStyle(
                        color: AppTheme.textcolor,
                        fontSize: 20,
                        fontWeight: FontWeight.normal),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
