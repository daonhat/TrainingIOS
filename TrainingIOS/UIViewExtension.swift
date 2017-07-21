
import UIKit

extension UIView {
    func borderButtonAddPhoto(button:UIButton, color: UIColor, borderWidth: CGFloat, corner: CGFloat){
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = color.cgColor
        button.layer.cornerRadius = corner
    }
}
