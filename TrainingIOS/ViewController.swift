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

        txtEmail.borderTextField(color: UIColor.white, borderWidth: 1, corner: 25, placeholderText: "Email Address")
        txtPassword.borderTextField(color: UIColor.white, borderWidth: 1, corner: 25, placeholderText: "Password")

        btnLogin.layer.cornerRadius = 25
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.tintColor = UIColor.white
        
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
    
    

}




