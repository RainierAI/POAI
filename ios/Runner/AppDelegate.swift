import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    
    private var appState = AppState()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      
      
      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
//      let audioUnit = AECAudioStream(sampleRate: 16000)
      let channel = FlutterMethodChannel(name: "poai.com/chat", binaryMessenger: controller.binaryMessenger)
      
      channel.setMethodCallHandler({ [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          
          if (call.method == "appconfig") {
              self?.appState.loadAppConfigAndModels(channel: channel)
          } else if (call.method == "sendmsgflutter") {
              self?.appState.chatState.requestGenerate(prompt: call.arguments as! NSString, channel: channel)
          } else if (call.method == "reset") {
              self?.appState.chatState.requestResetChat(channel: channel)
          } else if (call.method == "sendmsgflutter2") {
              self?.appState.chatState.requestResetChat2(channel: channel, prompt: call.arguments as! NSString)
          }
          
      })
      
      GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
