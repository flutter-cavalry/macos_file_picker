import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macos_file_picker/macos_file_picker_method_channel.dart';
import 'package:macos_file_picker/macos_file_picker_platform_interface.dart';

void main() {
  MethodChannelMacosFilePicker platform = MethodChannelMacosFilePicker();
  const MethodChannel channel = MethodChannel('macos_file_picker');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('pick', () async {
    expect(await platform.pick(MacosFilePickerMode.file), ['1', '2']);
  });
}
