import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:mobile_app_hack/appTheme.dart';
import 'package:mobile_app_hack/date_format/meals_date.dart';
import 'package:mobile_app_hack/date_format/predictions_date.dart';
import 'package:mobile_app_hack/sign_up/place_details.dart';

class WorkLocation {
  static Widget ItemWorkLocation(PredictionsDate predictionsDate, context) {
    var w = MediaQuery.of(context).size.height;
    int t1 = predictionsDate.main_text.length;
    int t2 = predictionsDate.secondary_text.length;
    if (predictionsDate.main_text.length > w / 25) t1 = (w / 25).toInt();
    if (predictionsDate.secondary_text.length > w / 22) t2 = (w / 22).toInt();
    return InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PlaceDetails(predictionsDate)));
        },
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(15),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Image.asset("assets/icn_location_pin.png"),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        predictionsDate.main_text.substring(0, t1),
                        style:
                            TextStyle(fontSize: 20, color: AppTheme.textcolor),
                      ),
                      Text(
                        predictionsDate.secondary_text.substring(0, t2) + '...',
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(
              height: 5,
              color: Colors.grey,
              thickness: 1,
            )
          ],
        ));
  }

  static Widget Meal_Item(MealsDate mealsDate, context) {
    var w = MediaQuery.of(context).size.height;

    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(15),
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 250,
                width: 200,
                decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey,
                          spreadRadius: .5,
                          blurRadius: 2,
                          offset: Offset(0, 2)),
                    ],
                    borderRadius: BorderRadius.circular(30),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(mealsDate.img))),
              ),
              SizedBox(
                height: 5,
              ),
              Center(
                child: Text(
                  "EGP " + mealsDate.regular_price.toString(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Image.asset("assets/icn_plus.png"),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "EGP " + mealsDate.plus_price.toString(),
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                mealsDate.name.toString(),
                //    overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                mealsDate.restaurant.toString(),
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  static Widget Menu() {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image(
            image: AssetImage('assets/icn_delivery.png'),
            width: 40,
          ),
          RichText(
            text: TextSpan(
              style: TextStyle(
                color: AppTheme.black,
                fontSize: 18,
                fontWeight: FontWeight.normal,
              ),
              text: 'Delivery to ',
              children: <TextSpan>[
                TextSpan(
                  text: 'STC',
                  style: TextStyle(
                    color: AppTheme.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            padding: EdgeInsets.zero,
            child: Image(
              image: AssetImage('assets/icn_drop.png'),
              width: 40,
            ),
            onSelected: (value) {},
            itemBuilder: (context) => <PopupMenuEntry<String>>[
              PopupMenuItem<String>(
                value: "STC",
                child: ListTile(
                  leading: const Icon(Icons.sim_card,
                      size: 20, color: AppTheme.primary1),
                  title: Text("STC",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.normal,
                      )),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
