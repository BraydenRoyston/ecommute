import 'package:flutter/material.dart';
import 'dart:math';
import '../model/trip.dart';
import '../widgets/tripCard.dart';
import '../model/user.dart';
import '../widgets/charityCard.dart';

class Donate extends StatefulWidget {
  Donate({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  _DonateState createState() => _DonateState();
}

class _DonateState extends State<Donate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donate"),),
      body: Column(
        children: [
          SizedBox(height: 20),
          Row(
            children: [
              SizedBox(width: 25),
              Text(
              "My Carbon Offset Balance:",
              style: const TextStyle(
                    color:  const Color(0xff000000),
                    fontWeight: FontWeight.w600,
                    fontFamily: "SFProText",
                    fontStyle:  FontStyle.normal,
                    fontSize: 20.0
                ),
                textAlign: TextAlign.left                
              ),
              Spacer(),
              RichText(
                text: TextSpan(
                  text: "\$",
                  style: TextStyle(fontSize: 20, color: const Color(0xff000000), fontWeight: FontWeight.w600),
                  children: <TextSpan>[
                    TextSpan(text: max(((widget.user.budget - widget.user.co2)), 0).toStringAsFixed(2)),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 25),
          Container(
            child: (widget.user.co2) < (widget.user.budget) ? 
            RichText(
              text: TextSpan(
                text: 'Today, you\'ve traveled ',
                style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(text: (widget.user.totalDistance).toStringAsFixed(3)),
                  TextSpan(text: " km (releasing "),
                  TextSpan(text: (widget.user.co2).toStringAsFixed(3)),
                  TextSpan(text: " kg of CO2 into the atmosphere)."),
                  TextSpan(text: " Excellent job, you're staying under your carbon budget! You can use some of your credits to donate to these awesome causes!", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600))

                ],
              ),
              textAlign: TextAlign.center,
            ) :
            RichText(
              text: TextSpan(
                text: 'Today, you\'ve traveled ',
                style: TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.w400),
                children: <TextSpan>[
                  TextSpan(text: (widget.user.totalDistance).toStringAsFixed(3)),
                  TextSpan(text: "km (releasing "),
                  TextSpan(text: (widget.user.co2).toStringAsFixed(3)),
                  TextSpan(text: " kg of CO2 into the atmosphere)."),
                  TextSpan(text: " Unfortunately, you've gone over your carbon budget and have no credits!", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                  TextSpan(text: " Consider donating below to offset the pollution."),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            padding: EdgeInsets.symmetric(horizontal: 20),
          ),
          DonateCard(
            title: "One Tree Planted",
            desc: "\"Mo' trees less problems\"",
            imgPath: 'assets/images/tree.png',
            credit: max(((widget.user.budget - widget.user.co2)), 0),
          ),
          DonateCard(
            title: "Save the Polar Bears",
            desc: "\"Ice, ice...\"",
            imgPath: 'assets/images/bear.png',
            credit: max(((widget.user.budget - widget.user.co2)), 0),
          ),
          DonateCard(
            title: "Coral Reef Alliance",
            desc: "\"Fish can swim too.\"",
            imgPath: 'assets/images/fish.png',
            credit: max(((widget.user.budget - widget.user.co2)), 0),
          ),
          DonateCard(
            title: "World Wild Life",
            desc: "\"Free the pandas.\"",
            imgPath: 'assets/images/panda.png',
            credit: max(((widget.user.budget - widget.user.co2)), 0),
          ),

        ],
      ),
    );
  }
}
