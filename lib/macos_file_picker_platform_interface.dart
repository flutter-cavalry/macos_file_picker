import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'macos_file_picker_method_channel.dart';

enum MacosFilePickerMode { file, folder, fileAndFolder, saveFile }

class MacosFilePickerPath {
  final Uri uri;
  final String path;

  MacosFilePickerPath(this.uri, this.path);

  static MacosFilePickerPath fromMap(Map<dynamic, dynamic> map) {
    return MacosFilePickerPath(Uri.parse(map['uri']), map['path']);
  }

  @override
  String toString() {
    return 'Uri: $uri | Path: $path';
  }
}

abstract class MacosFilePickerPlatform extends PlatformInterface {
  /// Constructs a MacosFilePickerPlatform.
  MacosFilePickerPlatform() : super(token: _token);

  static final Object _token = Object();

  static MacosFilePickerPlatform _instance = MethodChannelMacosFilePicker();

  /// The default instance of [MacosFilePickerPlatform] to use.
  ///
  /// Defaults to [MethodChannelMacosFilePicker].
  static MacosFilePickerPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MacosFilePickerPlatform] when
  /// they register themselves.
  static set instance(MacosFilePickerPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<List<MacosFilePickerPath>?> pick(MacosFilePickerMode mode,
      {String? defaultName, bool? allowsMultiple}) {
    throw UnimplementedError('pick() has not been implemented.');
  }
}
