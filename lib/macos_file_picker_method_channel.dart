import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:macos_file_picker/macos_file_picker.dart';

import 'macos_file_picker_platform_interface.dart';

/// An implementation of [MacosFilePickerPlatform] that uses method channels.
class MethodChannelMacosFilePicker extends MacosFilePickerPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('macos_file_picker');

  @override
  Future<List<MacosFilePickerPath>?> pick(
    MacosFilePickerMode mode, {
    String? defaultName,
    bool? allowsMultiple,
    List<String>? allowedUtiTypes,
    List<String>? allowedFileExtensions,
    String? initialDirectory,
  }) async {
    var maps =
        await methodChannel.invokeListMethod<Map<dynamic, dynamic>>('pick', {
      'mode': mode.index,
      'defaultName': defaultName,
      'allowsMultiple': allowsMultiple,
      'allowedUtiTypes': allowedUtiTypes,
      'allowedFileExtensions': allowedFileExtensions,
      'initialDirectory': initialDirectory,
    });
    if (maps == null) {
      return null;
    }
    return maps.map((e) => MacosFilePickerPath.fromMap(e)).toList();
  }
}
