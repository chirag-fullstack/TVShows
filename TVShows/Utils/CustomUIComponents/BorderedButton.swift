import UIKit

class RoundedButton: UIButton {
    override func draw(_ rect: CGRect) {
        super.draw(rect)

        self.layer.cornerRadius = self.frame.height/2
    }
}
