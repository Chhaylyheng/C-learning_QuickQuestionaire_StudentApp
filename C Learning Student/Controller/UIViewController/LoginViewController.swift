//
//  LoginViewController.swift
//  C Learning Teacher
//
//  Created by kit on 2/14/2561 BE.
//  Copyright © 2561 BE kit. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var pwTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var signInBtn: UIButton!
    
}

// APP LYCLE

extension LoginViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnUI()
        TextField()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}


// APP UI
extension LoginViewController {
    
    func BtnUI() {
        MakeBtnWhiteBorder(button: signInBtn, color: UIColor.white)

    }
    
    func MakeFBBorderBtn(button: UIButton) {
        button.backgroundColor = UIColor(red:0.23, green:0.35, blue:0.60, alpha:1.0)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(red:0.23, green:0.35, blue:0.60, alpha:1.0).cgColor
        button.layer.cornerRadius = 5
    }
    func TextField() {
        MakeLeftViewIconToTextField(textField: emailTextField, icon: "icon-user")
        MakeLeftViewIconToTextField(textField: pwTextField, icon: "pw-icon")
    }
    func MakeBtnWhiteBorder(button: UIButton, color: UIColor) {
        button.layer.borderWidth = 1
        button.layer.borderColor = color.cgColor
        button.layer.cornerRadius = 8
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case self.emailTextField:
            pwTextField.becomeFirstResponder()
        default:
            pwTextField.resignFirstResponder()
        }
        return true
    }
    func MakeLeftViewIconToTextField(textField: UITextField, icon: String) {
        let imageView = UIImageView();
        let image = UIImage(named: icon);
        imageView.image = image;
        imageView.frame = CGRect(x: Int(textField.frame.height / 3), y: Int(textField.frame.height / 3), width: Int(textField.frame.height / 2.5), height: Int(textField.frame.height / 2.5))
        textField.addSubview(imageView)
        let leftView = UIView.init(frame: CGRect(x: 10, y: 10, width: textField.frame.height, height: 25))
        textField.leftView = leftView;
        textField.leftViewMode = UITextFieldViewMode.always
        
    }
    
}
