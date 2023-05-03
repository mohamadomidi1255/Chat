import 'package:chat/controller/pick_controller.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

FilePickerController controller = Get.put(FilePickerController());

Future pickFile() async {
  FilePickerResult? result =
      await FilePicker.platform.pickFiles(type: FileType.image);
  controller.file.value = result!.files.first;
}
