import AVFoundation
import Flutter
import UIKit

public class IosSystemSoundPlugin: NSObject, FlutterPlugin {
    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(name: "ios_system_sound", binaryMessenger: registrar.messenger())
        let instance = IosSystemSoundPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch call.method {
        case "play":
            if let args = call.arguments as? [String: Any],
                let soundId = args["soundId"] as? UInt32
            {
                AudioServicesPlaySystemSound(soundId)
                result(nil)
            } else {
                result(FlutterError(code: "INVALID_ARGS", message: "Invalid sound ID", details: nil))
            }
        default:
            result(FlutterMethodNotImplemented)
        }
    }

}
