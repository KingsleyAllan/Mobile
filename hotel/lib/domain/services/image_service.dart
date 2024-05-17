abstract class ImageService {
  /// Uploads an image and returns the download URL.
  ///
  /// This method should be implemented by concrete platform-specific services.
  ///
  /// Throws an [Exception] if the upload fails.
  Future<String> uploadImage(dynamic imageData) async {
    throw UnimplementedError('Image upload is not implemented for this platform.');
  }
}
