import UIKit

class BaseTableView: UITableView {

    // MARK: Overriden Methods

    override func awakeFromNib() {
        super.awakeFromNib()

        self.customise()
    }

    // MARK: Private Helper Methods

    private func customise() {
        self.separatorStyle = .none
    }
}
