import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

class ImageHelper {
  ImageHelper({
    ImagePicker? imagePicker,
    ImageCropper? imageCropper,
  })  : _imagePicker = imagePicker ?? ImagePicker(),
        _imageCropper = imageCropper ?? ImageCropper();

  final ImagePicker _imagePicker;
  final ImageCropper _imageCropper;

  Future<List<XFile>> PickImage({
    ImageSource source = ImageSource.gallery,
    int imageQualty = 100,
  }) async {
    final file =
        await _imagePicker.pickImage(source: source, imageQuality: imageQualty);
    if (file != null) return [file];
    return [];
  }

  Future<CroppedFile?> crop({
    required XFile file,
    CropStyle cropStyle = CropStyle.rectangle,
  })async => await _imageCropper.cropImage(sourcePath: file.path,cropStyle: cropStyle,compressQuality: 100);
}
