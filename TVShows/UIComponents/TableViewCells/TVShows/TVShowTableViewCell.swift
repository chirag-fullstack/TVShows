import UIKit

class TVShowTableViewCell: UITableViewCell, ReusableView {

    // MARK: Outlets

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var yearLabel: UILabel!
    @IBOutlet private weak var seasonsLabel: UILabel!

    // MARK: Variables

    var tvShow: TVShow? {
        didSet {
            guard let _tvShow = tvShow else { return }
            self.titleLabel.text = _tvShow.title.description
            self.yearLabel.text = _tvShow.year.description
            self.seasonsLabel.text = getSeasonsTextForDisplay(seasons: _tvShow.seasons)
        }
    }

    // MARK: Class Methods

    static func getReuseIdentifier() -> String {
        return "TVShowTableViewCell"
    }

    // MARK: Private Helper Methods

    private func getSeasonsTextForDisplay(seasons: Int) -> String {
        return seasons == 1
            ? "\(seasons.description) Season"
            : "\(seasons.description) Seasons"
    }
}
