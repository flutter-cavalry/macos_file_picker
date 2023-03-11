# macos_file_picker

[![pub package](https://img.shields.io/pub/v/macos_file_picker.svg)](https://pub.dev/packages/macos_file_picker)

Opens native macOS dialogs to pick files or folders. Features:

- Pick files, folders or both.
- Pick a file to save.

## Usage

```dart
/// Opens a macOS dialog based on the given arguments.
///
/// [mode]:
///   file: pick files.
///   folder: pick folders.
///   fileAndFolder: pick files and folders.
///   saveFile: pick a file saving path.
///
/// [allowsMultiple] when true, allows multiple selection. Default: false.
/// [defaultName] default file name for save dialog.
///
/// Return value:
///   [null]: dialog closed / cancelled.
///   A list of [MacosFilePickerPath] representing a platform path.
///   When [allowsMultiple] is false, the list should only has one item.
Future<List<MacosFilePickerPath>?> pick(MacosFilePickerMode mode,
    {String? defaultName, bool? allowsMultiple});
```

## Example

```dart
final _macosFilePickerPlugin = MacosFilePicker();

Future<void> _openDialog() async {
  // Pick a single file path.
  var result = await _macosFilePickerPlugin.pick(_mode,
      allowsMultiple: _allowsMultiple);
  setState(() {
    _output = result == null ? 'Cancelled' : result.toString();
  });
}
```
