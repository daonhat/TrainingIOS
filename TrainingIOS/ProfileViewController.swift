//
//  ProfileViewController.swift
//  TrainingIOS
//
//  Created by DaoNhat on 8/22/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, EditProfileControllerProtocol {
    var userData:User = User(userName: "Dao Nhat", email: "daonhat12@gmail.com", avatar: #imageLiteral(resourceName: "ic_ava_1"), dob: Date.convertStringToDate(fromString: "1994-09-02", format: "yyyy-MM-dd")!)


    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblDateOfBirth: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageAvatar.layer.cornerRadius = self.imageAvatar.frame.width/2.0
        self.imageAvatar.layer.masksToBounds = true
        imageAvatar.image = userData.avatar
        lblUserName.text = userData.userName
        lblEmail.text = userData.email
        let dateDoB = Date.convertDateToString(fromDate: userData.dob, format: "dd/MM/yyyy")
        lblDateOfBirth.text = dateDoB
    }
    @IBAction func btnEditProfileClicked(_ sender: Any) {
        let editProfileVC = self.storyboard!.instantiateViewController(withIdentifier: "EditProfile") as! EditProfileViewController
        
        let navController = UINavigationController(rootViewController: editProfileVC)
        self.present(navController, animated: true, completion: nil)
        
        editProfileVC.delegate = self
        editProfileVC.avatarToDisplay = self.imageAvatar.image
        editProfileVC.nameToDisplay = self.lblUserName.text!
        editProfileVC.emailToDisplay = self.lblEmail.text!
        editProfileVC.dobToDisplay = self.lblDateOfBirth.text!
    }
    
    
    func changeDataUser(user: User){
        self.imageAvatar.image = user.avatar!
        self.lblUserName.text = user.userName!
        self.lblEmail.text = user.email!
        let dateDoB = Date.convertDateToString(fromDate: user.dob, format: "dd/MM/yyyy")
        self.lblDateOfBirth.text = dateDoB
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
