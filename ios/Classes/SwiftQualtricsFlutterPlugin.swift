import Flutter
import UIKit
import Qualtrics

public class SwiftQualtricsFlutterPlugin: NSObject, FlutterPlugin {
  
  var registrar: FlutterPluginRegistrar?
  var messenger: FlutterBinaryMessenger?
  
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_qualtrics", binaryMessenger: registrar.messenger())
    let instance = SwiftQualtricsFlutterPlugin()
    instance.registrar = registrar
    instance.messenger = registrar.messenger()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }
  
  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    do {
      let pluginMethod = try PluginMethod(from: call)
      switch pluginMethod {
      case .`init`(let arguments):
        Qualtrics.shared.initialize(brandId: arguments.brandId, zoneId: arguments.zoneId, interceptId: arguments.interceptId) { initializationResult in
          result(initializationResult.passed())
        }
      case .evaluateTargetingLogic:
        Qualtrics.shared.evaluateTargetingLogic { targetingResult in
          if let targetingResultError = targetingResult.getError() {
            result(targetingResultError.asFlutterError)
          }
          else {
            result(targetingResult.passed())
          }
        }
      case .display:
        let rootViewController = UIApplication.shared.keyWindow!.rootViewController!
        let displayResult = Qualtrics.shared.display(viewController: rootViewController)
        result(displayResult)
      case .displayTarget(let arguments):
        let rootViewController = UIApplication.shared.keyWindow!.rootViewController!
        Qualtrics.shared.displayTarget(targetViewController: rootViewController, targetUrl: arguments.target)
        result(true)
      case .hide:
        result(Qualtrics.shared.hide())
      case .registerViewVisit(let arguments):
        Qualtrics.shared.registerViewVisit(viewName: arguments.viewName)
        result(true)
      case .resetTimer:
        Qualtrics.shared.resetTimer()
        result(true)
      case .resetViewCounter:
        Qualtrics.shared.resetViewCounter()
        result(true)
      }
    } catch {
      result(error.asFlutterError)
    }
  }
  
}
