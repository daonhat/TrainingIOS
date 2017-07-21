import UIKit


extension UIViewController {
    func showAlert(title:String, message:String){
        let messageErrors:UIAlertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let btnOK:UIAlertAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
        messageErrors.addAction(btnOK)
        
        present(messageErrors, animated: true, completion: nil)
    }
    
    func gotoScr<controllerName:UIViewController>(scrID:String, controllerName: controllerName){
        let scr = storyboard?.instantiateViewController(withIdentifier: scrID) as! controllerName
        present(scr, animated: true, completion: nil)
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: testStr)
    }
    
    // Start Editing The Text Field
    func textFieldDidBeginEditing(_ textField: UITextField) {
        moveTextField(textField: textField , moveDistance: -150, up: true)
    }
    
    // Finish Editing The Text Field
    func textFieldDidEndEditing(_ textField: UITextField) {
        moveTextField(textField: textField, moveDistance: -150, up: false)
    }
    
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func moveTextField(textField: UITextField, moveDistance: Int, up: Bool)  {
        let moveDuration = 0.2
        let movement: CGFloat = CGFloat(up ? moveDistance :  -moveDistance)
        
        UIView.beginAnimations("animateTextField", context: nil)
        UIView.setAnimationBeginsFromCurrentState(true)
        UIView.setAnimationDuration(moveDuration)
        self.view.frame = self.view.frame.offsetBy(dx: 0, dy: movement)
        UIView.commitAnimations()
    }


}
