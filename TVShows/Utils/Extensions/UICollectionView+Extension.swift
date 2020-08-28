import UIKit

extension UICollectionView {
    func registerCell<T: UICollectionViewCell>(_ cell: T.Type, reuseIdentifier: String) {
        let cellNib = UINib(nibName: String(describing: cell.self), bundle: nil)
        self.register(cellNib, forCellWithReuseIdentifier: reuseIdentifier)
    }
}
