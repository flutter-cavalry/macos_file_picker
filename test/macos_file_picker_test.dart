import 'package:flutter_test/flutter_test.dart';
import 'package:macos_file_picker/macos_file_picker.dart';
import 'package:macos_file_picker/macos_file_picker_platform_interface.dart';
import 'package:macos_file_picker/macos_file_picker_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMacosFilePickerPlatform
    with MockPlatformInterfaceMixin
    implements MacosFilePickerPlatform {
  @override
  Future<List<String>?> pick(MacosFilePickerMode mode,
          {String? defaultName, bool? allowsMultiple}) =>
      Future.value(['1', '2']);
}

void main() {
  final MacosFilePickerPlatform initialPlatform =
      MacosFilePickerPlatform.instance;

  test('$MethodChannelMacosFilePicker is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMacosFilePicker>());
  });

  test('getPlatformVersion', () async {
    MacosFilePicker macosFilePickerPlugin = MacosFilePicker();
    MockMacosFilePickerPlatform fakePlatform = MockMacosFilePickerPlatform();
    MacosFilePickerPlatform.instance = fakePlatform;

    expect(
        await macosFilePickerPlugin.pick(MacosFilePickerMode.file), ['1', '2']);
  });
}
