//
//  ForgotPasswordViewController.swift
//  Manipal
//
//  Created by DB-MM-034 on 21/09/22.
//

import UIKit
import DTTextField

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtFieldEmail: DTTextField!
    @IBOutlet weak var txtFieldMobile: DTTextField!
    
    let viewModel = ForgotPasswordViewModel()
    var forgotPasswordRequestModel = ForgotPasswordRequestModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    func initialSetup() {
        txtFieldEmail.borderColor = .clear
        txtFieldMobile.borderColor = .clear
        txtFieldMobile.delegate = self
    }
    

    @IBAction func btnBackTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSendTapped(_ sender: UIButton) {
        validate()
    }
    
    func validate(){
        let phone = txtFieldMobile.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = txtFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        var message = ""
        if phone?.isEmpty == true{
            message = Message.emptyPhone
            txtFieldMobile.showError(message: message)
        }
        else if (phone?.count ?? 0) != 10 {
            message = Message.validPhoneNumber
            txtFieldMobile.showError(message: message)
        }
        
        if email?.isEmpty == true {
            message = Message.emailIsEmpty
            txtFieldEmail.showError(message: message)
        }
        else if Validation().validateEmail(enteredEmail: email ?? "") == false {
            message = Message.correctEmailId
            txtFieldEmail.showError(message: message)
        }
        
        if message.isEmpty {
            forgotPasswordAPICall()
        }
    }
    
    func forgotPasswordAPICall() {
        forgotPasswordRequestModel.emailId = txtFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        forgotPasswordRequestModel.mobileNumber = txtFieldMobile.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        viewModel.apicallForForgotPassword(forgotPasswordRequestModel) { (status, data) in
            if status == .Success{
                self.showToast(message: self.viewModel.successMessage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if let NextVc =  Storyboard.onboard.instantiateViewController(withIdentifier: Screen.SIGNUPVERIFYVIEWCONTROLLER) as? SignUpVerifyViewController {
                        NextVc.forgotPasswordFlow = true
                        NextVc.mobileNum = self.forgotPasswordRequestModel.mobileNumber
                        NextVc.emailID = self.forgotPasswordRequestModel.emailId
                        self.navigationController?.pushViewController(NextVc, animated: true)
                    }
                }
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
}


extension ForgotPasswordViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFieldMobile {
            let currentString = textField.text ?? ""
            guard let stringRange = Range(range, in: currentString) else { return false }
            let newString = currentString.replacingCharacters(in: stringRange, with: string)
            return newString.count <= 10
        }
        return true
    }
}
