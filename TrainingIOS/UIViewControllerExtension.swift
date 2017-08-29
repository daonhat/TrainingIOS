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
    
        
    // Hide the keyboard when the return key pressed
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    func switchToMainAPP() {
        present( UIStoryboard(name: "MainApp", bundle: nil).instantiateViewController(withIdentifier: "MainApp") as! UITabBarController, animated: true, completion: nil)
    }
    
    func createIndicator() ->  UIActivityIndicatorView{
        let myActivityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.whiteLarge)
        myActivityIndicator.color = UIColor.red
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        
        return myActivityIndicator
    }



}
