import 'package:flutter/material.dart';
import '../model/trip.dart';
import '../pages/addTripPage.dart';


class TripCard extends StatefulWidget {
  TripCard({Key key, @required this.trip, @required this.dummy, @required this.addTripFunction, this.context, this.totalDistance, this.distanceBudget}) : super(key: key);
  final Trip trip;
  final bool dummy;
  final Future<void> Function(Trip trip, BuildContext thisContext) addTripFunction;
  final BuildContext context;
  final double totalDistance;
  final double distanceBudget;

  @override
  _TripCardState createState() => _TripCardState();
}

class _TripCardState extends State<TripCard> {
  bool loading = true;

  Future<void> asyncFunction() async {
    await widget.trip.getDistance();
    setState(() {
      loading = false;
    });
  }

  @override
  void initState() {
    asyncFunction();
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Widget icon;
    if (widget.trip.travelType == "Gas Car") {
      icon = Icon(
        Icons.directions_car,
        size: 80
      );
    }
    else if (widget.trip.travelType == "Carpool") {
      icon = Icon(
        Icons.family_restroom,
        size: 80
      );
    }
    else if (widget.trip.travelType == "Bus") {
      icon =  Icon(
        Icons.directions_bus,
        size: 80
      );
    }
    else if (widget.trip.travelType == "Bike") {
      icon = Icon(
        Icons.directions_bike,
        size: 80
      );
    }
    else if (widget.trip.travelType == "Plane") {
      icon = Icon(
        Icons.airplanemode_active,
        size: 80
      );
    }
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5)),
      child: loading ? 
      Center(child: Container(height: 30, width: 30, child: CircularProgressIndicator()))
      : Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 20),
                  Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.trip.roundTrip == true ? 
                      Text("Round Trip")
                      : Text("One Way"),
                      RichText(
                        text: TextSpan(
                          text: 'From ',
                          style: TextStyle(fontSize: 9, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: widget.trip.origin),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'To ',
                          style: TextStyle(fontSize: 9, color: Colors.black),
                          children: <TextSpan>[
                            TextSpan(text: widget.trip.destination),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          text: 'Distance: ',
                          style: DefaultTextStyle.of(context).style,
                          children: <TextSpan>[
                            TextSpan(text: widget.trip.tripDistance.toString()),
                            TextSpan(text: "km"),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    child: icon,
                  ),
                  SizedBox(width: 20),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
