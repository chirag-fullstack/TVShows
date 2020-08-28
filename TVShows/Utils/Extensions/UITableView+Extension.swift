import UIKit

extension UITableView {
    func registerCell<T: UITableViewCell>(_ cell: T.Type, reuseIdentifier: String) {
        let cellNib = UINib(nibName: String(describing: cell.self), bundle: nil)
        self.register(cellNib, forCellReuseIdentifier: reuseIdentifier)
    }

    func setEmptyView(messageImage: UIImage) {
        let emptyView = UIView(
            frame: CGRect(
                x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height
            )
        )

        let messageImageView = UIImageView()
        let imageHeight = CGFloat(200)

        messageImageView.backgroundColor = .clear
        messageImageView.translatesAutoresizingMaskIntoConstraints = false

        emptyView.addSubview(messageImageView)

        messageImageView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        messageImageView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor, constant: 0).isActive = true
        messageImageView.widthAnchor.constraint(equalToConstant: imageHeight).isActive = true
        messageImageView.heightAnchor.constraint(equalToConstant: imageHeight).isActive = true

        messageImageView.image = messageImage

        UIView.animate(withDuration: 1, animations: {
            messageImageView.transform = CGAffineTransform(rotationAngle: .pi / 10)
        }, completion: { _ in
            UIView.animate(withDuration: 1, animations: {
                messageImageView.transform = CGAffineTransform(rotationAngle: -1 * (.pi / 10))
            }, completion: { _ in
                UIView.animate(withDuration: 1, animations: {
                    messageImageView.transform = CGAffineTransform.identity
                })
            })
        })

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }

    func restore() {
        self.backgroundView = nil
    }
}
