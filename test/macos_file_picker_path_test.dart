import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:macos_file_picker/macos_file_picker.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  const channel = MethodChannel('macos_file_picker');

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('release does nothing when no scoped access was acquired', () async {
    var calls = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls++;
          return null;
        });

    final path = MacosFilePickerPath.fromMap({
      'url': 'file:///tmp/example',
      'path': '/tmp/example',
      'name': 'example',
    });
    await path.release();

    expect(calls, 0);
  });

  test('release stops scoped access only once', () async {
    var calls = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          expect(call.method, 'release');
          expect(call.arguments, {'token': 'scope-1'});
          calls++;
          return null;
        });

    final path = MacosFilePickerPath.fromMap({
      'url': 'file:///tmp/example',
      'path': '/tmp/example',
      'name': 'example',
      'token': 'scope-1',
    });
    await Future.wait([path.release(), path.release()]);
    await path.release();

    expect(calls, 1);
  });

  test('failed release can be retried', () async {
    var calls = 0;
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (call) async {
          calls++;
          if (calls == 1) {
            throw PlatformException(code: 'retry');
          }
          return null;
        });

    final path = MacosFilePickerPath.fromMap({
      'url': 'file:///tmp/example',
      'path': '/tmp/example',
      'name': 'example',
      'token': 'scope-1',
    });
    await expectLater(path.release(), throwsA(isA<PlatformException>()));
    await path.release();

    expect(calls, 2);
  });
}
