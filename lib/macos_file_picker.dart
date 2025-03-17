import 'macos_file_picker_platform_interface.dart';

enum MacosFilePickerMode { file, folder, fileAndFolder, saveFile }

class MacosFilePickerPath {
  final String url;
  final String path;
  final String name;

  MacosFilePickerPath(this.url, this.path, this.name);

  static MacosFilePickerPath fromMap(Map<dynamic, dynamic> map) {
    return MacosFilePickerPath(
      map['url'],
      map['path'],
      map['name'],
    );
  }

  @override
  String toString() {
    return 'MacosFilePickerPath{name: $name, path: $path, url: $url}';
  }
}

class MacosFilePicker {
  /// Opens a macOS dialog based on the given arguments.
  ///
  /// [mode]
  ///   file: pick files.
  ///   folder: pick folders.
  ///   fileAndFolder: pick files and folders.
  ///   saveFile: pick a file saving path.
  ///
  /// [allowsMultiple] when true, allows multiple selection. Default: false.
  /// [defaultName] default file name for save dialog.
  /// [allowedUtiTypes] allowed UTI types.
  /// [allowedFileExtensions] allowed file extensions.
  /// [initialDirectory] initial directory. Can be a path or URL.
  ///
  /// Return value:
  ///   [null]: dialog closed / cancelled.
  ///   A list of [MacosFilePickerPath] representing a platform path.
  ///   When [allowsMultiple] is false, the list should only has one item.
  Future<List<MacosFilePickerPath>?> pick(
    MacosFilePickerMode mode, {
    String? defaultName,
    bool? allowsMultiple,
    List<String>? allowedUtiTypes,
    List<String>? allowedFileExtensions,
    String? initialDirectory,
  }) {
    return MacosFilePickerPlatform.instance.pick(mode,
        defaultName: defaultName,
        allowsMultiple: allowsMultiple,
        allowedUtiTypes: allowedUtiTypes,
        allowedFileExtensions: allowedFileExtensions,
        initialDirectory: initialDirectory);
  }
}
