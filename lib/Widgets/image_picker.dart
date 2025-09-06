import 'package:image_picker/image_picker.dart';

class ImagePickerUtil {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> pickImageFromGallery() async {
    final image = await _picker.pickImage(source: ImageSource.gallery);
    return image?.path;
  }

  static Future<String?> pickImageFromCamera() async {
    final image = await _picker.pickImage(source: ImageSource.camera);
    return image?.path;
  }
}