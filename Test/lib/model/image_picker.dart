import 'dart:typed_data';
import 'package:image_picker/image_picker.dart';

Future<Uint8List?> pickImage(ImageSource source) async {
  try {
    final ImagePicker _imagePicker = ImagePicker();
    final XFile? file = await _imagePicker.pickImage(source: source);
    if(file != null){
      return await file.readAsBytes();
    } else {
      print('No image selected');
      return null;
    }
  } catch (e) {
    print('Error picking image: $e');
    // Handle error appropriately (e.g., show error message to user)
    return null;
  }
}
