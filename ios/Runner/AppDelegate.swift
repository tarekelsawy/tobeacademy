import UIKit
import Flutter
import FirebaseCore

@main
@objc class AppDelegate: FlutterAppDelegate {
  private var textField = UITextField()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
            let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      
      
            let batteryChannel = FlutterMethodChannel(name: "samples.secureapp",
                                                         binaryMessenger: controller.binaryMessenger)
            batteryChannel.setMethodCallHandler({
                 (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                guard call.method == "makeSecure" else {
                    self.window.isHidden = false;
                   result(FlutterMethodNotImplemented)
                   return
                 }
                self.window.isHidden = true;
                result(nil)
               })
      

    GeneratedPluginRegistrant.register(with: self)
     self.window.makeSecure() //Add this line 
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  // Screenshot Prevent Functions
 

      // <Add>
  override func applicationWillResignActive(
    _ application: UIApplication
  ) {
    self.window.isHidden = true;
  }
  override func applicationDidBecomeActive(
    _ application: UIApplication
  ) {
    self.window.isHidden = false;
  }

  
}
extension UIWindow {
func makeSecure() {
    let field = UITextField()
    field.isSecureTextEntry = true
    self.addSubview(field)
    field.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    field.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
    self.layer.superlayer?.addSublayer(field.layer)
    field.layer.sublayers?.last?.addSublayer(self.layer)
  }
}