//
//  SplashViewController.swift
//  TrainingIOS
//
//  Created by DaoNhat on 8/29/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

class SplashViewController: UIViewController {
    //MARK: -Variables
    let delayTime = DispatchTime.now() + 2

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let myActivityIndicator = createIndicator()
        view.addSubview(myActivityIndicator)
        
        DispatchQueue.global().async {
            if ((UserDefaults.standard.value(forKey: "access_token") as? String) != nil) {
                DispatchQueue.main.asyncAfter(deadline: self.delayTime) {
                    myActivityIndicator.stopAnimating()
                    self.switchToMainAPP()
                }
            }
            else{
                DispatchQueue.main.asyncAfter(deadline: self.delayTime) {
                    myActivityIndicator.stopAnimating()
                    self.switchToLoginScreen()
                }
            }
        }

    }
    
    
    //MARK: - function
    
        
    func switchToLoginScreen() {
        present( UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "Main") as! UINavigationController, animated: true, completion: nil)
    }
}
