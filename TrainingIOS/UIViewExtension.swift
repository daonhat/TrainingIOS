
import UIKit

extension UIView {
    func borderTextField(txtField:UITextField ,color: UIColor, borderWidth: CGFloat, corner: CGFloat) {
        txtField.layer.borderColor = color.cgColor
        txtField.layer.borderWidth = borderWidth
        txtField.layer.cornerRadius = corner
        
        let clearButton : UIButton = txtField.value(forKey: "_clearButton") as! UIButton
        let imageclear = UIImage(named: "clearbtn")
        
        clearButton.setImage(imageclear, for: .normal)
        clearButton.backgroundColor = UIColor.white
    }
    
    func borderButtonAddPhoto(button:UIButton, color: UIColor, borderWidth: CGFloat, corner: CGFloat){
        button.layer.borderWidth = borderWidth
        button.layer.borderColor = color.cgColor
        button.layer.cornerRadius = corner
    }
}
