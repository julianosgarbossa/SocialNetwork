import UIKit

final class PaddedTextField: UITextField {
    var padding = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10) {
        didSet {
            setNeedsLayout()
            setNeedsDisplay()
        }
    }

    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: padding)
    }
}
