import UIKit

class SettingsViewController: UIViewController {
    
    @IBOutlet weak var notificationsSwitch: UISwitch!
    @IBOutlet weak var notificationsLabel: UILabel!
    @IBOutlet weak var themeSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        notificationsLabel.text = "Enable Notifications"
        notificationsSwitch.isOn = UserDefaults.standard.bool(forKey: "notificationsEnabled")
    }
    
    @IBAction func notificationsSwitchChanged(_ sender: UISwitch) {
        UserDefaults.standard.set(sender.isOn, forKey: "notificationsEnabled")
        if sender.isOn {
            requestNotificationPermission { granted in
                DispatchQueue.main.async {
                    if granted {
                        print("Notifications enabled")
                    } else {
                        sender.setOn(false, animated: true)
                        self.showPermissionAlert()
                    }
                }
            }
        } else {
            print("Notifications disabled")
        }
    }
    
    @IBAction func themeChanged(_ sender: UISegmentedControl) {
        UserDefaults.standard.set(sender.selectedSegmentIndex, forKey: "themePreference")
        applyTheme(index: sender.selectedSegmentIndex)
    }
    
    private func applyTheme(index: Int) {
        let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        let window = windowScene?.windows.first
        
        switch index {
        case 0: window?.overrideUserInterfaceStyle = .light
        case 1: window?.overrideUserInterfaceStyle = .dark
        default: window?.overrideUserInterfaceStyle = .unspecified
        }
    }
    
    // MARK: - Notifications Permission
    
    private func requestNotificationPermission(completion: @escaping (Bool) -> Void) {
        UNUserNotificationCenter.current().getNotificationSettings { settings in
            if settings.authorizationStatus == .notDetermined {
                UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, _ in
                    completion(granted)
                }
            } else {
                completion(settings.authorizationStatus == .authorized)
            }
        }
    }
    
    private func showPermissionAlert() {
        let alert = UIAlertController(
            title: "Notifications Disabled",
            message: "To enable notifications, go to Settings > Notifications and allow permission.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
