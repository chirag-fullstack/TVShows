import Foundation
import UIKit
import Parse
import ProgressHUD

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        self.setupParse()
        self.customiseProgressHUD()
        return true
    }

    // MARK: Private Helper Methods

    private func setupParse() {
        guard let credentials = ClientCredentials.parse(jsonFile: Constants.FileNames.parseCredentials) else { return }
        let parseConfig = ParseClientConfiguration {
            $0.applicationId = credentials.applicationId
            $0.clientKey = credentials.clientKey
            $0.server = credentials.server
        }
        Parse.initialize(with: parseConfig)
    }

    private func customiseProgressHUD() {
        ProgressHUD.animationType = .singleCirclePulse
        ProgressHUD.colorHUD = .systemGray
        ProgressHUD.colorBackground = .lightGray
        ProgressHUD.colorAnimation = .systemBlue
        ProgressHUD.colorProgress = .systemBlue
    }

    // MARK: UISceneSession Lifecycle

    func application(
        _ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession,
        options: UIScene.ConnectionOptions
    ) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}
