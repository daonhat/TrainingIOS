
import UIKit

extension UITextField {
    func borderTextField(color: UIColor, borderWidth: CGFloat, corner: CGFloat, placeholderText: String) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = corner
        
        let clearButton : UIButton = self.value(forKey: "_clearButton") as! UIButton
        let imageclear = UIImage(named: "clearbtn")
        
        clearButton.setImage(imageclear, for: .normal)
        clearButton.backgroundColor = UIColor.white
        self.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                            attributes: [NSForegroundColorAttributeName: UIColor.white])
    }
    
}
