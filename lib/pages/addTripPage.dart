import 'package:flutter/material.dart';
import '../model/trip.dart';
import '../model/distance.dart';
import '../model/row.dart';
import '../model/transport.dart';
import 'package:dio/dio.dart';
import 'dart:math';


class AddTripPage extends StatefulWidget {
  AddTripPage({Key key, @required this.addTripFunction, @required this.context, this.totalDistance, this.distanceBudget, this.co2}) : super(key: key);
  final Future<void> Function(Trip trip, BuildContext thisContext) addTripFunction;
  final BuildContext context;
  final double totalDistance;
  final double distanceBudget;
  final double co2;

  @override
  _AddTripPageState createState() => _AddTripPageState();
}

class _AddTripPageState extends State<AddTripPage> {
  String _origin = "";
  String _destination = "";
  double _tripDistance = 0;
  String _travelMethod = "Gas Car";
  bool _distanceLoading = true;
  bool _roundTrip = null;
  double divisor = 0.171;

  String makeUrl(String origin, String destination) {
    const key = "AlphaDMAFMomVfxEfghRroumrzE4jfnJUfvmpp1B";
    const beg = "https://maps.distancematrixapi.com/maps/api/distancematrix/json?origins=";
    const mid = "&destinations=";
    const end = "&departure_time=now&key=";

    var url = beg + origin + mid + destination + end + key;
    return(url);
  }

  Future<void> getDistance() async {
    var response = await Dio().get(makeUrl(_origin, _destination));
    Distance distance = Distance.fromData(response.data);
    CustomAPIRow dataRow = CustomAPIRow.fromData(distance.rows[0]);
    Transport transportData = Transport.fromData(dataRow.elements[0]);
    _tripDistance = transportData.transportDistance.value / 1000;
    if (_roundTrip) {
      _tripDistance *= 2;
    }
    setState(() {
      _tripDistance = _tripDistance;
    });
    return;
  }
  Future<void> calcNewTrip() async {
    await getDistance();
    setState(() {
      _distanceLoading = false;
    });
  }
  void setTravelGasCar() {
    setState(() {
      _travelMethod = "Gas Car";
      divisor = 0.171;
    });
  }
  void setTravelElectricCar() {
    setState(() {
      _travelMethod = "Carpool";
      divisor = 0.085;
    });
  }
  void setTravelBus() {
    setState(() {
      _travelMethod = "Bus";
      divisor = 0.104;
    });
  }
  void setTravelBike() {
    setState(() {
      _travelMethod = "Bike";
      divisor = 0.0;
    });
  }
  void setTravelWalk() {
    setState(() {
      _travelMethod = "Plane";
      divisor = 0.041;
    });
  }
  void setRoundTrip() {
    setState(() {
      _roundTrip = true;
    });
  }
  void setOneWay() {
    setState(() {
      _roundTrip = false;
    });
  }
  void setOrigin(String text) {
    setState(() {
      _origin = text;
    });
  }
  void setDestination(String text) {
    setState(() {
      _destination = text;
    });
  }


