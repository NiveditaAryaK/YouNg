import 'package:flutter/foundation.dart'; // Import foundation for kIsWeb
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:convert';  // Import dart:convert for jsonEncode and jsonDecode
import 'package:http/http.dart' as http;  // Import http for HTTP requests
import 'dart:io'; // Conditional import

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  List<String> _images = [];
  List<String> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    _loadImages();
  }

  Future<void> _loadImages() async {
    try {
      final images = await fetchImagesFromFirebase();
      setState(() {
        _images = images;
      });
    } catch (e) {
      print('Error fetching images: $e');
    }
  }

  Future<void> _uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final reference = FirebaseStorage.instance.ref().child('wardrobe/$fileName');

      try {
        if (kIsWeb) {
          // For web
          final bytes = await pickedFile.readAsBytes();
          await reference.putData(bytes);
        } else {
          // For mobile
          await reference.putFile(File(pickedFile.path));
        }
        final imageUrl = await reference.getDownloadURL();
        setState(() {
          _images.add(imageUrl);
        });
      } catch (e) {
        print('Error uploading image: $e');
      }
    }
  }

  Future<List<String>> fetchImagesFromFirebase() async {
    List<String> imageUrls = [];
    final storageRef = FirebaseStorage.instance.ref().child('wardrobe');
    final listResult = await storageRef.listAll();

    for (var item in listResult.items) {
      final url = await item.getDownloadURL();
      imageUrls.add(url);
    }

    return imageUrls;
  }

  Future<void> _findMismatch() async {
    if (_selectedImages.length < 2) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Error'),
          content: Text('Please select at least two images to find mismatches.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    try {
      final result = await findFashionMismatch(_selectedImages);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Mismatch Result'),
          content: Text(result),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    } catch (e) {
      print('Error finding mismatch: $e');
    }
  }

  Future<String> findFashionMismatch(List<String> imageUrls) async {
    final url = 'https://your-mismatch-api-endpoint.com/findMismatch';  // Replace with your mismatch API endpoint
    final body = jsonEncode({
      'imageUrls': imageUrls,
    });

    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['result'] ?? 'No mismatch result found.';
    } else {
      throw Exception('Failed to find mismatches: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile Screen'),
      ),
      body: Column(
        children: [
          Expanded(
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 4.0,
                mainAxisSpacing: 4.0,
              ),
              itemCount: _images.length,
              itemBuilder: (context, index) {
                final imageUrl = _images[index];
                final isSelected = _selectedImages.contains(imageUrl);

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        _selectedImages.remove(imageUrl);
                      } else {
                        _selectedImages.add(imageUrl);
                      }
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? Colors.blue : Colors.transparent,
                      ),
                    ),
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: _uploadImage,
            child: Text('Upload Image'),
          ),
          ElevatedButton(
            onPressed: _findMismatch,
            child: Text('Mismatch'),
          ),
        ],
      ),
    );
  }
}
