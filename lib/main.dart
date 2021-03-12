import 'package:flutter/material.dart';
import 'pages/home.dart';
import './model/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.black,
        accentColor: Colors.black,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xfff1f2f5),
      ),
      home: MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _travelMethod = "Gas Car";
  String _origin = "";
  String _destination = "";

  void setTravelGasCar() {
    setState(() {
      _travelMethod = "Gas Car";
    });
  }
  void setTravelElectricCar() {
    setState(() {
      _travelMethod = "Carpool";
    });
  }
  void setTravelBus() {
    setState(() {
      _travelMethod = "Bus";
    });
  }
  void setTravelBike() {
    setState(() {
      _travelMethod = "Bike";
    });
  }
  void setTravelWalk() {
    setState(() {
      _travelMethod = "Plane";
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
    final user = new User(_travelMethod, _origin, _destination,);
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              child: Image.asset('assets/images/Logo_ecommute.png')
            ),
            Container(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/Destination Icon.png')
            ),
            SizedBox(height: 20),
            Text(
            "Home Address",
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
                  setOrigin(text);
                },
              ),
              padding: EdgeInsets.symmetric(horizontal: 50)
            ),
            SizedBox(height: 35),
            Text(
            "Work address",
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
                  setDestination(text);
                },
              ),
              padding: EdgeInsets.symmetric(horizontal: 50)
            ),
            SizedBox(height: 35,),
            Text(
            "How do you usually commute?",
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
            SizedBox(height: 35),
            ElevatedButton(
              child: Text("Continue"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => 
                  HomePage(
                    user: user,
                  )),
                );
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                textStyle: TextStyle(
                  fontSize: 20,
                  fontFamily: "SFProText",
                  fontWeight: FontWeight.w600,
                )
              )
            ),
          ],
        ),
      ),
    );
  }
}
