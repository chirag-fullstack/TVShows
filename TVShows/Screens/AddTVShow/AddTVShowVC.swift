import Foundation
import UIKit
import ProgressHUD

class AddTVShowVC: UIViewController {

    // MARK: - Outlets

    @IBOutlet private weak var titleTextField: BorderedTextField!
    @IBOutlet private weak var yearTextField: BorderedTextField!
    @IBOutlet private weak var seasonsTextField: BorderedTextField!
    @IBOutlet private weak var saveButton: RoundedButton!

    // MARK: - Variables

    let yearPickerView = UIPickerView()

    var presenter: AddTVShowPresenter!

    var onShowSaveSuccess: ((TVShow) -> Void)?

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialise Presenter
        self.presenter = AddTVShowPresenter(service: self)
        // Setup picker
        self.setupYearPicker()
    }

    // MARK: Helper Methods

    func setupYearPicker() {
        let toolBar = UIToolbar()
        let buttonDone = UIBarButtonItem(
            title: Constants.Strings.doneTitle, style: .done, target: self, action: #selector(self.yearPickingDone)
        )
        let buttonCancel = UIBarButtonItem(
            title: Constants.Strings.cancelTitle, style: .plain, target: self,
            action: #selector(self.yearPickignCancelled)
        )
        let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)

        toolBar.sizeToFit()
        toolBar.setItems([buttonCancel, spacer, buttonDone], animated: true)
        toolBar.isUserInteractionEnabled = true

        self.yearTextField.inputAccessoryView = toolBar
        self.yearTextField.inputView = yearPickerView

        yearPickerView.dataSource = self
        yearPickerView.delegate = self
        yearPickerView.selectRow(self.presenter.selectedYearIndex, inComponent: 0, animated: true)
    }

    @objc private func yearPickingDone() {
        self.presenter.selectYear(at: self.yearPickerView.selectedRow(inComponent: 0))
        self.view.endEditing(true)
    }

    @objc private func yearPickignCancelled() {
        self.view.endEditing(true)
    }

    // MARK: - Action Methods

    @IBAction func saveButtonClicked() {
        self.presenter.addTVShow(
            title: self.titleTextField.text, year: self.yearTextField.text, seasons: self.seasonsTextField.text
        )
    }

    @IBAction func cancel() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddTVShowVC: AddTVShowDelegate {
    func showLoader() {
        ProgressHUD.show()
    }

    func hideLoader() {
        ProgressHUD.dismiss()
    }

    func showErrorAlert(error: String) {
        showAlert(title: Constants.ErrorMessages.errorTitle, message: error)
    }

    func didAddTVShow(tvShow: TVShow) {
        self.onShowSaveSuccess?(tvShow)
        self.dismiss(animated: true, completion: nil)
    }

    func didSelectYear(year: String) {
        self.yearTextField.text = year
    }
}

extension AddTVShowVC: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.presenter.years.count
    }
}

extension AddTVShowVC: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.presenter.years[row].description
    }
}
