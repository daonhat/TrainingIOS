//
//  ViewController.swift
//  TrainingIOS
//
//  Created by mod bibi on 7/18/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit


class ViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        txtEmail.borderTextField(txtField: txtEmail, color: UIColor.white, borderWidth: 1, corner: 25)
        txtPassword.borderTextField(txtField: txtPassword, color: UIColor.white, borderWidth: 1, corner: 25)

        btnLogin.layer.cornerRadius = 25
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func loginButtonClicked(_ sender: Any) {
        guard let email = txtEmail.text, isValidEmail(testStr: email) else{
            return showAlert(title: "Notification", message: "Email wrong format")
        }
        guard let password = txtPassword.text, password.characters.count > 6 else{
            return showAlert(title: "Notification", message: "password too short. Please input password > 6 characters")
        }
        gotoScr(scrID: "mainscr", controllerName: MainController())
        
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        gotoScr(scrID: "registerscr", controllerName: RegisterController())
    }
    
    
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        
        return emailTest.evaluate(with: testStr)
    }
    
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




