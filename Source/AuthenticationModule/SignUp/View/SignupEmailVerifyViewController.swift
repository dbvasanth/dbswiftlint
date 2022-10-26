//
//  SignupEmailVerifyViewController.swift
//  Manipal
//
//  Created by DB-MM-034 on 28/09/22.
//

import UIKit
import DTTextField

class SignupEmailVerifyViewController: UIViewController {
    
    @IBOutlet weak var emailOTPTextField: DTTextField!
    @IBOutlet weak var lblResend: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblResendTimer: UILabel!
    
    let viewModel = SignupViewModel()
    var emailVeifyRequestModel = EmailVeifyRequestModel()
    var resendEmailOTPRequestModel = ResendEmailOTPRequestModel()
    var forgotPasswordViewModel = ForgotPasswordViewModel()
    var forgotPasswordEmailVeifyRequestModel = ForgotPasswordEmailVeifyRequestModel()
    var emailID : String?
    var forgotPasswordFlow : Bool = false
    private var countdown = Countdown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        countdown.reset()
    }
    
    func initialSetup(){
        emailOTPTextField.borderColor = .clear
        emailOTPTextField.delegate = self
        lblResendTimer.isHidden = true
    }
    
    @IBAction func skipTapped(_ sender: UIButton) {
        if forgotPasswordFlow {
            if #available(iOS 13.0, *) {
                Constants.sceneDelegate?.navigationToScreen(identifier: Screen.FORGOTPASSWORDVIEWCONTROLLER, storyboard: Storyboard.main)
            } else {
                // Fallback on earlier versions
                Constants.appDelegate?.navigationToScreen(identifier: Screen.FORGOTPASSWORDVIEWCONTROLLER, storyboard: Storyboard.main)
            }
        }else {
            if #available(iOS 13.0, *) {
                Constants.sceneDelegate?.navigationToScreen(identifier: Screen.LOGINVIEWCONTROLLER, storyboard: Storyboard.main)
            } else {
                // Fallback on earlier versions
                Constants.appDelegate?.navigationToScreen(identifier: Screen.LOGINVIEWCONTROLLER, storyboard: Storyboard.main)
            }
        }
    }
    
    @IBAction func resendTapped(_ sender: UIButton) {
        resendEmailOTPAPICall()
    }
    
    @IBAction func verifyTapped(_ sender: UIButton) {
        if emailOTPTextField.text?.isEmpty == true || emailOTPTextField.text?.count ?? 0 < 6{
            emailOTPTextField.showError(message: Message.otp)
        }else{
            if forgotPasswordFlow {
                forgotPasswordEmailOTPAPICall()
            }else {
                sendOTPApicall()
            }
        }
    }
    
    func sendOTPApicall(){
        emailVeifyRequestModel.emailId = emailID
        emailVeifyRequestModel.emailOTP = emailOTPTextField.text?.filter { !$0.isWhitespace }
        viewModel.apicallForEmailVerifyOTP(emailVeifyRequestModel) { (status, data) in
            if status == .Success{
                self.showToast(message: self.viewModel.successMessage)
                AppUserdefault.firstName = data?.name
                AppUserdefault.emailId = data?.emailId
                AppUserdefault.countryCode = data?.countryCode
                AppUserdefault.mobileNumber = data?.mobileNumber
                AppUserdefault.accessToken = data?.token
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if let NextVc =  Storyboard.main.instantiateViewController(withIdentifier: Screen.TABBARCONTROLLER) as? TabbarViewController {
                        self.navigationController?.pushViewController(NextVc, animated: true)
                    }
                }
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    
    func forgotPasswordEmailOTPAPICall() {
        forgotPasswordEmailVeifyRequestModel.emailId = emailID
        forgotPasswordEmailVeifyRequestModel.emailOTP = emailOTPTextField.text?.filter { !$0.isWhitespace }
        forgotPasswordViewModel.apicallForForgotPasswordEmailVerify(forgotPasswordEmailVeifyRequestModel) { (status, data) in
            if status == .Success{
                self.showToast(message: self.forgotPasswordViewModel.successMessage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if let NextVc =  Storyboard.main.instantiateViewController(withIdentifier: Screen.RESETPASSWORDVIEWCONTROLLER) as? ResetPasswordViewController {
                        NextVc.emailID = self.emailID
                        self.navigationController?.pushViewController(NextVc, animated: true)
                    }
                }
            } else {
                self.showToast(message: self.forgotPasswordViewModel.errMessage)
            }
        }
    }
    
    func resendEmailOTPAPICall() {
        resendEmailOTPRequestModel.emailId = emailID
        viewModel.apicallForResendEmailOTP(resendEmailOTPRequestModel) { (status, data) in
            if status == .Success{
                self.showToast(message: self.viewModel.successMessage)
                self.initTimer()
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
}

extension SignupEmailVerifyViewController: CountdownDelegate {
    func countdownDidFinish() {
        lblResendTimer.isHidden = true
        lblResend.isHidden = false
        btnResend.isHidden = false
        updateViews()
    }
    
    func countdownDidUpdate(timeRemaining: TimeInterval) {
        lblResendTimer.isHidden = false
        updateViews()
    }
    
    func initTimer(){
        lblResendTimer.isHidden = false
        lblResend.isHidden = true
        btnResend.isHidden = true
        countdown.delegate = self
        countdown.duration = timerDuration
        countdown.start()
        updateViews()
    }
    private func updateViews() {
        DispatchQueue.main.async {
            switch self.countdown.state {
            case .started:
                self.lblResendTimer.text =  "Resend OTP in \(self.showSeconds(from: self.countdown.timeRemaining))s"
            case .finished:
                self.lblResendTimer.text = self.showSeconds(from: 0)
            case .reset:
                self.lblResendTimer.text = "Resend OTP in \(self.showSeconds(from: self.countdown.duration))s"
            }
        }
    }

    private func showSeconds(from duration: TimeInterval) -> String {
        let date = Date(timeIntervalSinceReferenceDate: duration)
        return date.secondsFormatter
    }
}

extension SignupEmailVerifyViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == emailOTPTextField {
            let currentString = textField.text ?? ""
            guard let stringRange = Range(range, in: currentString) else { return false }
            let newString = currentString.replacingCharacters(in: stringRange, with: string)
            textField.text = format(with: "XXX XXX", phone: newString)
            return false
        }
        return true
    }
}
