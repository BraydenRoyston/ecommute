import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../model/distance.dart';
import '../model/row.dart';
import '../model/transport.dart';
import '../widgets/tripCard.dart';
import '../model/trip.dart';

class User {
  String mainTravelMethod;
  String mainOrigin;
  String mainDestination;
  double mainDistance;
  double budget = 0;
  double co2Limit = 0;
  double co2 = 0;
  List<Trip> trips = [];
  List<TripCard> tripCards = [];
  double totalDistance = 0;

  double carConstant = 0.171;
  double flightConstant = 0.254;
  double busConstant = 0.104;
  double carpoolConstant = 0.085;
  double trainConstant = 0.041;
  double bikeConstant = 0;

  User(this.mainTravelMethod, this.mainOrigin, this.mainDestination);

  String makeUrl(String origin, String destination) {
    const key = "AlphaDMAFMomVfxEfghRroumrzE4jfnJUfvmpp1B";
    const beg = "https://maps.distancematrixapi.com/maps/api/distancematrix/json?origins=";
    const mid = "&destinations=";
    const end = "&departure_time=now&key=";

    var url = beg + origin + mid + destination + end + key;
    return(url);
  }

  void calculateTotalDistance() {
    totalDistance = 0;
    co2 = 0;
    trips.forEach((element) {
      if (element.travelType == "Gas Car") {
        totalDistance += element.tripDistance;
        co2 += element.tripDistance * carConstant;
      }
      else if (element.travelType == "Carpool") {
        totalDistance += element.tripDistance;
        co2 += element.tripDistance * carpoolConstant;
      }
      else if (element.travelType == "Bus") {
        totalDistance += element.tripDistance;
        co2 += element.tripDistance * busConstant;
      }
      else if (element.travelType == "Bike") {
        totalDistance += element.tripDistance;
        co2 += element.tripDistance * bikeConstant;
      }
      else if (element.travelType == "Plane") {
        totalDistance += element.tripDistance;
        co2 += element.tripDistance * flightConstant;
      }
    });
    
  }

  void makeMainDistance() async {
    var response = await Dio().get(makeUrl(this.mainOrigin, this.mainDestination));
    Distance distance = Distance.fromData(response.data);
    CustomAPIRow dataRow = CustomAPIRow.fromData(distance.rows[0]);
    Transport transportData = Transport.fromData(dataRow.elements[0]);
    this.mainDistance = transportData.transportDistance.value / 1000;
    this.mainDistance *= 2;
    this.totalDistance += this.mainDistance;
    this.co2 += this.mainDistance * carConstant;
    return;
  }

  void calculateBudget() {
    if (this.mainTravelMethod == "Gas Car") {
      this.budget = this.mainDistance * 1.3 * carConstant;
      this.co2Limit = this.budget * carConstant;
    }
    else if (this.mainTravelMethod == "Carpool") {
      this.budget = this.mainDistance * 2.5;
      this.co2Limit = this.budget * carpoolConstant;
    }
    else if (this.mainTravelMethod == "Bus") {
      this.budget = this.mainDistance * 2.3;
      this.co2Limit = this.budget * busConstant;
    }
    else if (this.mainTravelMethod == "Bike") {
      this.budget = this.mainDistance * 10.0;
      this.co2Limit = this.budget * 10000;
    }
    else if (this.mainTravelMethod == "Walk") {
      this.budget = this.mainDistance * 10.0;
      this.co2Limit = this.budget * 10000;
    }
  }
}