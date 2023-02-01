import 'macos_file_picker_platform_interface.dart';

class MacosFilePicker {
  Future<List<String>?> pick({bool? allowsMultiple, bool? folder}) {
    return MacosFilePickerPlatform.instance
        .pick(allowsMultiple: allowsMultiple, folder: folder);
  }
}
