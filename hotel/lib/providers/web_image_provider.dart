import 'package:flutter/foundation.dart';
import 'package:hotel/domain/services/web_image_service.dart';

class WebImageProvider extends ChangeNotifier {
  final WebImageService imageService = WebImageService();

  Future<String> uploadImage(Uint8List imageBytes) async {
    final url = await imageService.uploadImage(imageBytes);
    notifyListeners(); // Notify listeners of a change (optional)
    return url;
  }

  Future<Uint8List> pickImage() async {
    final imageBytes = await imageService.pickImage();
    notifyListeners(); // Notify listeners of a change (optional)
    return imageBytes;
  }
}
