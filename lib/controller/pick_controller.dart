import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class FilePickerController extends GetxController {
  Rx<PlatformFile> file = PlatformFile(name: "nothing", size: 0).obs;
}
