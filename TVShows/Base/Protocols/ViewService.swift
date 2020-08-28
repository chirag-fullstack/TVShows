import Foundation

protocol ViewService: class {
    func showErrorAlert(error: String)
    func showLoader()
    func hideLoader()
}