  @override
  Widget build(BuildContext context) {
    final trip = new Trip(_origin, _destination, _travelMethod, _roundTrip);
    return Scaffold(
      appBar: AppBar(
        title: Text('New Trip'),
      ),
      body: Column(
      children: [
        SizedBox(height: 30,),
        Text(
          "Origin Address",
        style: const TextStyle(
            color:  const Color(0xff000000),
            fontWeight: FontWeight.w600,
            fontFamily: "SFProText",
            fontStyle:  FontStyle.normal,
            fontSize: 20.0
          ),
        ),
        SizedBox(height: 20),
        Container(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
            onChanged: (text) {
              setOrigin(text);
            },
          ),
          padding: EdgeInsets.symmetric(horizontal: 50)
        ),
        SizedBox(height: 20),
        Text(
        "Destination address",
        style: const TextStyle(
            color:  const Color(0xff000000),
            fontWeight: FontWeight.w600,
            fontFamily: "SFProText",
            fontStyle:  FontStyle.normal,
            fontSize: 20.0
          ),
        ),
        SizedBox(height: 20),
        Container(
          child: TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder()
            ),
            onChanged: (text) {
              setDestination(text);
            },
          ),
          padding: EdgeInsets.symmetric(horizontal: 50)
        ),
        SizedBox(height: 20),
        Text(
        "Travel Method",
        style: const TextStyle(
            color:  const Color(0xff000000),
            fontWeight: FontWeight.w600,
            fontFamily: "SFProText",
            fontStyle:  FontStyle.normal,
            fontSize: 20.0
          ),
        ),
        SizedBox(height: 20),
        Container(
          height: 60,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              SizedBox(width: 15,),
              ElevatedButton(
                child: Text(
                  "Gas Car",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "SFProText",
                    fontWeight: FontWeight.w600,
                  )
                ),
                onPressed: () {
                  setTravelGasCar();
                },
                style: ElevatedButton.styleFrom(
                  primary: _travelMethod == "Gas Car" ? Colors.black : const Color(0x99000000),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                )
              ),
              SizedBox(width: 15,),
              ElevatedButton(
                child: Text(
                  "Carpool",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "SFProText",
                    fontWeight: FontWeight.w600,
                  )
                ),
                onPressed: () {
                  setTravelElectricCar();
                },
                style: ElevatedButton.styleFrom(
                  primary: _travelMethod == "Carpool" ? Colors.black : const Color(0x99000000),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                )
              ),
              SizedBox(width: 15,),
              ElevatedButton(
                child: Text(
                  "Bus",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "SFProText",
                    fontWeight: FontWeight.w600,
                  )
                ),
                onPressed: () {
                  setTravelBus();
                },
                style: ElevatedButton.styleFrom(
                  primary: _travelMethod == "Bus" ? Colors.black : const Color(0x99000000),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                )
              ),
              SizedBox(width: 15,),
              ElevatedButton(
                child: Text(
                  "Bike",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "SFProText",
                    fontWeight: FontWeight.w600,
                  )
                ),
                onPressed: () {
                  setTravelBike();
                },
                style: ElevatedButton.styleFrom(
                  primary: _travelMethod == "Bike" ? Colors.black : const Color(0x99000000),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                )
              ),
              SizedBox(width: 15,),
              ElevatedButton(
                child: Text(
                  "Plane",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontFamily: "SFProText",
                    fontWeight: FontWeight.w600,
                  )
                ),
                onPressed: () {
                  setTravelWalk();
                },
                style: ElevatedButton.styleFrom(
                  primary: _travelMethod == "Plane" ? Colors.black : const Color(0x99000000),
                  padding: EdgeInsets.symmetric(horizontal: 40),
                )
              ),
            ],
          ),
        ),
        SizedBox(height: 15),
        Text(
        "Trip Type",
        style: const TextStyle(
            color:  const Color(0xff000000),
            fontWeight: FontWeight.w600,
            fontFamily: "SFProText",
            fontStyle:  FontStyle.normal,
            fontSize: 20.0
          ),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: Text(
                "Round Trip",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: "SFProText",
                  fontWeight: FontWeight.w600,
                )
              ),
              onPressed: () {
                _roundTrip = true;
                calcNewTrip();
              },
              style: ElevatedButton.styleFrom(
                primary: _roundTrip == true ? Colors.black : const Color(0x99000000),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              )
            ),
            SizedBox(width: 25,),
            ElevatedButton(
              child: Text(
                " One Way ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontFamily: "SFProText",
                  fontWeight: FontWeight.w600,
                )
              ),
              onPressed: () {
                _roundTrip = false;
                calcNewTrip();
              },
              style: ElevatedButton.styleFrom(
                primary: _roundTrip == false ? Colors.black : const Color(0x99000000),
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              )
            ),
        ],),
        SizedBox(height: 20),
        Container(
          child: _distanceLoading ?
          Column(
            children: [
              Text(
              "Fill in all fields!",
              style: const TextStyle(
                  color:  const Color(0xff000000),
                  fontWeight: FontWeight.w600,
                  fontFamily: "SFProText",
                  fontStyle:  FontStyle.normal,
                  fontSize: 20.0
                ),
              ),
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
          )
          : Column(
            children: [
              RichText(
                text: TextSpan(
                  text: 'New Total Kilometres Traveled Today: ',
                  style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w300),
                  children: <TextSpan>[
                    TextSpan(text: (widget.totalDistance + _tripDistance).toStringAsFixed(1)),
                    TextSpan(text: " km"),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: LinearProgressIndicator(
                  value: min(1, (widget.co2 + _tripDistance * divisor) / (widget.distanceBudget)),
                  backgroundColor: Colors.grey,
                  valueColor: AlwaysStoppedAnimation<Color>
                  (Colors.black),
                  minHeight: 40,
                ),
              ),
              SizedBox(height: 10),
              RichText(
                text: TextSpan(
                  text: 'Updated CO2 Limit: ',
                  style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w300),
                  children: <TextSpan>[
                    TextSpan(text: ((widget.co2 + _tripDistance * divisor)).toStringAsFixed(3)),
                    TextSpan(text: "/"),
                    TextSpan(text: (widget.distanceBudget).toStringAsFixed(3)),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                child: (widget.co2 + _tripDistance * divisor) < (widget.distanceBudget) ? 
                RichText(
                  text: TextSpan(
                    text: 'This trip adds ',
                    style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),
                    children: <TextSpan>[
                      TextSpan(text: (_tripDistance).toStringAsFixed(3)),
                      TextSpan(text: "km ("),
                      TextSpan(text: ((_tripDistance) * divisor).toStringAsFixed(3)),
                      TextSpan(text: " kg of CO2) to your trip."),
                      TextSpan(text: "You're staying under your carbon budget!", style: TextStyle(color: Colors.green))

                    ],
                  ),
                  textAlign: TextAlign.center,
                ) :
                RichText(
                  text: TextSpan(
                    text: 'This trip adds ',
                    style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w600),
                    children: <TextSpan>[
                      TextSpan(text: (_tripDistance).toStringAsFixed(3)),
                      TextSpan(text: "km ("),
                      TextSpan(text: ((_tripDistance) * divisor).toStringAsFixed(3)),
                      TextSpan(text: " kg of CO2) to your trip."),
                      TextSpan(text: "You're going to go over your carbon budget!", style: TextStyle(color: Colors.red)),
                      TextSpan(text: " Try a more efficient method of travel like car pooling!"),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
        Spacer(),
        SizedBox(height: 10),
        ElevatedButton(
          child: Text(
            " Add Trip ",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontFamily: "SFProText",
              fontWeight: FontWeight.w600,
            )
          ),
          onPressed: () {
            final newTrip = new Trip(_origin, _destination, _travelMethod, _roundTrip);
            widget.addTripFunction(newTrip, context);
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            primary: Colors.black,
            padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
          )
        ),
        SizedBox(height: 20,)
      ],
    ),
    );
  }
}
