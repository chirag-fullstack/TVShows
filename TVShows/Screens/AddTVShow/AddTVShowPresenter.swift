import Foundation

enum FieldName: String {
    case title
    case year
    case seasons

    var type: FieldType {
        switch self {
        case .title:
            return .text
        case .year:
            return .year
        case .seasons:
            return .number
        }
    }
}

enum FieldType: String {
    case text
    case year
    case number
}

enum AddTVError: Error {
    case emptyField(fieldName: FieldName)
    case invalidType(fieldName: FieldName)
    case invalidValue(fieldName: FieldName)
    case allFieldsRequired

    var errorMessage: String {
        switch self {
        case .emptyField(fieldName: let fieldName):
            return "\(fieldName.rawValue) can not be empty"
        case .invalidType(fieldName: let fieldName):
            return "\(fieldName.type.rawValue) is expected for \(fieldName.rawValue)"
        case .invalidValue(fieldName: let fieldName):
            return "Invalid value for \(fieldName.rawValue)"
        case .allFieldsRequired:
            return "All fields are required"
        }
    }
}

// swiftlint:disable:next class_delegate_protocol
protocol AddTVShowDelegate: ViewService {
    func didAddTVShow(tvShow: TVShow)
    func didSelectYear(year: String)
}

class AddTVShowPresenter {

    // MARK: - Properties

    private weak var service: AddTVShowDelegate?

    private let minReleaseYear = 1928
    private var selectedYear: Int?

    private(set) lazy var years: [Int] = {
        return [Int](minReleaseYear...Date.yearValue)
    }()

    var selectedYearIndex: Int {
        let indexOfLatestYear = self.years.count - 1
        // If year is not selected till now, set the latest year
        guard let _selectedYear = self.selectedYear else { return indexOfLatestYear }
        return self.years.firstIndex(of: _selectedYear) ?? indexOfLatestYear
    }

    // MARK: - Initialiser Methods

    init(service: AddTVShowDelegate) {
        self.service = service
    }

    // MARK: - Methods For Controller

    func addTVShow(title: String?, year: String?, seasons: String?) {
        guard self.validateInput(title: title, year: year, seasons: seasons) else { return }

        let tvShow = TVShow(title: title!, year: Int(year!)!, seasons: Int(seasons!)!)

        self.service?.showLoader()

        CloudStoreManager.shared.addTVShow(tvShow: tvShow) { [weak self] result in
            self?.service?.hideLoader()
            switch result {
            case let .failure(error):
                self?.service?.showErrorAlert(error: error.localizedDescription)
            case let .success(tvShow):
                self?.service?.didAddTVShow(tvShow: tvShow)
            }
        }
    }

    func selectYear(at index: Int) {
        self.selectedYear = self.years[index]
        self.service?.didSelectYear(year: self.years[index].description)
    }

    // MARK: - Private Methods

    private func validateInput(title: String?, year: String?, seasons: String?) -> Bool {
        guard let _title = title, let _year = year, let _seasons = seasons,
            !_title.isEmpty(), !_year.isEmpty(), !_seasons.isEmpty() else {
                self.service?.showErrorAlert(error: AddTVError.allFieldsRequired.errorMessage)
                return false
        }

        var errors: [AddTVError] = []

        if let yearError = validateYear(year: _year) {
            errors.append(yearError)
        }

        if let seasonsError = validateSeasons(seasons: _seasons) {
            errors.append(seasonsError)
        }

        if errors.isEmpty { return true }

        let errorMessage = errors.reduce("") { $0 + "\n\u{2022} " + $1.errorMessage }

        self.service?.showErrorAlert(error: errorMessage)

        return false
    }

    private func validateYear(year: String) -> AddTVError? {
        if let yearIntValue = Int(year) {
            if yearIntValue <= Date.yearValue && yearIntValue > 1900 {
                return nil
            } else {
                return AddTVError.invalidValue(fieldName: .year)
            }
        } else {
            return AddTVError.invalidType(fieldName: .year)
        }
    }

    private func validateSeasons(seasons: String) -> AddTVError? {
        if let seasonsIntValue = Int(seasons) {
            if seasonsIntValue > 0 {
                return nil
            } else {
                return AddTVError.invalidValue(fieldName: .seasons)
            }
        } else {
            return AddTVError.invalidType(fieldName: .seasons)
        }
    }
}
