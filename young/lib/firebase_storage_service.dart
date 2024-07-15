import 'package:firebase_storage/firebase_storage.dart';

Future<List<String>> fetchImagesFromFirebase() async {
  final storageRef = FirebaseStorage.instance.ref().child('wardrobe');
  final listResult = await storageRef.listAll();
  
  List<String> imageUrls = [];
  for (var item in listResult.items) {
    final imageUrl = await item.getDownloadURL();
    imageUrls.add(imageUrl);
  }
  
  return imageUrls;
}
