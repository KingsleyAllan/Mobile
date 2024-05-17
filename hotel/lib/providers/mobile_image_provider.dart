import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:hotel/domain/services/mobile_image_service.dart';

class MobileImageProvider extends ChangeNotifier {
  final MobileImageService imageService = MobileImageService();

  Future<String> uploadImage(File imageFile) async {
    final url = await imageService.uploadImage(imageFile);
    notifyListeners(); // Notify listeners of a change (optional)
    return url;
  }

  Future<File> pickImage() async {
    final imageFile = await imageService.pickImage();
    notifyListeners(); // Notify listeners of a change (optional)
    return imageFile;
  }
}
