import AudioToolbox
import Flutter
import UIKit

/// Flutter plugin exposing iOS System Sound Services to Dart.
///
/// Supported methods:
///   - `play`: plays a `SystemSoundID` (including `4095`, the special vibrate ID).
///   - `vibrate`: convenience shortcut for `kSystemSoundID_Vibrate`.
public class IosSystemSoundPlugin: NSObject, FlutterPlugin {
    private enum Method: String {
        case play
        case vibrate
    }

    private enum ArgumentKey: String {
        case soundId
        case waitForCompletion
    }

    public static func register(with registrar: FlutterPluginRegistrar) {
        let channel = FlutterMethodChannel(
            name: "ios_system_sound",
            binaryMessenger: registrar.messenger()
        )
        let instance = IosSystemSoundPlugin()
        registrar.addMethodCallDelegate(instance, channel: channel)
    }

    public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        switch Method(rawValue: call.method) {
        case .play:
            handlePlay(call, result: result)
        case .vibrate:
            playSound(kSystemSoundID_Vibrate, call: call, result: result)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    private func handlePlay(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
        guard let soundId = Self.extractSoundId(from: call.arguments) else {
            result(
                FlutterError(
                    code: "INVALID_ARGS",
                    message: "Argument 'soundId' is missing or not a UInt32.",
                    details: call.arguments
                )
            )
            return
        }

        playSound(soundId, call: call, result: result)
    }

    /// Plays [soundId] and replies to Dart either immediately or — when
    /// `waitForCompletion` is set — once the system reports the playback as
    /// finished, so a caller can chain sounds one after another.
    private func playSound(
        _ soundId: SystemSoundID,
        call: FlutterMethodCall,
        result: @escaping FlutterResult
    ) {
        guard Self.extractWaitForCompletion(from: call.arguments) else {
            AudioServicesPlaySystemSound(soundId)
            result(nil)
            return
        }

        AudioServicesPlaySystemSoundWithCompletion(soundId) {
            // The completion block is not guaranteed to run on the main thread,
            // but FlutterResult has to be called from it.
            DispatchQueue.main.async { result(nil) }
        }
    }

    /// Reads `{"soundId": <number>}` from the method arguments.
    ///
    /// Dart `int` values are bridged to `NSNumber`, so the value is normalised
    /// explicitly instead of relying on Swift type casting.
    private static func extractSoundId(from arguments: Any?) -> SystemSoundID? {
        guard let dictionary = arguments as? [String: Any] else {
            return nil
        }
        guard let number = dictionary[ArgumentKey.soundId.rawValue] as? NSNumber else {
            return nil
        }
        let raw = number.uint32Value
        guard number == NSNumber(value: raw) else {
            return nil
        }
        return raw
    }

    /// Reads the optional `{"waitForCompletion": <bool>}` flag; missing or
    /// non-boolean values keep the fire-and-forget behaviour.
    private static func extractWaitForCompletion(from arguments: Any?) -> Bool {
        guard let dictionary = arguments as? [String: Any] else {
            return false
        }
        return dictionary[ArgumentKey.waitForCompletion.rawValue] as? Bool ?? false
    }
}
