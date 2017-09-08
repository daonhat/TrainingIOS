//
//  NewStatusViewController.swift
//  TrainingIOS
//
//  Created by DaoNhat on 8/4/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

class NewStatusViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tvContent_Status: UITextView!
    @IBOutlet weak var txtContent_Status: UITextField!
    @IBOutlet weak var bottomTvConstraint: NSLayoutConstraint!
    var status:Status?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tvContent_Status.text = "Andrea Kim, would you like to post status"
        tvContent_Status.textColor = UIColor.lightGray
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)



        // Do any additional setup after loading the view.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func doneBtnClicked(_ sender: Any) {
        
        guard let content = self.tvContent_Status.text, content.characters.count > 0 else{
            return showAlert(title: "Notification", message: "Please write something after post new status")
        }
        
        let jsonNewStatus:[String: Any] = [
            "comment_cnt": 0,
            "created_at": "",
            "id": 1,
            "like_cnt": 10,
            "share_cnt": 0,
            "status": self.tvContent_Status.text!,
            "type": "status",
            "updated_at": "",
            "user_post": [
                "id": 1
            ]
        ]
        
        self.status = Status(jsonObject: jsonNewStatus as AnyObject)
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newStatus"), object: nil, userInfo: ["new_status": status!])
        self.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func canceBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Andrea Kim, would you like to post status"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func keyboardWillShow(notification:NSNotification) {
        var userInfo = notification.userInfo!
        var keyboardFrame:CGRect = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        keyboardFrame = self.view.convert(keyboardFrame, from: nil)
        let keyboardHeight = keyboardFrame.height
        let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
        UIView.animate(withDuration: duration, animations: {
            self.bottomTvConstraint.constant = keyboardHeight
        }, completion: nil)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.1, animations: {
            self.bottomTvConstraint.constant = 0
        }, completion: nil)
        
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
