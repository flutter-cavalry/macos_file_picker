[![pub package](https://img.shields.io/pub/v/macos_file_picker.svg)](https://pub.dev/packages/macos_file_picker)

Opens native macOS dialogs to pick files or folders. Features:

- Pick a single or multiple files, folders and both.
- Pick a file to save.

## Usage

```dart
///
/// Open a macOS dialog based on the given arguments.
///
/// [mode]:
///   file: pick files.
///   folder: pick folders.
///   fileAndFolder: pick files and folders.
///   saveFile: pick a file saving path.
///
/// [allowsMultiple] when true, allows multiple selection.
/// [defaultName] default file name for save dialog.
///
/// Return value:
///   null: dialog closed / cancelled.
///   When [allowsMultiple] is false, the list returned only has one item.
Future<List<String>?> pick(MacosFilePickerMode mode,
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
    _output = result == null ? 'Cancelled' : result.first;
  });
}
```
