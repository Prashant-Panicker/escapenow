import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:escapenow/helpers/catch_storage.dart';
import 'package:escapenow/helpers/constants.dart';
// import 'package:escapenow/models/card_model.dart';
import 'package:escapenow/models/user_model.dart';

class FirestoreServic {
  FirestoreServic._();
  static final instance = FirestoreServic._();

  final _db = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;

  Future<void> saveUser(UserModel model) async {
    await _db.collection("users").doc(model.uId).set(model.toMap);
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getUser(String uId) async {
    return await _db.collection("users").doc(uId).get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getPlaces() async {
    String lang = CatchStorage.get(k_langKey) ?? "en";
    return await _db.collection(lang).doc("continents").get();
  }

  // Future<DocumentSnapshot<Map<String, dynamic>>> getPopularCategories() async {
  //   String lang = CatchStorage.get(k_langKey) ?? "en";
  //   return await _db.collection(lang).doc("Popular_Categories").get();
  // }

  Future<QuerySnapshot<Map<String, dynamic>>> getTours() async {
    String lang = CatchStorage.get(k_langKey) ?? "en";
    return await _db.collection(lang).doc("Tours").collection("all").get();
  }

  // Future<DocumentReference<Map<String, dynamic>>> addNewCard(
  //     CardModel model) async {
  //   return await _db
  //       .collection("users")
  //       .doc(_auth.currentUser!.uid)
  //       .collection("cards")
  //       .add(model.toMap);
  // }

  Future<void> updateUser(UserModel model) async {
    return await _db
        .collection("users")
        .doc(_auth.currentUser!.uid)
        .set(model.toMap);
  }
}
