import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:escapenow/models/tour_model.dart';
import 'package:escapenow/network/firestore_service.dart';

class SearchResultsController extends GetxController {
  bool isLoading = false;

  List<TourModel> results = [];


  Future<void> searching({
    String? city,
    DateTime? checkIn,
    DateTime? checkOut,
  }) async {
    results = [];
    isLoading = true;
    update();

    var querySnapshot = await FirestoreServic.instance.getTours();

    String? convertCityToLowerCase = city!.toLowerCase();

    for (var element in querySnapshot.docs) {
      String convertElementTextToLower =
          element.data()["continent"].toString().toLowerCase();

      // Extracting tour's start date and duration
      DateTime tourStartDate =
          (element.data()["Start_date"] as Timestamp).toDate();
      int tourDuration = element.data()["duration_day"] ?? 0;

      // Checking if the dates match the criteria
      if (checkIn!.isBefore(tourStartDate) &&
          checkOut!.isAfter(tourStartDate.add(Duration(days: tourDuration))) &&
          convertElementTextToLower.contains(convertCityToLowerCase)) {
        results.add(TourModel.fromJson(element.data()));
      }
    }

    isLoading = false;
    update();
  }
}
