//ignore_for_file: prefer_const_constructors
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:myweather/pages/show_temprature.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_animate/flutter_animate.dart';

late bool isClicked;
late List<String> animationList;
String currentAnimation = "raining";
late List<Widget> combinedAnimationList;
late List<City> fullCityList;

class ChooseLocation extends StatefulWidget {
  const ChooseLocation({super.key});

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  List<City> cityList = returnCityList();
  late List<Widget> nameWidgetList;
  late Widget animationSlide;
  late Widget searchBar;
  late double searchBarPadding;
  late double animationSlideHeight;
  late double animationSlideWidth;
  late FocusNode focusNode;
  @override
  void initState() {
    super.initState();
    print(cityList.length);
    searchBarPadding = 70;
    animationSlideHeight = 300;
    animationSlideWidth = 300;
    fullCityList = [...cityList];
    focusNode = FocusNode();
    animationList = [
      "raining_night",
      "sunny",
      "sunny_night",
      "raining",
      "foggy"
    ];
    nameWidgetList =
        cityList.map((element) => LocationTitle(city: element)).toList();
    animationSlide = Lottie.asset("assets/$currentAnimation.json",
        height: animationSlideHeight, width: animationSlideWidth);
    //searchBar

    //filterCityList(enteredKeyWord: "New Y");
    isClicked = false;
    int count = 0;
    Timer.periodic(Duration(seconds: 1), (timer) {
      animationSlide = Lottie.asset("assets/$currentAnimation.json",
          width: animationSlideWidth, height: animationSlideHeight);
      currentAnimation = animationList[count];
      count++;
      if (count == animationList.length) {
        count = 0;
      }

      if (isClicked) {
        timer.cancel();
      } else {
        setState(() {});
      }
    });
  }

  void filterCityList({String? enteredKeyWord}) {
    if (enteredKeyWord == "") {
      cityList = fullCityList;
    } else {
      enteredKeyWord = enteredKeyWord!.toLowerCase();
      enteredKeyWord =
          enteredKeyWord[0].toUpperCase() + enteredKeyWord.substring(1);
      if (enteredKeyWord.length > 2 &&
          enteredKeyWord[enteredKeyWord.length - 2] == " ") {
        enteredKeyWord =
            enteredKeyWord.substring(0, enteredKeyWord.length - 1) +
                enteredKeyWord[enteredKeyWord.length - 1].toUpperCase();
      }
      cityList = fullCityList
          .where((element) => element.name.startsWith(enteredKeyWord!))
          .toList();
    }
    setState(() {
      nameWidgetList =
          cityList.map((element) => LocationTitle(city: element)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    searchBar = Padding(
      padding: EdgeInsets.symmetric(horizontal: searchBarPadding, vertical: 20),
      child: Animate(
        effects: const [FadeEffect()],
        child: TextField(
          focusNode: focusNode,
          decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30))),
              contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 5),
              prefixIcon: Icon(Icons.search),
              prefixIconColor: Colors.white,
              hintText: "search city",
              hintStyle: TextStyle(color: Colors.grey)),
          style: TextStyle(color: Colors.white),
          onTap: () => setState(() {
            searchBarPadding = 20;
            animationSlideHeight = 00;
            animationSlideWidth = 00;
            animationSlide = Lottie.asset("assets/$currentAnimation.json",
                height: animationSlideHeight, width: animationSlideWidth);
          }),
          onTapOutside: (event) => setState(() {
            searchBarPadding = 70;
            animationSlideHeight = 300;
            animationSlideWidth = 300;
            animationSlide = Lottie.asset("assets/$currentAnimation.json",
                height: animationSlideHeight, width: animationSlideWidth);
            FocusScope.of(context).unfocus();
          }),
          onChanged: (value) => filterCityList(enteredKeyWord: value),
        ),
      ),
    );
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text("choose location"),
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        body: ListView(
            children: combinedAnimationList = [
          searchBar,
          animationSlide,
          ...nameWidgetList
        ]));
  }
}

