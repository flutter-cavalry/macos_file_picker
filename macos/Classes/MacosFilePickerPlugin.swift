import Cocoa
import FlutterMacOS

public class MacosFilePickerPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "macos_file_picker", binaryMessenger: registrar.messenger)
    let instance = MacosFilePickerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    guard let args = call.arguments as? Dictionary<String, Any> else {
      result(FlutterError(code: "InvalidArgsType", message: "Invalid args type", details: nil))
      return
    }
    switch call.method {
    case "pick":
      // Arguments are enforced on dart side.
      let allowsMultiple = args["allowsMultiple"] as? Bool ?? false
      let folder = args["folder"] as? Bool ?? false
      let saveFile = args["saveFile"] as? Bool ?? false

      if saveFile {
        let panel = NSSavePanel()
        if let defaultName = args["defaultName"] as? String {
          panel.nameFieldStringValue = defaultName
        }
        let res = panel.runModal()
        if res == .OK {
          if let url = panel.url {
            result([url.path])
          } else {
            result(nil)
          }
        } else {
          result(nil)
        }
      } else {
        let panel = NSOpenPanel()
        panel.allowsMultipleSelection = allowsMultiple
        panel.canChooseFiles = !folder
        panel.canChooseDirectories = folder
        let res = panel.runModal()
        if res == .OK {
          if (allowsMultiple) {
            result(panel.urls.map{ $0.path })
          } else {
            if let url = panel.url {
              result([url.path])
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
}
