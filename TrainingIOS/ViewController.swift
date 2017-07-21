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
    

}




