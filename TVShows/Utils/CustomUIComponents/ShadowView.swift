import UIKit

class ShadowView: UIView {
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        self.addShadow()
    }
}
