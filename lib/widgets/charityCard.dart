import 'package:flutter/material.dart';
import '../pages/charity.dart';
import '../model/trip.dart';
import '../pages/addTripPage.dart';

class DonateCard extends StatefulWidget {
  DonateCard({Key key, @required this.title, @required this.desc, @required this.imgPath, @required this.credit}) : super(key: key);
  final String title;
  final String desc;
  final String imgPath;
  final double credit;
  @override
  _DonateCardState createState() => _DonateCardState();
}

class _DonateCardState extends State<DonateCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.black),
          borderRadius: BorderRadius.circular(5)),
      child: Container(
        child: ElevatedButton(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 30),
                Container(
                child: Image.asset(widget.imgPath)),
                SizedBox(width: 40),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.title, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
                    SizedBox(height: 30),
                    Text(widget.desc, style: TextStyle(fontWeight: FontWeight.w200, color: Colors.black, fontSize: 15,))
                  ],
                )
              ],
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => 
                  CharityPage(
                    charity: widget.title, credit: widget.credit, desc: widget.desc, imagePath: widget.imgPath,
                  )),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 0, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: "SFProText",
                  fontWeight: FontWeight.w600,
                )
              )
          ),
      )
    );
  }
}
