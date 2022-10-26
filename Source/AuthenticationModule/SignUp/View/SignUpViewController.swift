//
//  SignUpViewController.swift
//  Manipal
//
//  Created by DB-MBP-008 on 22/09/22.
//

import UIKit
import DTTextField
import CryptoKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var txtFieldName: DTTextField!
    @IBOutlet weak var txtFieldDOB: DTTextField!
    @IBOutlet weak var txtFieldMobile: DTTextField!
    @IBOutlet weak var txtFieldEmail: DTTextField!
    @IBOutlet weak var txtFieldPassword: DTTextField!
    
    let viewModel = SignupViewModel()
    var signUpRequestModel = SignupRequestModel()
    var dobDatePicker = UIDatePicker()
    let cryptLib = CryptLib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        
    }
    
    func initialSetup() {
        txtFieldName.borderColor = .clear
        txtFieldDOB.borderColor = .clear
        txtFieldMobile.borderColor = .clear
        txtFieldEmail.borderColor = .clear
        txtFieldPassword.borderColor = .clear
        txtFieldName.delegate = self
        txtFieldMobile.delegate = self
        txtFieldDOB.delegate = self
        txtFieldDOB.inputView = dobDatePicker
    }
    
    
    @IBAction func btnSkipTapped(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            Constants.sceneDelegate?.navigationToScreen(identifier: Screen.TABBARCONTROLLER, storyboard: Storyboard.main)
        } else {
            // Fallback on earlier versions
            Constants.appDelegate?.navigationToScreen(identifier: Screen.TABBARCONTROLLER, storyboard: Storyboard.main)
        }
    }
    
    
    @IBAction func btnSignInTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func btnSignUpTapped(_ sender: UIButton) {
        let name = txtFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let dob = txtFieldDOB.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let phone = txtFieldMobile.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = txtFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let pwd = txtFieldPassword.text ?? ""
        
        var message = ""
        if name?.isEmpty == true{
            message = Message.name
            txtFieldName.showError(message: message)
        }
        if dob?.isEmpty == true{
            message = Message.dob
            txtFieldDOB.showError(message: message)
        }
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
        
        if pwd.isEmpty == true {
            message = Message.password
            txtFieldPassword.showError(message: message)
        }
        else if !LoginValidation.isValidupperCase(textStr: pwd) || !LoginValidation.isValidlowerCase(textStr: pwd) || !LoginValidation.isValidNumber(textStr: pwd) || !LoginValidation.isVaidSymbol(textStr: pwd) || pwd.count < 5{
            message = Message.password5Characters
            self.showToast(message: message)
        }
        
        if message.isEmpty {
            signUpApiCall()
        }
        
    }
    
    func signUpApiCall() {
        signUpRequestModel.name = txtFieldName.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        signUpRequestModel.emailId = txtFieldEmail.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        signUpRequestModel.mobileNumber = txtFieldMobile.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        signUpRequestModel.platformType = Constants.platformType
        let key =  Constants.secret
        guard let pwd = cryptLib.encryptPlainTextRandomIV(withPlainText: txtFieldPassword.text ?? "", key: key) else { return  }
        signUpRequestModel.password = pwd
        viewModel.apicallForRegister(signUpRequestModel) { (status, data) in
            if status == .Success{
                self.showToast(message: self.viewModel.successMessage)
                AppUserdefault.latitude = data?.defaultLatitude
                AppUserdefault.longitude = data?.defaultLongitude
                AppUserdefault.state = data?.defaultState
                AppUserdefault.city = data?.defaultCity
                AppUserdefault.pincode = data?.defaultPincode
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if let NextVc =  Storyboard.onboard.instantiateViewController(withIdentifier: Screen.SIGNUPVERIFYVIEWCONTROLLER) as? SignUpVerifyViewController{
                        NextVc.mobileNum = data?.mobileNumber
                        NextVc.emailID = data?.emailId
                        self.navigationController?.pushViewController(NextVc, animated: true)
                    }
                }
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    
}

extension SignUpViewController {
    func showDOBDatePicker(dobTextField: UITextField){
        dobDatePicker.timeZone = TimeZone.current
        dobDatePicker.datePickerMode = .date
        dobDatePicker.maximumDate = Date()
        
        if #available(iOS 13.4, *) {
            dobDatePicker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        //ToolBar
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneDOBDatePicker))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelDatePicker))
        
        toolbar.setItems([cancelButton,spaceButton,doneButton], animated: false)
        dobTextField.inputAccessoryView = toolbar
    }
    
    
    //Done date picker
    @objc func doneDOBDatePicker(){
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MMM-yyyy"
        txtFieldDOB.text = formatter.string(from: dobDatePicker.date)
        formatter.dateFormat = "yyyy-MM-dd"
        signUpRequestModel.dob = formatter.string(from: dobDatePicker.date)
        view.endEditing(true)
    }
    
    //Cancel date picker
    @objc func cancelDatePicker(){
        view.endEditing(true)
    }
}


extension SignUpViewController : UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == txtFieldMobile {
            let currentString = textField.text ?? ""
            guard let stringRange = Range(range, in: currentString) else { return false }
            let newString = currentString.replacingCharacters(in: stringRange, with: string)
            return newString.count <= 10
        }
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == txtFieldDOB {
            showDOBDatePicker(dobTextField: textField)
        }
    }
}


