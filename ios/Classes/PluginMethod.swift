//
//  PluginMethod.swift
//
//  Created by Kymer Gryson on 02/10/2019.
//

import Foundation

enum PluginMethod {
  case `init`(InitArguments)
  case evaluateTargetingLogic
  case display
  case displayTarget(DisplayTargetArguments)
  case hide
  case registerViewVisit(RegisterViewVisitArguments)
  case resetTimer
  case resetViewCounter
  case setStringProperty(SetStringPropertyArguments)
  case setNumberProperty(SetNumberPropertyArguments)
  
  public init(from call: FlutterMethodCall) throws {
    switch call.method {
    case "init":
      let arguments = try InitArguments(from: call)
      self = .`init`(arguments)
    case "evaluateTargetingLogic":
      self = .evaluateTargetingLogic
    case "display":
      self = .display
    case "displayTarget":
      let arguments = try DisplayTargetArguments(from: call)
      self = .displayTarget(arguments)
    case "hide":
      self = .hide
    case "registerViewVisit":
      let arguments = try RegisterViewVisitArguments(from: call)
      self = .registerViewVisit(arguments)
    case "resetTimer":
      self = .resetTimer
    case "resetViewCounter":
      self = .resetViewCounter
    case "setStringProperty":
      let arguments = try SetStringPropertyArguments(from: call)
      self = .setStringProperty(arguments)
    case "setNumberProperty":
      let arguments = try SetNumberPropertyArguments(from: call)
      self = .setNumberProperty(arguments)
    default:
      throw PluginError.unhandledMethod(call)
    }
    
  }
}
