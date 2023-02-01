import 'macos_file_picker_platform_interface.dart';

class MacosFilePicker {
  Future<List<String>?> pick(
      {bool? allowsMultiple,
      bool? folder,
      bool? saveFile,
      String? defaultName}) {
    return MacosFilePickerPlatform.instance.pick(
        allowsMultiple: allowsMultiple,
        folder: folder,
        saveFile: saveFile,
        defaultName: defaultName);
  }
}
