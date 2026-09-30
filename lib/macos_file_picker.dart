import 'package:flutter/services.dart';

import 'macos_file_picker_platform_interface.dart';

enum MacosFilePickerMode { file, folder, fileAndFolder, saveFile }

class MacosFilePickerPath {
  final String url;
  final String path;
  final String name;
  String? _token;
  Future<void>? _releaseFuture;

  MacosFilePickerPath(this.url, this.path, this.name) : _token = null;

  MacosFilePickerPath._(this.url, this.path, this.name, this._token);

  static MacosFilePickerPath fromMap(Map<dynamic, dynamic> map) {
    return MacosFilePickerPath._(
      map['url'],
      map['path'],
      map['name'],
      map['token'],
    );
  }

  /// Releases security-scoped access acquired for this picker result.
  /// Call after finishing access to the selected file or directory.
  Future<void> release() {
    if (_token == null) {
      return Future.value();
    }
    return _releaseFuture ??= _release();
  }

  Future<void> _release() async {
    try {
      await const MethodChannel(
        'macos_file_picker',
      ).invokeMethod<void>('release', {'token': _token});
      _token = null;
    } finally {
      _releaseFuture = null;
    }
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
  /// [allowedFileExtensions] deprecated; use [allowedUtiTypes] instead.
  /// When both are provided, file extensions take precedence.
  /// [initialDirectory] initial directory. Can be a path or URL.
  /// [dialogTitle] title of the dialog window.
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
    @Deprecated('Use allowedUtiTypes instead.')
    List<String>? allowedFileExtensions,
    String? initialDirectory,
    String? dialogTitle,
  }) {
    return MacosFilePickerPlatform.instance.pick(
      mode,
      defaultName: defaultName,
      allowsMultiple: allowsMultiple,
      allowedUtiTypes: allowedUtiTypes,
      allowedFileExtensions: allowedFileExtensions,
      initialDirectory: initialDirectory,
      dialogTitle: dialogTitle,
    );
  }
}
