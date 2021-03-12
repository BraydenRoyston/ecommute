import 'package:dio/dio.dart';
import '../model/distance.dart';
import '../model/row.dart';
import '../model/transport.dart';

class Trip {
  String origin;
  String destination;
  String travelType;
  bool roundTrip;
  double tripDistance;

  Trip(this.origin, this.destination, this.travelType, this.roundTrip);


  String makeUrl(String origin, String destination) {
    const key = "AlphaDMAFMomVfxEfghRroumrzE4jfnJUfvmpp1B";
    const beg = "https://maps.distancematrixapi.com/maps/api/distancematrix/json?origins=";
    const mid = "&destinations=";
    const end = "&departure_time=now&key=";

    var url = beg + origin + mid + destination + end + key;
    return(url);
  }

  Future<void> getDistance() async {
    var response = await Dio().get(makeUrl(this.origin, this.destination));
    Distance distance = Distance.fromData(response.data);
    CustomAPIRow dataRow = CustomAPIRow.fromData(distance.rows[0]);
    Transport transportData = Transport.fromData(dataRow.elements[0]);
    this.tripDistance = transportData.transportDistance.value / 1000;
    if (roundTrip) {
      this.tripDistance *= 2;
    }
    return;
  }
}