import Foundation
import UIKit

// swiftlint:disable:next class_delegate_protocol
protocol HomeDelegate: ViewService {
    func didUpdateShowsList()
    func removeShow(indexPath: IndexPath)
}

class HomePresenter {

    enum HomeSection: Int, CaseIterable {
        case slides
        case showsList
    }

    private weak var service: HomeDelegate?

    let maxNumberOfSlide: Int = 3

    private(set) var sections: [HomeSection] = HomeSection.allCases
    private(set) var tvShows: [TVShow] = []

    var slides: [SlideInfo] {
        return [SlideInfo](
            tvShows.compactMap({ SlideInfo(imageURL: Constants.Other.imageURL, title: $0.title) })
                .prefix(maxNumberOfSlide)
        )
    }

    // MARK: - Initialiser

    init(service: HomeDelegate) {
        self.service = service
    }

    // MARK: - Private Methods

    private func deleteShow(indexPath: IndexPath) {
        self.service?.showLoader()
        let tvShow = self.tvShows[indexPath.row]
        CloudStoreManager.shared.deleteTVShow(tvShow: tvShow) { [weak self] result in
            self?.service?.hideLoader()
            switch result {
            case .failure(let error):
                self?.service?.showErrorAlert(error: error.localizedDescription)
            case .success(let isSuccess):
                if isSuccess {
                    self?.tvShows.remove(at: indexPath.row)
                    self?.service?.removeShow(indexPath: indexPath)
                } else {
                    self?.service?.showErrorAlert(error: "Unable to delete now.\nTry again later.")
                }
            }
        }
    }

    // MARK: - Controller Methods

    func appendTvShows(tvShow show: TVShow) {
        self.tvShows.append(show)
        self.service?.didUpdateShowsList()
    }

    func getRowsCount(section: HomeSection) -> Int {
        switch section {
        case .slides:
            return 1
        case .showsList:
            return tvShows.count
        }
    }

    func fetchAllShows() {
        self.service?.showLoader()
        CloudStoreManager.shared.getTVShows { [weak self] result in
            self?.service?.hideLoader()
            switch result {
            case .failure(let error):
                self?.service?.showErrorAlert(error: error.localizedDescription)
            case .success(let tvShows):
                self?.tvShows = tvShows
                self?.service?.didUpdateShowsList()
            }
        }
    }

    func handleEditing(editingStyle: UITableViewCell.EditingStyle, indexPath: IndexPath) {
        switch editingStyle {
        case .delete:
            self.deleteShow(indexPath: indexPath)
        default:
            return
        }
    }
}
