import 'package:image_picker/image_picker.dart';

class PickerUtilities{

  static final PickerUtilities _singleton = PickerUtilities._internal();

  factory PickerUtilities() {
    return _singleton;
  }

  PickerUtilities._internal();

  static Future <XFile?> pickSingleImageFromGallery() async{
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  static Future <XFile?> pickSingleImageFromCamera() async{
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickImage(source: ImageSource.camera);
  }

  static Future <XFile?> pickSingleVideoFromCamera() async{
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickVideo(source: ImageSource.camera);
  }

  static Future <XFile?> pickSingleVideoFromGallery() async{
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickVideo(source: ImageSource.gallery);
  }

  static Future <List<XFile>?> pickMultipleImages() async{
    final ImagePicker _picker = ImagePicker();
    return await _picker.pickMultiImage();
  }


}