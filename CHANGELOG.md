## 2.0.0

- **Breaking:** Picker results now start security-scoped access automatically when macOS grants it. You need to call `await path.release()` on every returned `MacosFilePickerPath` after use.

## 1.0.0

- Initial stable release.
- Bump min macOS version to 11.0
- Bump min Flutter SDK version to 3.44.0

## 0.7.3

- Switch to async open file modals.

## 0.7.1

- Allow setting dialog title.

## 0.6.1

- Add `initialDirectory`.

## 0.6.0

- Add `allowedUtiTypes` and `allowedFileExtensions`.

## 0.5.0

- Add Swift Package Manager support.

## 0.4.0

- Add `name` to `MacosFilePickerPath`.

## 0.3.0

- Rename `MacosFilePickerPath.uri` to `url`.

## 0.1.0

- Initial release.
