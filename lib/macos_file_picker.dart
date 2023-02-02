import 'macos_file_picker_platform_interface.dart';

class MacosFilePicker {
  Future<List<String>?> pick(MacosFilePickerMode mode,
      {String? defaultName, bool? allowsMultiple}) {
    return MacosFilePickerPlatform.instance
        .pick(mode, defaultName: defaultName, allowsMultiple: allowsMultiple);
  }
}
