import 'package:flutter/material.dart';
import '../widgets/charityCard.dart';


class CharityPage extends StatefulWidget {
  CharityPage({Key key, @required this.charity, @required this.imagePath, @required this.desc, @required this.credit}) : super(key: key);
  final String charity;
  final String desc;
  final String imagePath;
  final double credit;
  @override
  _CharityPageState createState() => _CharityPageState();
}

class _CharityPageState extends State<CharityPage> {
  String _paymentMethod = "";

  void setPaymentBank() {
    setState(() {
      _paymentMethod = "Bank Card";
    });
  }
  void setPaymentGoogle() {
    setState(() {
      _paymentMethod = "Google";
    });
  }
  void setPaymentApple() {
    setState(() {
      _paymentMethod = "Apple";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Donate"),),
      body: Column(
        children: [
          SizedBox(height: 20),
          DonateCard(
            title: widget.charity,
            desc: widget.desc,
            imgPath: widget.imagePath,
            credit: widget.credit
          ),
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
                    TextSpan(text: widget.credit.toStringAsFixed(2)),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(width: 20),
            ],
          ),
          SizedBox(height: 20),
          Text(
            "Donation Amount",
            style: const TextStyle(
              color:  const Color(0xff000000),
              fontWeight: FontWeight.w600,
              fontFamily: "SFProText",
              fontStyle:  FontStyle.normal,
              fontSize: 15.0
            ),
          ),
          SizedBox(height: 20),
          Container(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
              onChanged: (text) {
                return;
              },
            ),
            height: 35,
            padding: EdgeInsets.symmetric(horizontal: 50)
          ),
          SizedBox(height: 20),
          Text(
            "What's your payment method?",
            style: const TextStyle(
              color:  const Color(0xff000000),
              fontWeight: FontWeight.w600,
              fontFamily: "SFProText",
              fontStyle:  FontStyle.normal,
              fontSize: 15.0
          ),),
          SizedBox(height: 20),
          Container(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                SizedBox(width: 15,),
                ElevatedButton(
                  child: Text(
                    "Bank Card",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "SFProText",
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  onPressed: () {
                    setPaymentBank();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _paymentMethod == "Bank Card" ? Colors.black : const Color(0x99000000),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                  )
                ),
                SizedBox(width: 15,),
                ElevatedButton(
                  child: Text(
                    "Google Pay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "SFProText",
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  onPressed: () {
                    setPaymentGoogle();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _paymentMethod == "Google" ? Colors.black : const Color(0x99000000),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                  )
                ),
                SizedBox(width: 15,),
                ElevatedButton(
                  child: Text(
                    "Apple Pay",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontFamily: "SFProText",
                      fontWeight: FontWeight.w600,
                    )
                  ),
                  onPressed: () {
                    setPaymentApple();
                  },
                  style: ElevatedButton.styleFrom(
                    primary: _paymentMethod == "Apple" ? Colors.black : const Color(0x99000000),
                    padding: EdgeInsets.symmetric(horizontal: 40),
                  )
                ),
              ],
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "Payment Details",
            style: const TextStyle(
              color:  const Color(0xff000000),
              fontWeight: FontWeight.w600,
              fontFamily: "SFProText",
              fontStyle:  FontStyle.normal,
              fontSize: 15.0
          ),),
          SizedBox(height: 10,),
          Text(
            "Cardholder Name",
            style: const TextStyle(
              color:  const Color(0xff000000),
              fontWeight: FontWeight.w400,
              fontFamily: "SFProText",
              fontStyle:  FontStyle.normal,
              fontSize: 13.0
            ),
          ),
          SizedBox(height: 5),
          Container(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
              onChanged: (text) {
                return;
              },
            ),
            height: 35,
            padding: EdgeInsets.symmetric(horizontal: 50)
          ),
          SizedBox(height: 10),
          Text(
          "Card Number",
          style: const TextStyle(
              color:  const Color(0xff000000),
              fontWeight: FontWeight.w400,
              fontFamily: "SFProText",
              fontStyle:  FontStyle.normal,
              fontSize: 13.0
            ),
          ),
          SizedBox(height: 5),
          Container(
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder()
              ),
              onChanged: (text) {
                return;
              },
            ),
            height: 35,
            padding: EdgeInsets.symmetric(horizontal: 50)
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                width: 200,
                child: Column(children: [
                  Text(
                  "Expiration Date",
                  style: const TextStyle(
                      color:  const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProText",
                      fontStyle:  FontStyle.normal,
                      fontSize: 13.0
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder()
                      ),
                      onChanged: (text) {
                        return;
                      },
                    ),
                    height: 35,
                    padding: EdgeInsets.symmetric(horizontal: 50)
                  ),
                ],),
              ),
              Spacer(),
              Container(
                width: 200,
                child: Column(children: [
                  Text(
                  "CVV",
                  style: const TextStyle(
                      color:  const Color(0xff000000),
                      fontWeight: FontWeight.w400,
                      fontFamily: "SFProText",
                      fontStyle:  FontStyle.normal,
                      fontSize: 13.0
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder()
                      ),
                      onChanged: (text) {
                        return;
                      },
                    ),
                    height: 35,
                    padding: EdgeInsets.symmetric(horizontal: 50)
                  ),
                ],),
              )
            ],
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
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.black,
              padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
            )
          ),
          SizedBox(height: 50,)
        ],
      ),
    );
  }
}
