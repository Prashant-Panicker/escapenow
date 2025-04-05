import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireStorageService {
  FireStorageService._();
  static final instance = FireStorageService._();

  final _fireStorage = FirebaseStorage.instance.ref();

  Future<bool> deleteFile(String fileName) async {
    try {
      final desertRef = _fireStorage.child("user_image/$fileName");
      await desertRef.delete();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<String> getFirebaseStorageDownloadUrl(String imagePath) async {
    String storagePath =
        imagePath.replaceFirst('gs://escapetrialapp.appspot.com', '');

    Reference ref = _fireStorage.child(storagePath);

    return await ref.getDownloadURL();
  }

  Future<String> uploadImage(File file) async {
    Reference storageReference =
        _fireStorage.child("user_image/${file.path.split("/").last}");

    await storageReference.putFile(file);

    return storageReference.fullPath;
  }
}
