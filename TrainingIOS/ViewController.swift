//
//  ViewController.swift
//  TrainingIOS
//
//  Created by mod bibi on 7/18/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: UIViewController, UITextFieldDelegate {

    // MARK: - IBOutlet
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    // MARK: Variables
    
    let baseLoginURL = "https://us-central1-travelworld-5d555.cloudfunctions.net/v1"
    let accessToken:UserDefaults = UserDefaults()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        txtEmail.borderTextField(color: UIColor.white, borderWidth: 1, corner: 22.5, placeholderText: "Email Address")
        txtPassword.borderTextField(color: UIColor.white, borderWidth: 1, corner: 22.5, placeholderText: "Password")

        btnLogin.layer.cornerRadius = 22.5
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.view.backgroundColor = UIColor.clear
        navigationController?.navigationBar.tintColor = UIColor.white
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
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
        
        let myActivityIndicator = createIndicator()
        view.addSubview(myActivityIndicator)
        
        self.callLoginAPI(username: email, password: password, loginActivityIndicator: myActivityIndicator)
    }
    
    // MARK: - Call API
    
    func callLoginAPI(username:String, password:String, loginActivityIndicator: UIActivityIndicatorView) {
        let postString = ["username": username, "password": password]
        var request = URLRequest(url:URL(string: baseLoginURL+"/user/login")!)
        DispatchQueue.global().async {
            
        
            request.httpMethod = "POST"
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.httpBody = try! JSONSerialization.data(withJSONObject: postString)
            let session = URLSession.shared
        
            session.dataTask(with: request) { data, response, err in
                if err != nil {
                    print("\(String(describing: err))")
                    return
                }
            
                guard let data = data else{
                    print("no data return")
                    return
                }
            
                let parseResult: [String:AnyObject]?
                do{
                    parseResult = try JSONSerialization.jsonObject(with: data, options:.allowFragments) as? [String:AnyObject]
                    print(parseResult!)
                    
                    if ((parseResult?["access_token"] as? String) != nil) {
                        DispatchQueue.main.async{
                            self.accessToken.setValue(parseResult?["access_token"]!, forKey: "access_token")
                            self.accessToken.synchronize()
                            loginActivityIndicator.stopAnimating()
                            self.switchToMainAPP()
                        }
                    }else{
                        print("Login failed")
                        DispatchQueue.main.async {
                            return self.showAlert(title: "Notification", message: "Login failed, Please check email or password again")
                        }
                    }
                    
                } catch {
                    print("Could not parse data as Json \(String(describing: data))")
                    return
                }
            }.resume()
        }
    }
    
    
    
    // MARK: - function
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 50), animated: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
    }
}




