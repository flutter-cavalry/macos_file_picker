import 'macos_file_picker_platform_interface.dart';

class MacosFilePicker {
  ///
  /// Open a macOS dialog based on the given arguments.
  ///
  /// [mode]:
  ///   file: pick files.
  ///   folder: pick folders.
  ///   fileAndFolder: pick files and folders.
  ///   saveFile: pick a file saving path.
  ///
  /// [allowsMultiple] when true, allows multiple selection. Default: false.
  /// [defaultName] default file name for save dialog.
  ///
  /// Return value:
  ///   null: dialog closed / cancelled.
  ///   When [allowsMultiple] is false, the list returned only has one item.
  Future<List<String>?> pick(MacosFilePickerMode mode,
      {String? defaultName, bool? allowsMultiple}) {
    return MacosFilePickerPlatform.instance
        .pick(mode, defaultName: defaultName, allowsMultiple: allowsMultiple);
  }
}
