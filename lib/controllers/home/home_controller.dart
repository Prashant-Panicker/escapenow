import 'package:get/get.dart';
import 'package:escapenow/models/tour_model.dart';
import 'package:escapenow/network/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:escapenow/helpers/catch_storage.dart';
import 'package:escapenow/helpers/constants.dart';
import 'package:escapenow/views/auth/login_screen.dart';

class HomeController extends GetxController {
  bool isLoading = false;
  List<String> places = [];
  int currentIndex = 0;
  String placeseen = "";
  List<TourModel> tours = [];

  // Cache for storing fetched data
  Map<String, List<TourModel>> toursCache = {};

  @override
  onInit() async {
    super.onInit();
    isLoading = true;
    update();
    await getPlaces();
    await getTours(); // Fetch tours for all places and cache them
    placeseen = places[0];
    onChangePlace(placeseen, 0);
    isLoading = false;
    update();
  }

  Future<void> getPlaces() async {
    places = [];

    var value = await FirestoreServic.instance.getPlaces();

    var SelectForm = value.data()!["names"] as Map<String, dynamic>;

    for (var entry in SelectForm.entries) {
      places.add(entry.value);
    }

    update();
  }

  Future<void> onChangePlace(String newplace, int index) async {
    placeseen = newplace;
    currentIndex = index;
    print(placeseen);
    // Check if tours for the selected place are already in the cache
    getToursbyPlaces(placeseen);
    update();
  }

  Future<void> getTours() async {
    tours = [];

    var querySnapshot = await FirestoreServic.instance.getTours();

    for (var element in querySnapshot.docs) {
      tours.add(TourModel.fromJson(element.data()));
    }

    // Update the cache for all tours
    toursCache["all"] = tours;

    update();
  }

  Future<void> getToursbyPlaces(String place) async {
    tours = [];

    // Check if tours for the selected place are already in the cache
    if (toursCache.containsKey(place)) {
      tours = toursCache[place]!;
    } else {
      // If not, fetch tours from Firestore
      var querySnapshot = await FirestoreServic.instance.getTours();

      for (var element in querySnapshot.docs) {
        var tourModel = TourModel.fromJson(element.data());
        // Check if the tour belongs to the specified place
        if (tourModel.place == place) {
          tours.add(tourModel);
        }
      }

      // Update the cache
      toursCache[place] = tours;
    }

    update();
  }

  Future<void> logut() async {
    FirebaseAuth.instance.signOut();
    await CatchStorage.remove(k_userKey);
    Get.off(() => const LoginScreen());
  }
}
