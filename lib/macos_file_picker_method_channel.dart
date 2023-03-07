import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'macos_file_picker_platform_interface.dart';

/// An implementation of [MacosFilePickerPlatform] that uses method channels.
class MethodChannelMacosFilePicker extends MacosFilePickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('macos_file_picker');

  @override
  Future<List<MacosFilePickerPath>?> pick(MacosFilePickerMode mode,
      {String? defaultName, bool? allowsMultiple}) async {
    var maps = await methodChannel.invokeListMethod<Map<dynamic, dynamic>>(
        'pick', {
      'mode': mode.index,
      'defaultName': defaultName,
      'allowsMultiple': allowsMultiple
    });
    if (maps == null) {
      return null;
    }
    return maps.map((e) => MacosFilePickerPath.fromMap(e)).toList();
  }
}
