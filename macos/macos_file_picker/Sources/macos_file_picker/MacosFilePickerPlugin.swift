import Cocoa
import FlutterMacOS

enum MacosFilePickerMode: Int { case file, folder, fileAndFolder, saveFile }

public class MacosFilePickerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(
      name: "macos_file_picker", binaryMessenger: registrar.messenger)
    let instance = MacosFilePickerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? [String: Any] else {
      result(FlutterError(code: "InvalidArgsType", message: "Invalid args type", details: nil))
      return
    }
    switch call.method {
    case "pick":
      // Arguments are enforced on dart side.
      let mode = MacosFilePickerMode(rawValue: args["mode"] as! Int)
      let allowsMultiple = args["allowsMultiple"] as? Bool ?? false

      if mode == .saveFile {
        let panel = NSSavePanel()
        if let defaultName = args["defaultName"] as? String {
          panel.nameFieldStringValue = defaultName
        }
        let res = panel.runModal()
        if res == .OK {
          if let url = panel.url {
            result([urlToMap(url)])
          } else {
            result(nil)
          }
        } else {
          result(nil)
        }
      } else {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = allowsMultiple
        panel.canChooseFiles = mode == .file || mode == .fileAndFolder
        panel.canChooseDirectories = mode == .folder || mode == .fileAndFolder
        panel.canCreateDirectories = mode == .folder || mode == .fileAndFolder
        let res = panel.runModal()
        if res == .OK {
          if allowsMultiple {
            result(panel.urls.map { urlToMap($0) })
          } else {
            if let url = panel.url {
              result([urlToMap(url)])
            } else {
              result(nil)
            }
          }
        } else {
          result(nil)
        }
      }
    default:
      result(FlutterMethodNotImplemented)
    }
  }

  private func urlToMap(_ url: URL) -> [String: String] {
    return ["url": url.absoluteString, "path": url.path, "name": url.lastPathComponent]
  }
}
