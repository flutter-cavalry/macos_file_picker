import Cocoa
import FlutterMacOS
import UniformTypeIdentifiers

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
      let allowedUtiTypes = args["allowedUtiTypes"] as? [String]
      let allowedFileExtensions = args["allowedFileExtensions"] as? [String]
      let initialDirectory = args["initialDirectory"] as? String
      let dialogTitle = args["dialogTitle"] as? String
      
      var initialDirectoryURL: URL?
      if let initialDirectory = initialDirectory {
        if initialDirectory.contains("://") {
          initialDirectoryURL = URL(string: initialDirectory)
        } else {
          initialDirectoryURL = URL(fileURLWithPath: initialDirectory)
        }
      }


      if mode == .saveFile {
        let panel = NSSavePanel()
        if let defaultName = args["defaultName"] as? String {
          panel.nameFieldStringValue = defaultName
        }
        
        if #available(macOS 11.0, *) {
          let utTypes = allowedUtiTypes?.compactMap { UTType($0) }
          if let utTypes = utTypes {
            panel.allowedContentTypes = utTypes
          }
        }
        
        if let allowedFileExtensions = allowedFileExtensions {
          panel.allowedFileTypes = allowedFileExtensions
        }
        if let initialDirectoryURL = initialDirectoryURL {
          panel.directoryURL = initialDirectoryURL
        }
        if let dialogTitle = dialogTitle {
          panel.title = dialogTitle
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
        
        if #available(macOS 11.0, *) {
          let utTypes = allowedUtiTypes?.compactMap { UTType($0) }
          if let utTypes = utTypes {
            panel.allowedContentTypes = utTypes
          }
        }
        if let allowedFileExtensions = allowedFileExtensions {
          panel.allowedFileTypes = allowedFileExtensions
        }
        if let initialDirectoryURL = initialDirectoryURL {
          panel.directoryURL = initialDirectoryURL
        }
        if let dialogTitle = dialogTitle {
          panel.title = dialogTitle
        }
        
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
