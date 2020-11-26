import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile_app_hack/appTheme.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_app_hack/date_format/meals_date.dart';
import 'package:mobile_app_hack/work_location.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController search;

  List count = [];
  MealsDate _mealsDate;
  // that List to Save  light mael Date
  List mealsDate_light_list = [];
  // that List to Save   light mael Date
  List mealsDate_best_value_list = [];
  // that List to Save   light mael Date
  List mealsDate_plus_list = [];
  final String url = 'http://demo4833373.mockable.io/menu';
  var save;
  int _indexSelected = 0;

  @override


  initState() {
    super.initState();
    // that function to get  light mael Date
    getData_light();
    // that function to get  best mael Date
    getData_best_value();
    // that function to get  plus mael Date
    getData_plus_list();
  }

  Future<List> getData_light() async {
    print(_indexSelected);
    mealsDate_light_list.clear();
    http.Response response = await http.get(url).then((response) {
      save = json.decode(response.body);
      count = save['light'] as List;
      for (int i = 0; i < count.length; i++) {
        _mealsDate = MealsDate.fromMap(save['light'][i]);
        mealsDate_light_list.add(_mealsDate);
      }
    });
    return mealsDate_light_list;
  }

  Future<List> getData_best_value() async {
    mealsDate_best_value_list.clear();
    http.Response response = await http.get(url).then((response) {
      save = json.decode(response.body);
      count = save['best_value'] as List;
      for (int i = 0; i < count.length; i++) {
        _mealsDate = MealsDate.fromMap(save['best_value'][i]);
        mealsDate_best_value_list.add(_mealsDate);
      }
    });
    return mealsDate_best_value_list;
  }

  Future<List> getData_plus_list() async {
    mealsDate_plus_list.clear();
    http.Response response = await http.get(url).then((response) {
      save = json.decode(response.body);
      count = save['plus'] as List;
      for (int i = 0; i < count.length; i++) {
        _mealsDate = MealsDate.fromMap(save['plus'][i]);
        mealsDate_plus_list.add(_mealsDate);
      }
    });
    return mealsDate_plus_list;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppTheme.white,
      body: Container(
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: WorkLocation.Menu(),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 20),
              child: Image(image: AssetImage('assets/Meal_on_the_go.png')),
            ),
            Container(
              alignment: Alignment.topCenter,
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Image(image: AssetImage('assets/banner.png')),
            ),
            Container(
                padding: EdgeInsets.only(top: 10, bottom: 10, ),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          "  Order By 11:30",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: AppTheme.primary1,
                              fontSize: 20),
                        ),
                        Text(
                          "Select your meals",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.grey,
                              fontSize: 15),
                        )
                      ],
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Center(
                      child: Wrap(
                        children: [
                          ChoiceChip(
                            selectedColor: AppTheme.primary1,
                            label: Text("All"),
                            selected: (_indexSelected == 0),
                            labelStyle: TextStyle(
                                color: _indexSelected == 0
                                    ? AppTheme.white
                                    : AppTheme.black),
                            onSelected: (value) {
                              setState(() {
                                _indexSelected = value ? 0 : -1;
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          ChoiceChip(
                            selectedColor: AppTheme.primary1,
                            label: Text("Syami"),
                            labelStyle: TextStyle(
                                color: _indexSelected == 1
                                    ? AppTheme.white
                                    : AppTheme.black),
                            selected: _indexSelected == 1,
                            onSelected: (value) {
                              setState(() {
                                _indexSelected = value ? 1 : -1;
                              });
                            },
                          ),
                          const SizedBox(width: 8),
                          ChoiceChip(
                            selectedColor: AppTheme.primary1,
                            labelStyle: TextStyle(
                                color: _indexSelected == 2
                                    ? AppTheme.white
                                    : AppTheme.black),
                            label: Text("Healthy"),
                            selected: _indexSelected == 2,
                            onSelected: (value) {
                              setState(() {
                                _indexSelected = value ? 2 : -1;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 20, bottom: 10, left: 15),
              child: Image(image: AssetImage('assets/title_light.png')),
            ),
            Container(
              height: 450,
              padding: EdgeInsets.only(bottom: 10, left: 10),
              color: Colors.white,
              child: FutureBuilder<List>(
                  future: getData_light(),
                  builder: (context1, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return Container(
                        alignment: Alignment.center,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mealsDate_light_list.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return WorkLocation.Meal_Item(
                                  mealsDate_light_list[index], context);
                            }));
                    //snapshot.hasData
                  }),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(left: 15),
              child: Image(image: AssetImage('assets/title_best_value.png')),
            ),
            Container(
              height: 450,
              padding: EdgeInsets.only(left: 10),
              color: Colors.white,
              child: FutureBuilder<List>(
                  future: getData_best_value(),
                  builder: (context1, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mealsDate_best_value_list.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return WorkLocation.Meal_Item(
                                  mealsDate_best_value_list[index], context);
                            }));
                    //snapshot.hasData
                  }),
            ),
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.only(top: 10, bottom: 10, left: 15),
              child: Image(image: AssetImage('assets/title_plus.png')),
            ),
            Container(
              height: 450,
              padding: EdgeInsets.only(bottom: 10, left: 10),
              color: Colors.white,
              child: FutureBuilder<List>(
                  future: getData_plus_list(),
                  builder: (context1, snapshot) {
                    if (snapshot.hasError) print(snapshot.error);
                    return Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.only(top: 10),
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: mealsDate_plus_list.length,
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context, index) {
                              return WorkLocation.Meal_Item(
                                  mealsDate_plus_list[index], context);
                            }));
                    //snapshot.hasData
                  }),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    ));
  }
}
