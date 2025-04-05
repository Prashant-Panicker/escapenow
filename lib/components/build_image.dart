import 'package:escapenow/network/firestorage_service.dart';
import 'package:flutter/material.dart';
import '../helpers/catch_storage.dart';

class BuildImage extends StatelessWidget {
  const BuildImage({
    Key? key,
    required this.image,
    this.borderRadius = 15,
    this.width,
    this.height,
    this.fit,
  }) : super(key: key);

  final String image;
  final double? borderRadius;
  final double? width;
  final double? height;
  final BoxFit? fit;

  @override
  Widget build(BuildContext context) {
    late Widget imageWidget;

    if (!image.startsWith('assets/')) {
      // Firebase Storage path
      String cacheKey = 'image_cache_$image';

      String? cachedImageUrl = CatchStorage.get(cacheKey);

      if (cachedImageUrl != null) {
        // Load image directly from cache
        imageWidget = FadeInImage(
          fit: fit ?? BoxFit.cover,
          placeholder: const AssetImage("assets/images/placeholder.jpg"),
          image: NetworkImage(cachedImageUrl),
          imageErrorBuilder: (BuildContext, Object, StackTrace) =>
              Image.asset("assets/images/placeholder.jpg"),
        );
      } else {
        // Fetch image from Firebase Storage
        imageWidget = FutureBuilder<String>(
          future: Future.delayed(const Duration(seconds: 3), () {
            return FireStorageService.instance
                .getFirebaseStorageDownloadUrl(image);
          }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              // Cache the image
              CatchStorage.save(cacheKey, snapshot.data);

              return FadeInImage(
                fit: fit ?? BoxFit.cover,
                placeholder: const AssetImage("assets/images/placeholder.jpg"),
                image: NetworkImage(snapshot.data!),
                imageErrorBuilder: (BuildContext, Object, StackTrace) =>
                    Image.asset("assets/images/placeholder.jpg"),
              );
            } else {
              return const CircularProgressIndicator();
            }
          },
        );
      }
    } else {
      // Asset image
      imageWidget = FadeInImage(
        fit: fit ?? BoxFit.cover,
        placeholder: const AssetImage("assets/images/placeholder.jpg"),
        image: AssetImage(image),
        imageErrorBuilder: (BuildContext, Object, StackTrace) =>
            Image.asset("assets/images/placeholder.jpg"),
      );
    }

    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius!),
      ),
      child: imageWidget,
    );
  }
}
