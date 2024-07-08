//ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myweather/api_handeling.dart';
import 'package:myweather/pages/choose_location.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

int? temperature;
String? weather;
String? dayStatus;
String? time;
late City cityN;
late bool isLoading;
late String animationName;
double animationHeight = 100;
double animationWidth = 100;

// ignore: must_be_immutable
class ShowTemprature extends StatefulWidget {
  ShowTemprature({super.key, required city}) {
    cityN = city;
  }

  @override
  State<ShowTemprature> createState() => ShowTempratureState();
}

class ShowTempratureState extends State<ShowTemprature> {
  ShowTempratureState();
  @override
  void initState() {
    isLoading = true;
    animationName = "loading";
    super.initState();
    fetchData();
    Timer(Duration(seconds: 10), () {
      if (isLoading) {
        animationName = "lossy";
        animationHeight = 200;
        animationWidth = 200;
        setState(() {});
      }
    });
  }

  void fetchData() async {
    List? returnList = await getTempByCityName(cityName: cityN.name);
    temperature = returnList![0];
    weather = returnList[1];
    dayStatus = returnList[2];
    time = returnList[3];
    //>> weather animation
    if (weather == "Clear" && dayStatus == "Day") {
      animationName = "sunny";
    } else if (weather == "Clouds" && dayStatus == "Day") {
      animationName = "cloudy";
    } else if (weather == "Rain" && dayStatus == "Day") {
      animationName = "raining";
    } else if (weather == "Clear" && dayStatus == "Night") {
      animationName = "sunny_night";
    } else if (weather == "Clouds" && dayStatus == "Night") {
      animationName = "cloudy_night";
    } else if (weather == "Rain" && dayStatus == "Night") {
      animationName = "raining_night";
    } else if (weather == "Mist") {
      animationName = "foggy";
    } else if (weather == "Haze") {
      animationName = "hazzy";
    }

    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: () => {Navigator.popAndPushNamed(context, "/")},
              child: SizedBox(
                width: double.infinity,
                child: Animate(
                  effects: const [MoveEffect()],
                  child: Column(
                    children: [
                      Icon(Icons.location_on, color: Colors.grey),
                      Text(cityN.name,
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "bigFont",
                              fontSize: 20)),
                      isLoading
                          ? Text("",
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "bigFont",
                                  fontSize: 40))
                          : Text(time!,
                              style: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: "bigFont",
                                  fontSize: 40))
                    ],
                  ),
                ),
              ),
            ),
            Lottie.asset("assets/$animationName.json",
                height: animationHeight, width: animationWidth),
            isLoading
                ? Text("",
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "bigFont",
                        fontSize: 70))
                : Text("${temperature.toString()}°C",
                    style: TextStyle(
                        color: Colors.grey,
                        fontFamily: "bigFont",
                        fontSize: 70))
          ],
        ));
  }
}
