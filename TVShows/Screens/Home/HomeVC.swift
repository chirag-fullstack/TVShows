import Foundation
import UIKit
import MaterialComponents
import ProgressHUD

class HomeVC: UIViewController {

    // MARK: Outlets

    @IBOutlet private weak var tvShowTableView: BaseTableView!

    // MARK: Variables

    private let refreshControl = UIRefreshControl()

    var presenter: HomePresenter!

    // MARK: Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Initialise presenter
        self.presenter = HomePresenter(service: self)
        self.presenter.fetchAllShows()
        // Setup table view for the list of shows
        self.setupTableView()
    }

    // MARK: Segues

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         guard let controller = segue.destination as? AddTVShowVC else { return }

         controller.onShowSaveSuccess = { [weak self] show in
             self?.presenter.appendTvShows(tvShow: show)
         }
     }

    // MARK: Helper Methods

    fileprivate func setupTableView() {
        // Register custom XIB cells
        self.tvShowTableView.registerCell(
            TVShowTableViewCell.self, reuseIdentifier: TVShowTableViewCell.getReuseIdentifier()
        )
        self.tvShowTableView.registerCell(
            CarauselTableViewCell.self, reuseIdentifier: CarauselTableViewCell.getReuseIdentifier()
        )
        // Set data source and delegate
        self.tvShowTableView.dataSource = self
        self.tvShowTableView.delegate = self
        // Confugure automatic height for row
        self.tvShowTableView.rowHeight = UITableView.automaticDimension
        self.tvShowTableView.estimatedRowHeight = 80
        // Configure Refresh Control
        self.tvShowTableView.refreshControl = refreshControl
        self.refreshControl.addTarget(self, action: #selector(self.refreshShowsList), for: .valueChanged)
    }

    @objc private func refreshShowsList() {
        self.presenter.fetchAllShows()
    }
}

extension HomeVC: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.presenter.sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let homeSection = HomePresenter.HomeSection(rawValue: section) else { return 0 }
        return presenter.getRowsCount(section: homeSection)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let homeSection = HomePresenter.HomeSection(rawValue: indexPath.section)
            else { return UITableViewCell() }

        switch homeSection {
        case .slides:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CarauselTableViewCell.getReuseIdentifier())
                as? CarauselTableViewCell else { return CarauselTableViewCell() }
            cell.slides = presenter.slides
            return cell

        case .showsList:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: TVShowTableViewCell.getReuseIdentifier())
                as? TVShowTableViewCell else { return TVShowTableViewCell() }
            cell.tvShow = presenter.tvShows[indexPath.row]
            return cell
        }
    }
}

extension HomeVC: UITableViewDelegate {
    func tableView(
        _ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath
    ) {
        self.presenter.handleEditing(editingStyle: editingStyle, indexPath: indexPath)
    }
}

extension HomeVC: HomeDelegate {
    func showLoader() {
        ProgressHUD.show()
    }

    func hideLoader() {
        ProgressHUD.dismiss()
    }

    func didUpdateShowsList() {
        if presenter.getRowsCount(section: .showsList) == 0 {
            tvShowTableView.setEmptyView(messageImage: #imageLiteral(resourceName: "empty"))
        } else {
            tvShowTableView.restore()
        }
        self.tvShowTableView.reloadData()
        self.refreshControl.endRefreshing()
    }

    func removeShow(indexPath: IndexPath) {
        self.tvShowTableView.beginUpdates()
        self.tvShowTableView.deleteRows(at: [indexPath], with: .fade)
        self.tvShowTableView.endUpdates()
    }

    func showErrorAlert(error: String) {
        self.showAlert(message: error)
    }
}
