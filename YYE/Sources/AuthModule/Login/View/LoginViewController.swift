//
//  LoginViewController.swift
//  YYE
//
//  Created by magesh on 22/04/21.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailContainerView: UIView!
    @IBOutlet weak var passWordContainerView: UIView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var showPassWordImageView: UIImageView!
    @IBOutlet weak var errorMessageLabel: UILabel!
    
    let viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func didClickshowPassword(_ sender: Any) {
        passWordTextField.isSecureTextEntry = !passWordTextField.isSecureTextEntry
        showPassWordImageView.image = UIImage(systemName: passWordTextField.isSecureTextEntry ? "eye.slash.fill" : "eye.fill")
    }
    
    @IBAction func didClickForgetPassword(sender: UIButton){
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "ForgetPasswordViewController") as? ForgetPasswordViewController {
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func didClickLogin(sender: UIButton){
        let validatedStatus = viewModel.validate()
        errorMessageLabel.isHidden = true
        if !validatedStatus.status{
            errorMessageLabel.text = validatedStatus.error?.localizedDescription
            errorMessageLabel.isHidden = false
            return
        }
        if let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabbarViewController") as? TabbarViewController {
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    @IBAction func didChangeText(_ sender: UITextField) {
        if sender == emailTextField{
            viewModel.setValue(value: sender.text ?? "", isEmail: true)
        }else if sender == passWordTextField{
            viewModel.setValue(value: sender.text ?? "", isEmail: false)
        }
    }
}

