//
//  EditProfileViewController.swift
//  TrainingIOS
//
//  Created by DaoNhat on 8/22/17.
//  Copyright © 2017 DaoNhat. All rights reserved.
//

import UIKit

protocol EditProfileControllerProtocol: class {
    func changeDataUser(user: User)
}

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    // MARK: - IBOutlet
    @IBOutlet weak var imageAvatar: UIImageView!
    @IBOutlet weak var txtUserName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtDOB: UITextField!
    @IBOutlet weak var contentViewConstrain: NSLayoutConstraint!
    @IBOutlet weak var backgroundScrollView: UIScrollView!
    
    // MARK: - Varialbes
    
    weak var delegate:EditProfileControllerProtocol?
    var nameToDisplay:String?
    var emailToDisplay:String?
    var dobToDisplay:String?
    var avatarToDisplay:UIImage?
    
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name:NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.setupTxtDob()
        
        self.txtEmail.keyboardType = UIKeyboardType.emailAddress
        
        self.imageAvatar.layer.cornerRadius = self.imageAvatar.frame.width/2.0
        self.imageAvatar.layer.masksToBounds = true
        
        imageAvatar.image = avatarToDisplay
        txtUserName.text = nameToDisplay
        txtEmail.text = emailToDisplay
        txtDOB.text = dobToDisplay
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        
        
        //tapToAvatar
        let tapGestureToAvatar = UITapGestureRecognizer(target: self, action: #selector(self.tapToAvatar(sender: )))
        tapGestureToAvatar.numberOfTapsRequired = 1
        imageAvatar.isUserInteractionEnabled = true
        imageAvatar.addGestureRecognizer(tapGestureToAvatar)
    }
    deinit {
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name:NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - Actions

    @IBAction func doneBtnClicked(_ sender: Any) {
        let dobNew = Date.convertStringToDate(fromString: txtDOB.text, format: "dd/mm/yyy")
        
        let userNew:User = User(userName: self.txtUserName.text, email: self.txtEmail.text, avatar: self.imageAvatar.image, dob: dobNew!)
        delegate?.changeDataUser(user: userNew)
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBtnClicked(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    // MARK: - Functions
    
    func setupTxtDob(){
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePickerMode.date
        txtDOB.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(self.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        txtDOB.text = dateFormatter.string(from: sender.date)
        
    }
    
    func tapToAvatar(sender: UITapGestureRecognizer){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        let actionSheet = UIAlertController(title: "Change Avatar", message: "", preferredStyle: UIAlertControllerStyle.actionSheet)
        
        let libButton = UIAlertAction(title: "Select From Library", style: UIAlertActionStyle.default){ (libSelected) -> Void in
            self.libPhoto(imagePicker: imagePicker)
        }
        
        let cameraButton = UIAlertAction(title: "Take Picture", style: UIAlertActionStyle.default){ (camSelected) -> Void in
            self.takePicture(imagePicker: imagePicker)
        }
        
        let cancelButton = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil)
        
        actionSheet.addAction(libButton)
        actionSheet.addAction(cameraButton)
        actionSheet.addAction(cancelButton)
        self.present(actionSheet, animated: true, completion: nil)
        
    }
    
    func libPhoto(imagePicker: UIImagePickerController) {
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func takePicture(imagePicker: UIImagePickerController){
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera){
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }else{
            let alertController = UIAlertController.init(title: nil, message: "Device has no camera.", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Alright", style: .default, handler: {(alert: UIAlertAction!) in
            })
            
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage{
            imageAvatar.contentMode = .scaleToFill
            imageAvatar.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
    
    func keyboardWillShow(notification:NSNotification) {
        adjustingHeight(show: true, notification: notification)
    }
    
    func keyboardWillHide(notification:NSNotification) {
        adjustingHeight(show: false, notification: notification)
    }
    
    func adjustingHeight(show:Bool, notification:NSNotification) {
        
        let userInfo = notification.userInfo!
        
        let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue
        
        let changeInHeight = (keyboardFrame.height) * (show ? 1 : -1)
        
        backgroundScrollView.contentInset.bottom = changeInHeight
        
        backgroundScrollView.scrollIndicatorInsets.bottom = changeInHeight
        
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
