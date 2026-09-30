# macos_file_picker

[![pub package](https://img.shields.io/pub/v/macos_file_picker.svg)](https://pub.dev/packages/macos_file_picker)

Opens native macOS dialogs to pick files or folders. Features:

- Pick files, folders or both.
- Pick a file to save.

## Usage

You need to add an entitlement (`DebugProfile.entitlements` or `Release.entitlements`) for either read-only access:

```xml
  <key>com.apple.security.files.user-selected.read-only</key>
  <true/>
```

or read-write access:

```xml
  <key>com.apple.security.files.user-selected.read-write</key>
  <true/>
```

The picker starts security-scoped access when macOS grants it for a selected URL.
Call `await path.release()` on each returned `MacosFilePickerPath` after you finish
using it (including after file operations fail). Releasing a path without scoped
access has no effect.

```dart
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
});
```

## Example

```dart
final _macosFilePickerPlugin = MacosFilePicker();

Future<void> _openDialog() async {
  final result = await _macosFilePickerPlugin.pick(_mode,
      allowsMultiple: _allowsMultiple);
  try {
    if (mounted) {
      setState(() {
        _output = result == null ? 'Cancelled' : result.toString();
      });
    }
  } finally {
    if (result != null) {
      await Future.wait(result.map((path) => path.release()));
    }
  }
}
```
