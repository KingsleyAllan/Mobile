import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:hotel/domain/services/image_service.dart';
import 'package:image_picker/image_picker.dart';
import 'package:uuid/uuid.dart';

class MobileImageService implements ImageService {
  final _picker = ImagePicker();


@override
Future<String> uploadImage(dynamic imageFile) async {
  // Ensure that imageFile is a File object
  if (imageFile is! File) {
    throw Exception('Invalid image file type');
  }

  // Your implementation here
  try {
    final storageReference = FirebaseStorage.instance.ref().child('hotel_images/${const Uuid().v4}.jpg');
    final uploadTask = storageReference.putFile(imageFile);
    final snapshot = await uploadTask.whenComplete(() => null);
    return await snapshot.ref.getDownloadURL();
  } on FirebaseException catch (error) {
    throw Exception('Failed to upload image: ${error.message}');
  } catch (error) {
    throw Exception('An error occurred: $error');
  }
}

  /// Picks an image from the device storage.
  ///
  /// Returns the selected image as a File object or throws an exception on failure.
  Future<File> pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return File(pickedFile.path);
    } else {
      throw Exception('No image selected.');
    }
  }
}
