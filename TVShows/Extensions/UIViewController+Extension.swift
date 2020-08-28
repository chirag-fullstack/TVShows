import UIKit

extension UIViewController {
    func showAlert(title: String? = nil, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        let paragraphStyle = NSMutableParagraphStyle()

        paragraphStyle.alignment = .left

        let messageText = NSAttributedString(
            string: message, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle]
        )

        alert.setValue(messageText, forKey: "attributedMessage")
        alert.addAction(dismissAction)

        self.present(alert, animated: true, completion: nil)
    }
}
