import UIKit
import Nuke

class TVShowCollectionViewCell: UICollectionViewCell, ReusableView {

    // MARK: Outlets

    @IBOutlet weak var slideImageView: UIImageView!
    @IBOutlet weak var slideTitle: UILabel!

    // MARK: Variables

    var slideInfo: SlideInfo? {
        didSet {
            guard let _slideInfo = self.slideInfo else { return }
            self.slideTitle.text = _slideInfo.title
            self.loadImage(urlString: _slideInfo.imageURL)
        }
    }

    // MARK: Class methods

    static func getReuseIdentifier() -> String {
        return "TVShowCollectionViewCell"
    }

    // MARK: Overriden methods

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // Add gradient
        self.slideImageView.addGradient(colors: [.black, .clear, .clear, .black])
    }

    // MARK: Helper methods

    private func loadImage(urlString: String) {
        if let url = URL(string: urlString) {
            let req = ImageRequest(
                url: url, processors: [ImageProcessors.Resize(size: self.slideImageView.bounds.size)]
            )
            let options = ImageLoadingOptions(
                placeholder: nil, transition: .none, failureImage: UIImage(), failureImageTransition: .none,
                contentModes: .init(success: .scaleAspectFill, failure: .center, placeholder: .center)
            )
            Nuke.loadImage(with: req, options: options, into: self.slideImageView, progress: nil, completion: nil)
        }
    }
}
