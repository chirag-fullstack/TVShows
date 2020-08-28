import UIKit

class CarauselTableViewCell: UITableViewCell, ReusableView {

    // MARK: Outlets

    @IBOutlet weak var carouselCollectionView: UICollectionView!
    @IBOutlet weak var caraouselPageControl: UIPageControl!

    // MARK: Variables

    var slides: [SlideInfo] = [] {
        didSet {
            self.carouselCollectionView.reloadData()
            self.caraouselPageControl.numberOfPages = self.slides.count
        }
    }

    // MARK: Overriden Methods

    override func awakeFromNib() {
        super.awakeFromNib()

        self.setupCollectionView()
    }

    // MARK: ReusableView Methods

    static func getReuseIdentifier() -> String {
        return "CarauselTableViewCell"
    }

    // MARK: Private Helper Methods

    private func setupCollectionView() {
        self.carouselCollectionView.dataSource = self
        self.carouselCollectionView.delegate = self
        self.carouselCollectionView.registerCell(
            TVShowCollectionViewCell.self, reuseIdentifier: TVShowCollectionViewCell.getReuseIdentifier()
        )
    }

    // MARK: - SrollView Methods

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offSet = scrollView.contentOffset.x
        let width = scrollView.frame.width
        let horizontalCenter = width / 2
        // Set page control only when the cell is scrolled more than half
        caraouselPageControl.currentPage = Int(offSet + horizontalCenter) / Int(width)
    }
}

// MARK: - CollectionView DataSource Methods

extension CarauselTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slides.count
    }

    func collectionView(
        _ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: TVShowCollectionViewCell.getReuseIdentifier(), for: indexPath
            ) as? TVShowCollectionViewCell else { return TVShowCollectionViewCell() }
        cell.slideInfo = self.slides[indexPath.row]
        return cell
    }
}

// MARK: - UICollectionView Delegate FlowLayout Methods

extension CarauselTableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return collectionView.frame.size
    }

    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAt section: Int
    ) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }

    func collectionView(
        _ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    ) -> CGFloat {
        return UIEdgeInsets.zero.left
    }
}
