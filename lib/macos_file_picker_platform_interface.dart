import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'macos_file_picker_method_channel.dart';

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

  Future<List<String>?> pick(
      {bool? allowsMultiple,
      bool? folder,
      bool? saveFile,
      String? defaultName}) {
    throw UnimplementedError('pick() has not been implemented.');
  }
}
