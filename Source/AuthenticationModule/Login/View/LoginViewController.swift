//
//  LoginViewController.swift
//  Manipal
//
//  Created by DB-MM-034 on 21/09/22.
//

import UIKit
import DTTextField
import CryptoKit

class LoginViewController: UIViewController {
    @IBOutlet weak var mobileNumberEmailTextField: DTTextField!
    @IBOutlet weak var passwordTextField: DTTextField!
    @IBOutlet weak var signupLabel: UILabel!
    
    let viewModel = LoginViewModel()
    var loginRequestModel = LoginRequestModel()
    let cryptLib = CryptLib()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    
    func initialize(){
        mobileNumberEmailTextField.borderColor = .clear
        passwordTextField.borderColor = .clear
        mobileNumberEmailTextField.delegate = self
    }
    @IBAction func skipTapped(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            Constants.sceneDelegate?.navigationToScreen(identifier: Screen.TABBARCONTROLLER, storyboard: Storyboard.main)
        } else {
            // Fallback on earlier versions
            Constants.appDelegate?.navigationToScreen(identifier: Screen.TABBARCONTROLLER, storyboard: Storyboard.main)
        }
    }
    
    @IBAction func forgotPasswordTapped(_ sender: UIButton) {
        if let nextVc =  Storyboard.main.instantiateViewController(withIdentifier:
                                                                    Screen.FORGOTPASSWORDVIEWCONTROLLER) as? ForgotPasswordViewController{
            self.navigationController?.pushViewController(nextVc, animated: true)
        }
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        validate()
    }
    
    @IBAction func signUpTapped(_ sender: UIButton) {
        if let ctrl = Storyboard.onboard.instantiateViewController(withIdentifier:
                                                                    Screen.SIGNUPVIEWCONTROLLER) as? SignUpViewController {
            self.navigationController?.pushViewController(ctrl, animated: true)
        }
    }
    
    func validate(){
        let emailOrMobile = mobileNumberEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let pwd = passwordTextField.text ?? ""
        var message = ""
        if emailOrMobile?.isEmpty == true{
            message = Message.emailAndMobileIsEmpty
            mobileNumberEmailTextField.showError(message: message)
        }
        if Int(emailOrMobile ?? "") == nil{
            if !LoginValidation.isValidEmail(testStr: emailOrMobile ?? ""){
                message = Message.correctEmailId
                mobileNumberEmailTextField.showError(message: message)
            }
        }else{
            if emailOrMobile?.count ?? 0 != 10 {
                message = Message.mobile
                mobileNumberEmailTextField.showError(message: message)
            }
        }
        if pwd.isEmpty {
            message = Message.password
            passwordTextField.showError(message: message)
        }
        if !LoginValidation.isValidupperCase(textStr: pwd) ||
            !LoginValidation.isValidlowerCase(textStr: pwd) ||
            !LoginValidation.isValidNumber(textStr: pwd) ||
            !LoginValidation.isVaidSymbol(textStr: pwd) || pwd.count < 5{
            message = Message.password5Characters
            self.showToast(message: message)
        }
        if message.isEmpty {
            signinApiCall()
        }
    }
    
    func signinApiCall(){
        loginRequestModel.emailId = mobileNumberEmailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let key =  Constants.secret
        guard let pwd = cryptLib.encryptPlainTextRandomIV(withPlainText: self.passwordTextField.text ?? "", key: key) else { return  }
        loginRequestModel.password = pwd
        loginRequestModel.platformType = Constants.platformType
        viewModel.apicallForLogin(loginRequestModel) { (status, data) in
            if status == .Success {
                AppUserdefault.latitude = data?.defaultLatitude
                AppUserdefault.longitude = data?.defaultLongitude
                AppUserdefault.state = data?.defaultState
                AppUserdefault.city = data?.defaultCity
                AppUserdefault.pincode = data?.defaultPincode
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if data?.registerStatus == RegisterStatus.basicInfo.rawValue {
                        if let nextVc =  Storyboard.onboard.instantiateViewController(withIdentifier:
                                                                                        Screen.SIGNUPVERIFYVIEWCONTROLLER) as? SignUpVerifyViewController {
                            nextVc.mobileNum = data?.mobileNumber
                            nextVc.emailID = data?.emailId
                        self.navigationController?.pushViewController(nextVc, animated: true)
                        }
                    } else if data?.registerStatus == RegisterStatus.mobileVerified.rawValue {
                        if let nextVc =  Storyboard.onboard.instantiateViewController(withIdentifier:
                                                                                        Screen.SIGNUPEMAILVERIFYVIEWCONTROLLER) as? SignupEmailVerifyViewController {
                            nextVc.emailID = data?.emailId
                            self.navigationController?.pushViewController(nextVc, animated: true)
                        }
                    } else if data?.registerStatus == RegisterStatus.emailVerified.rawValue {
                        AppUserdefault.firstName = data?.name
                        AppUserdefault.emailId = data?.emailId
                        AppUserdefault.countryCode = data?.countryCode
                        AppUserdefault.mobileNumber = data?.mobileNumber
                        AppUserdefault.accessToken = data?.token
                        if let nextVc =  Storyboard.main.instantiateViewController(withIdentifier:
                                                                                    Screen.TABBARCONTROLLER) as? TabbarViewController{
                            self.navigationController?.pushViewController(nextVc, animated: true)
                        }
                    }
                }
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    
}

extension LoginViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileNumberEmailTextField {
            if Int(mobileNumberEmailTextField.text ?? "") != nil{
                let currentString = textField.text ?? ""
                guard let stringRange = Range(range, in: currentString) else { return false }
                let newString = currentString.replacingCharacters(in: stringRange, with: string)
                return newString.count <= 10
            }
        }
        return true
    }
}
