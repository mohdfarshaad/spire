import 'package:image_picker/image_picker.dart';

Future<XFile?> pickImageFromGallery() async {
  final picker = ImagePicker();
  try {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    return pickedImage;
  } catch (e) {
    print('Error picking image: $e');
    return null;
  }
}
