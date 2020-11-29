import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:mobile_app_hack/appTheme.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_hack/date_format/predictions_date.dart';
import 'package:mobile_app_hack/home.dart';
import 'package:mobile_app_hack/work_location.dart';

class SignUp extends StatefulWidget {

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
TextEditingController  search;
List count=[];
PredictionsDate _predictionsDate;
List prediction_list=[];
final String url= 'https://maps.googleapis.com/maps/api/place/autocomplete/json?';
   var save;
   String mess="";
initState() {
  super.initState();
  this.search = new TextEditingController();

}
Future<List> getData() async {
  prediction_list.clear();
  http.Response response = await http
      .get(url+'key=AIzaSyB-PBPHzbYC90YVPMuEaM7cCMpEhayuZ4I'
      '&input=${search.text}&'
      'language=en&components=country%3Aeg'
      '&types=establishment')
      .then((response) {
    save=json.decode(response.body);
    count=save['predictions'] as List;
    for(int i =0;i<count.length;i++){
      _predictionsDate = PredictionsDate.fromMap(save['predictions'][i]);
      prediction_list.add(_predictionsDate);
    }
  });
  return prediction_list;
 // return save1;
}

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppTheme.bg,

      body: Container(
        color: AppTheme.bg,
        child: Column(
          children: [
         Container(
         margin: EdgeInsets.all(20),
           child:   Row(

             children: [
             Image(image: AssetImage('assets/icn_company.png'),),
             Text(
               "  Set your work location",
               style: TextStyle(fontSize: 20, color: Colors.black54),
             ),
           ],),
         ),

            Container(

            margin: EdgeInsets.only(right: 20, left: 20, top: 10, ),
            height: 50,
            child: TextField(
              onChanged: (search){
                setState(() {
                  getData();
                });
              },
              controller: search,
              keyboardType: TextInputType.text,
              style: TextStyle(color: AppTheme.black,fontSize: 20),cursorColor: AppTheme.primary1,
              decoration: InputDecoration(
                border:  OutlineInputBorder(gapPadding: 5,borderRadius: BorderRadius.all(Radius.circular(10)),
                    borderSide: BorderSide(width:30,color: AppTheme.primary1)),
                suffixIcon: Icon(
                  Icons.search,
                  color: AppTheme.primary1,
                ),
                labelStyle: TextStyle(color: AppTheme.primary1,
                    fontSize: 20, fontWeight: FontWeight.normal),

                labelText: "Work Address",

              ),
              maxLines: 1,
            ),
          ),
          Expanded(child:   Container(
            height: double.infinity,


            color: Colors.white,
            child: FutureBuilder<List>(
                future: getData(),
                builder: (context1, snapshot) {
                  if (snapshot.hasError) print(snapshot.error);
                  return Container(
                      height: 50,
                      alignment: Alignment.center,
                      padding: EdgeInsets.only(top: 10),
                      child: ListView.builder(
                          itemCount: prediction_list.length,
                          physics: BouncingScrollPhysics(),
                          itemBuilder: (context, index) {

                            return
                              WorkLocation.ItemWorkLocation(prediction_list[index],context);



                          }));
                  //snapshot.hasData

                }),
          ),)
          
          ],
        ),
      ),
    ));
  }

}


