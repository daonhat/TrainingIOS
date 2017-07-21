
import UIKit

class RegisterController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhoneNumber: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnAddPhoto: UIButton!
    @IBOutlet weak var btnRegister: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        txtName.borderTextField(color: UIColor.white, borderWidth: 1, corner: 25, placeholderText: "Name or Surname")
        txtEmail.borderTextField(color: UIColor.white, borderWidth: 1, corner: 25, placeholderText: "Email Address")
        txtPhoneNumber.borderTextField(color: UIColor.white, borderWidth: 1, corner: 25, placeholderText: "Phone number")
        txtPassword.borderTextField(color: UIColor.white, borderWidth: 1, corner: 25, placeholderText: "Password")
        
        btnAddPhoto.borderButtonAddPhoto(button: btnAddPhoto, color: UIColor.white, borderWidth: 1, corner: 50)
        
        btnRegister.layer.cornerRadius = 25
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    @IBAction func registerButtonClicked(_ sender: Any) {
        guard let name = txtName.text, name != "" else{
            return showAlert(title: "Notification", message: "Name can't be blank")
        }
        guard let email = txtEmail.text, isValidEmail(testStr: email) else{
            return showAlert(title: "Notification", message: "Email wrong format")
        }
        guard let phone = txtPhoneNumber.text, phone != "" else{
            return showAlert(title: "Notification", message: "Phone can't be blank")
        }
        guard let password = txtPassword.text, password.characters.count > 6 else{
            return showAlert(title: "Notification", message: "password too short. Please input password > 6 characters")
        }
        gotoScr(scrID: "mainscr", controllerName: MainController())
        
    }
    

}