// ignore: must_be_immutable
class LocationTitle extends StatelessWidget {
  late City city;
  LocationTitle({super.key, required this.city});
  @override
  Widget build(BuildContext context) {
    return Animate(
      effects: const [MoveEffect()],
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: SizedBox(
          height: 60,
          child: GestureDetector(
            onTap: () {
              isClicked = true;
              Navigator.pop(context);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ShowTemprature(city: city)));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              color: Colors.white,
              elevation: 1,
              child: Center(
                  child: Text(city.name,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontFamily: "bigFont"))),
            ),
          ),
        ),
      ),
    );
  }
}

class City {
  late String name;
  City({required this.name});
}

List<City> returnCityList() {
  return [
    City(name: 'Islamabad'),
    City(name: 'New York'),
    City(name: 'Tokyo'),
    City(name: 'New Delhi'),
    City(name: 'Paris'),
    City(name: 'Washington D.C.'),
    City(name: 'London'),
    City(name: 'Berlin'),
    City(name: 'Moscow'),
    City(name: 'Beijing'),
    City(name: 'Cairo'),
    City(name: 'Rio de Janeiro'),
    City(name: 'Sydney'),
    City(name: 'Toronto'),
    City(name: 'Dubai'),
    City(name: 'Johannesburg'),
    City(name: 'Buenos Aires'),
    City(name: 'Los Angeles'),
    City(name: 'Chicago'),
    City(name: 'Houston'),
    City(name: 'San Francisco'),
    City(name: 'Miami'),
    City(name: 'Mexico City'),
    City(name: 'São Paulo'),
    City(name: 'Lima'),
    City(name: 'Bogotá'),
    City(name: 'Santiago'),
    City(name: 'Bangkok'),
    City(name: 'Singapore'),
    City(name: 'Seoul'),
    City(name: 'Hong Kong'),
    City(name: 'Mumbai'),
    City(name: 'Istanbul'),
    City(name: 'Rome'),
    City(name: 'Madrid'),
    City(name: 'Amsterdam'),
    City(name: 'Vienna'),
    City(name: 'Kuala Lumpur'),
    City(name: 'Jakarta'),
    City(name: 'Manila'),
    City(name: 'Bangkok'),
    City(name: 'Karachi'),
    City(name: 'Lagos'),
    City(name: 'Tehran'),
    City(name: 'Baghdad'),
    City(name: 'Athens'),
    City(name: 'Warsaw'),
    City(name: 'Brussels'),
    City(name: 'Zurich'),
    City(name: 'Copenhagen'),
    City(name: 'Helsinki'),
    City(name: 'Oslo'),
    City(name: 'Stockholm'),
    City(name: 'Lisbon'),
    City(name: 'Barcelona'),
    City(name: 'Vienna'),
    City(name: 'Prague'),
    City(name: 'Hanoi'),
    City(name: 'Ho Chi Minh City'),
    City(name: 'Casablanca'),
    City(name: 'Cape Town'),
    City(name: 'Algiers'),
    City(name: 'Nairobi'),
    City(name: 'Addis Ababa'),
    City(name: 'Accra'),
    City(name: 'Kigali'),
    City(name: 'Abu Dhabi'),
    City(name: 'Doha'),
    City(name: 'Kuwait City'),
    City(name: 'Muscat'),
    City(name: 'Tel Aviv'),
    City(name: 'Amman'),
    City(name: 'Damascus'),
    City(name: 'Beirut'),
    City(name: 'Riyadh'),
    City(name: 'Ankara'),
    City(name: 'Kyiv'),
    City(name: 'Bucharest'),
    City(name: 'Sofia'),
    City(name: 'Belgrade'),
    City(name: 'Budapest'),
    City(name: 'Zagreb'),
    City(name: 'Ljubljana'),
    City(name: 'Sarajevo'),
    City(name: 'Vilnius'),
    City(name: 'Riga'),
    City(name: 'Tallinn'),
  ];
}
