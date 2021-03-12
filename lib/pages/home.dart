import 'dart:math';
import 'package:flutter/material.dart';
import '../model/trip.dart';
import '../widgets/tripCard.dart';
import '../model/user.dart';
import '../pages/donate.dart';
import '../pages/addTripPage.dart';
import 'dart:io';


class HomePage extends StatefulWidget {
  HomePage({Key key, @required this.user}) : super(key: key);
  final User user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Trip newTrip;
  List<TripCard> user_trips = [];

  bool loading = true;


  Future<void> asyncFunction() async {
    await widget.user.makeMainDistance();
    await widget.user.calculateBudget();
    newTrip = new Trip(widget.user.mainOrigin, widget.user.mainDestination, widget.user.mainTravelMethod, true);
    TripCard newTripCard = new TripCard(trip: newTrip, dummy: false, addTripFunction: addNewTrip, context: context, totalDistance: widget.user.totalDistance, distanceBudget: widget.user.budget,);
    setState(() {
      widget.user.trips.add(newTrip);
      widget.user.tripCards.add(newTripCard);
      user_trips = widget.user.tripCards;
      loading = false;
    });
  }

  void rebuildAllChildren(BuildContext context) {
    void rebuild(Element el) {
      el.markNeedsBuild();
      el.visitChildren(rebuild);
    }
    (context as Element).visitChildren(rebuild);
  } 

  Future<void> addNewTrip(Trip trip, BuildContext thisContext) async {
    await trip.getDistance();
    TripCard newTripCard = new TripCard(trip: trip, dummy: false, addTripFunction: addNewTrip, context: context);
    setState(() {
      TripCard dummyCard = new TripCard(trip: newTrip, dummy: true, addTripFunction: addNewTrip, context: context, totalDistance: widget.user.totalDistance, distanceBudget: widget.user.budget,);
      List<TripCard> dummyList = [dummyCard];
      widget.user.tripCards.replaceRange(0, 1, dummyList);
      widget.user.trips.add(trip);
      widget.user.tripCards.add(newTripCard);
      widget.user.calculateTotalDistance();
      user_trips = widget.user.tripCards;
    });
  }

  @override
  void initState() {
    asyncFunction();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: loading ? 
      Center( child:
        CircularProgressIndicator()
      )
      :
      Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
            "My Daily Limit",
            style: const TextStyle(
                color:  const Color(0xff000000),
                fontWeight: FontWeight.w600,
                fontFamily: "SFProText",
                fontStyle:  FontStyle.normal,
                fontSize: 25.0
            ),
            textAlign: TextAlign.left                
            ),
            SizedBox(height: 20,),
            RichText(
              text: TextSpan(
                text: 'Kilometres Traveled: ',
                style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(text: widget.user.totalDistance.toStringAsFixed(0)),
                  TextSpan(text: " km"),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                value: min(1, (widget.user.co2) / widget.user.budget),
                backgroundColor: Colors.grey,
                valueColor: AlwaysStoppedAnimation<Color>
                (Colors.black),
                minHeight: 40, 
              ),
            ),
            SizedBox(height: 20),
            RichText(
              text: TextSpan(
                text: 'My CO2 Limit: ',
                style: TextStyle(fontSize: 17, color: Colors.black, fontWeight: FontWeight.w500),
                children: <TextSpan>[
                  TextSpan(text: (widget.user.co2).toStringAsFixed(3)),
                  TextSpan(text: "/"),
                  TextSpan(text: (widget.user.budget).toStringAsFixed(3)),
                ],
              ),
            ),
            SizedBox(height: 10),
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
                    TextSpan(text: " Excellent job, you're staying under your carbon budget!", style: TextStyle(color: Colors.green, fontWeight: FontWeight.w600))

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
                    TextSpan(text: " Unfortunately, you've gone over your carbon budget!", style: TextStyle(color: Colors.red, fontWeight: FontWeight.w600)),
                    TextSpan(text: " Consider donating below to offset the pollution."),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              padding: EdgeInsets.symmetric(horizontal: 20),
            ),
            SizedBox(height: 10),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.black),
                  borderRadius: BorderRadius.circular(5)),
              child: Container(
                child: ElevatedButton(
                      child: Text("Add New Trip", style: TextStyle(color: Colors.black, fontSize: 15,)),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => 
                          AddTripPage(
                            addTripFunction: addNewTrip, context: context, totalDistance: widget.user.totalDistance, distanceBudget: widget.user.budget, co2: widget.user.co2,
                          )),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.white,
                        padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        textStyle: TextStyle(
                          fontSize: 20,
                          fontFamily: "SFProText",
                          fontWeight: FontWeight.w600,
                        )
                      )
                  ),
              )
            ),
            Container(
              height: 350,
              child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.all(8),
                children: user_trips,
              ),
            ),
            Spacer(),
            ElevatedButton(
              child: Text(
                " Donate ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontFamily: "SFProText",
                  fontWeight: FontWeight.w600,
                )
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => 
                  Donate(
                    user: widget.user,
                  )),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
              )
            ),
            SizedBox(height: 20),
          ],
        ),
    );
  }
}