import Flutter
import UIKit
import XCTest

@testable import ios_system_sound

// Unit tests covering the Swift side of the plugin.
//
// See https://developer.apple.com/documentation/xctest for more information.

class RunnerTests: XCTestCase {

  private func handle(
    method: String,
    arguments: Any? = nil
  ) -> Any? {
    let plugin = IosSystemSoundPlugin()
    let call = FlutterMethodCall(methodName: method, arguments: arguments)

    var value: Any?
    var called = false
    plugin.handle(call) { result in
      value = result
      called = true
    }

    XCTAssertTrue(called, "The result block must be called.")
    return value
  }

  func testPlayWithValidSoundId() {
    XCTAssertNil(handle(method: "play", arguments: ["soundId": 1108]))
  }

  func testVibrate() {
    XCTAssertNil(handle(method: "vibrate"))
  }

  func testPlayWithMissingArgument() {
    guard let error = handle(method: "play") as? FlutterError else {
      return XCTFail("A FlutterError is expected for missing arguments.")
    }
    XCTAssertEqual(error.code, "INVALID_ARGS")
  }

  func testPlayWithInvalidArgumentType() {
    guard let error = handle(method: "play", arguments: ["soundId": "shutter"]) as? FlutterError
    else {
      return XCTFail("A FlutterError is expected for non numeric arguments.")
    }
    XCTAssertEqual(error.code, "INVALID_ARGS")
  }

  func testUnsupportedMethod() {
    guard let value = handle(method: "unknownMethod") else {
      return XCTFail("FlutterMethodNotImplemented is expected.")
    }
    XCTAssertTrue(value is NSObject)
  }
}
