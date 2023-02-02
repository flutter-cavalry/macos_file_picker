import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'macos_file_picker_platform_interface.dart';

/// An implementation of [MacosFilePickerPlatform] that uses method channels.
class MethodChannelMacosFilePicker extends MacosFilePickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('macos_file_picker');

  @override
  Future<List<String>?> pick(MacosFilePickerMode mode,
      {String? defaultName, bool? allowsMultiple}) {
    return methodChannel.invokeListMethod<String>('pick', {
      'mode': mode.index,
      'defaultName': defaultName,
      'allowsMultiple': allowsMultiple
    });
  }
}
