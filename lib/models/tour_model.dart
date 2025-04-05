import 'package:cloud_firestore/cloud_firestore.dart';

class TourModel {
  String? place;
  String? image;
  String? overview;
  List<String>? images;
  String? title;
  int? price; // Replaced startedPrice with Price
  int? durationDay;
  String? id;
  String? category;
  String? details;
  Timestamp? startdate;

  TourModel({
    this.place,
    this.image,
    this.overview,
    this.images,
    this.title,
    this.price, // Updated property name
    this.durationDay,
    this.id,
    this.category,
    this.details,
    this.startdate,
  });

  factory TourModel.fromJson(Map<String, dynamic> json) {
    return TourModel(
      place: json['place'],
      image: json['image'],
      overview: json['overview'],
      images: List<String>.from(json['images'] ?? []),
      title: json['title'],
      price: json['price'], // Updated property name
      durationDay: json['durationDay'],
      id: json['id'],
      category: json['category'],
      details: json['details'],
      startdate: json['startdate'] != null
          ? Timestamp.fromMillisecondsSinceEpoch(json['startdate'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'continent': place,
      'image': image,
      'overview': overview,
      'images': images,
      'title': title,
      'price': price, // Updated property name
      'durationDay': durationDay,
      'id': id,
      'category': category,
      'details': details,
      'startdate': startdate != null ? startdate!.millisecondsSinceEpoch : null,
    };
  }
}
