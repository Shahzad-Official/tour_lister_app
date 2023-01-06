import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

class AccountSettingsController extends GetxController {
  String? fileName;
  uploadCertificate() async {
    var result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'docx', 'doc'],
    );
    if (result != null) {
      fileName = result.files.first.name;

      update();
    }
  }
}
