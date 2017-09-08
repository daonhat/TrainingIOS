//
//  CommentViewController.swift
//  TrainingIOS
//
//  Created by DaoNhat on 8/17/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var txtComent: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var bottomTextFieldConstrain: NSLayoutConstraint!
    @IBOutlet weak var imageViewAvata: UIImageView!
    @IBOutlet weak var lblContentStatus: UILabel!
    @IBOutlet weak var imageContentStatus: UIImageView!
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var bottomScrollViewConstrain: NSLayoutConstraint!
    var status:Status!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(changeInputMode), name: NSNotification.Name.UITextInputCurrentInputModeDidChange, object: nil)
        if self.status.type == "status"{
            imageViewAvata.image = #imageLiteral(resourceName: "ic_ava_1")
            lblUserName.text = "Andrea Kim"
            lblContentStatus.text = self.status.status
            imageContentStatus.image = nil
            
        }else{
            imageViewAvata.image = self.status.avatar
            lblUserName.text = self.status.userName
            lblContentStatus.text = self.status.content
            imageContentStatus.image = self.status.image
        }
        // Do any additional setup after loading the view.
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func keyboardWillShow(notification:NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        let heightOfTabbar = self.tabBarController?.tabBar.frame.height
        let keyboardHeight = keyboardFrame.height - heightOfTabbar!
        let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        UIView.animate(withDuration: duration, animations: {
            self.bottomScrollViewConstrain.constant = keyboardHeight + 45;
            self.bottomTextFieldConstrain.constant = keyboardHeight
        }, completion: nil)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.1, animations: {
            self.bottomScrollViewConstrain.constant = 45;
            self.bottomTextFieldConstrain.constant = 0
        }, completion: nil)
        
    }
    
    func changeInputMode(notification : NSNotification)
    {
        
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
    }
}
