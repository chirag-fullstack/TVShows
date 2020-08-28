import UIKit

extension UIView {
    func addGradient(colors: [UIColor]) {
        // Remove any existing gradient layer
        for (index, sublayer) in (self.layer.sublayers ?? []).enumerated() where sublayer is CAGradientLayer {
            self.layer.sublayers?.remove(at: index)
        }
        // Add new gradient layer
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.frame
        gradientLayer.colors = colors.compactMap({ $0.cgColor })
        gradientLayer.startPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }

    func addShadow(
        color: UIColor = UIColor.black,
        radius: CGFloat = Constants.DesignProperties.shadowRadius,
        offset: CGSize = Constants.DesignProperties.shadowOffset,
        opacity: Float = Constants.DesignProperties.shadowOpacity
    ) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowRadius = radius
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
    }
}
