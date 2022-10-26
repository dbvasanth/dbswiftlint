//
//  ResetPasswordViewController.swift
//  Manipal
//
//  Created by DB-MM-034 on 21/09/22.
//

import UIKit
import DTTextField
import CryptoKit

class ResetPasswordViewController: UIViewController {
    
    @IBOutlet weak var txtFieldNewPassword: DTTextField!
    @IBOutlet weak var txtFieldConfirmPassword: DTTextField!
    
    let cryptLib = CryptLib()
    let viewModel = ResetPasswordViewModel()
    var resetPasswordRequestModel = ResetPasswordRequestModel()
    var emailID : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialSetup()
    }
    
    func initialSetup() {
        txtFieldNewPassword.borderColor = .clear
        txtFieldConfirmPassword.borderColor = .clear
    }

    @IBAction func btnBackTapped(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            Constants.sceneDelegate?.navigationToScreen(identifier: Screen.FORGOTPASSWORDVIEWCONTROLLER, storyboard: Storyboard.main)
        } else {
            // Fallback on earlier versions
            Constants.appDelegate?.navigationToScreen(identifier: Screen.FORGOTPASSWORDVIEWCONTROLLER, storyboard: Storyboard.main)
        }
    }
    
    @IBAction func btnResetTapped(_ sender: UIButton) {
        validate()
    }
    
    func validate() {
        let pwd = txtFieldNewPassword.text ?? ""
        let confirmPwd = txtFieldConfirmPassword.text ?? ""
        
        var message = ""
        if pwd.isEmpty == true {
            message = Message.password
            txtFieldNewPassword.showError(message: message)
        }
        else if !LoginValidation.isValidupperCase(textStr: pwd) || !LoginValidation.isValidlowerCase(textStr: pwd) || !LoginValidation.isValidNumber(textStr: pwd) || !LoginValidation.isVaidSymbol(textStr: pwd) || pwd.count < 5{
            message = Message.password5Characters
            self.showToast(message: message)
        }
        
        if confirmPwd.isEmpty == true {
            message = Message.confirmPassword
            txtFieldConfirmPassword.showError(message: message)
        }
        
        if pwd.isEmpty == false && confirmPwd.isEmpty == false {
            if pwd != confirmPwd{
                message = Message.passwordDoNotMatch
                self.showToast(message: message)
            }
        }

        if message.isEmpty {
            resetPasswordAPICall()
        }
    }
    
    func resetPasswordAPICall() {
        resetPasswordRequestModel.emailId = emailID
        let key =  Constants.secret
        guard let pwd = cryptLib.encryptPlainTextRandomIV(withPlainText: txtFieldNewPassword.text ?? "", key: key) else { return  }
        resetPasswordRequestModel.password = pwd
        guard let confirmPwd = cryptLib.encryptPlainTextRandomIV(withPlainText: txtFieldConfirmPassword.text ?? "", key: key) else { return  }
        resetPasswordRequestModel.confirmPassword = confirmPwd
        viewModel.apicallForResetPassword(resetPasswordRequestModel) { (status, data) in
            if status == .Success{
                self.showToast(message: self.viewModel.successMessage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if let NextVc =  Storyboard.main.instantiateViewController(withIdentifier: Screen.RESETPASSWORDSUCCESSVIEWCONTROLLER) as? ResetPasswordSuccessViewController {
                        self.navigationController?.pushViewController(NextVc, animated: true)
                    }
                }
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
}
