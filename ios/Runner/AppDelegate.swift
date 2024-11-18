import UIKit
import Flutter
import GoogleMaps
import flutter_local_notifications
import Firebase
import FirebaseMessaging

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
      
      FirebaseApp.configure()
      
      FlutterLocalNotificationsPlugin.setPluginRegistrantCallback { (registry) in
          GeneratedPluginRegistrant.register(with: registry)
      }
      
      if #available(iOS 10.0, *) {
          UNUserNotificationCenter.current().delegate = self
      }
      
      GMSServices.provideAPIKey("AIzaSyD-8uYjVSLFNFAodalF-g-gLkpESoacjbI")
      
      GeneratedPluginRegistrant.register(with: self)
      return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
      print("IOS Token: \(deviceToken)")
      super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }
}
