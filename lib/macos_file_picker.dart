import 'macos_file_picker_platform_interface.dart';

class MacosFilePicker {
  /// Opens a macOS dialog based on the given arguments.
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
  ///   [null]: dialog closed / cancelled.
  ///   A list of [MacosFilePickerPath] representing a platform path.
  ///   When [allowsMultiple] is false, the list should only has one item.
  Future<List<MacosFilePickerPath>?> pick(MacosFilePickerMode mode,
      {String? defaultName, bool? allowsMultiple}) {
    return MacosFilePickerPlatform.instance
        .pick(mode, defaultName: defaultName, allowsMultiple: allowsMultiple);
  }
}
