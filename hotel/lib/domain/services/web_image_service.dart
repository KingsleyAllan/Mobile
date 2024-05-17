import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
import 'package:hotel/domain/services/image_service.dart';
import 'package:uuid/uuid.dart';

class WebImageService implements ImageService {
  @override
  Future<String> uploadImage(dynamic imageBytes) async {
    // Ensure that imageBytes is a Uint8List object
    if (imageBytes is! Uint8List) {
      throw Exception('Invalid image bytes type');
    }

    // Your implementation here
    try {
      final storageReference = FirebaseStorage.instance.ref().child('hotel_images/${const Uuid().v4}.jpg');
      final metadata = SettableMetadata(contentType: 'image/jpeg'); // Adjust based on image format
      final uploadTask = storageReference.putData(Uint8List.fromList(imageBytes), metadata);
      final snapshot = await uploadTask.whenComplete(() => null);
      return await snapshot.ref.getDownloadURL();
    } on FirebaseException catch (error) {
      throw Exception('Failed to upload image: ${error.message}');
    } catch (error) {
      throw Exception('An error occurred: $error');
    }
  }

  /// Picks an image from the user's device using the file picker package.
  ///
  /// Returns the selected image as a Uint8List object or throws an exception on failure.
  Future<Uint8List> pickImage() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false, type: FileType.image);
    if (result != null && result.files.isNotEmpty) {
      final platformFile = result.files.first;
      final bytes = platformFile.bytes;
      if (bytes != null) {
        return bytes;
      } else {
        throw Exception('Failed to read file bytes.');
      }
    } else {
      throw Exception('No image selected.');
    }
  }
}