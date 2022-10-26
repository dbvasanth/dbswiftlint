//
//  SignUpVerifyViewController.swift
//  Manipal
//
//  Created by DB-MM-034 on 26/09/22.
//

import UIKit
import DTTextField

class SignUpVerifyViewController: UIViewController {
    
    @IBOutlet weak var mobileOTP: DTTextField!
    @IBOutlet weak var lblResend: UILabel!
    @IBOutlet weak var btnResend: UIButton!
    @IBOutlet weak var lblResendTimer: UILabel!
    
    let viewModel = SignupViewModel()
    var mobileVerifyRequestModel = MobileVeifyRequestModel()
    var resendMobileOTPRequestModel = ResendMobileOTPRequestModel()
    var forgotPasswordViewModel = ForgotPasswordViewModel()
    var forgotPasswordMobileVeifyRequestModel = ForgotPasswordMobileVeifyRequestModel()
    var mobileNum : String?
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
    
    func initialSetup() {
        mobileOTP.borderColor = .clear
        mobileOTP.delegate = self
        lblResendTimer.isHidden = true
    }
    
    @IBAction func btnSkipTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnMobileResendTapped(_ sender: UIButton) {
        resendMobileOTPAPICall()
    }
    
    @IBAction func verifyTapped(_ sender: UIButton) {
        if mobileOTP.text?.isEmpty == true || mobileOTP.text?.count ?? 0 < 6{
            mobileOTP.showError(message: Message.otp)
        }else{
            if forgotPasswordFlow {
                forgotPasswordMobileOTPAPICall()
            }else {
                sendOTPApicall()
            }
        }
    }
    
    func sendOTPApicall() {
        mobileVerifyRequestModel.mobileNumber = mobileNum
        mobileVerifyRequestModel.mobileOTP = mobileOTP.text?.filter { !$0.isWhitespace }
        viewModel.apicallForMobileVerifyOTP(mobileVerifyRequestModel) { (status, data) in
            if status == .Success{
                self.showToast(message: self.viewModel.successMessage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if let NextVc =  Storyboard.onboard.instantiateViewController(withIdentifier: Screen.SIGNUPEMAILVERIFYVIEWCONTROLLER) as? SignupEmailVerifyViewController {
                        NextVc.forgotPasswordFlow = self.forgotPasswordFlow
                        NextVc.emailID = self.emailID
                        self.navigationController?.pushViewController(NextVc, animated: true)
                    }
                }
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    
    func forgotPasswordMobileOTPAPICall() {
        forgotPasswordMobileVeifyRequestModel.mobileNumber = mobileNum
        forgotPasswordMobileVeifyRequestModel.mobileOTP = mobileOTP.text?.filter { !$0.isWhitespace }
        forgotPasswordViewModel.apicallForForgotPasswordMobileVerify(forgotPasswordMobileVeifyRequestModel) { (status, data) in
            if status == .Success{
                self.showToast(message: self.forgotPasswordViewModel.successMessage)
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    if let NextVc =  Storyboard.onboard.instantiateViewController(withIdentifier: Screen.SIGNUPEMAILVERIFYVIEWCONTROLLER) as? SignupEmailVerifyViewController {
                        NextVc.forgotPasswordFlow = self.forgotPasswordFlow
                        NextVc.emailID = self.emailID
                        self.navigationController?.pushViewController(NextVc, animated: true)
                    }
                }
            } else {
                self.showToast(message: self.forgotPasswordViewModel.errMessage)
            }
        }
    }
    
    func resendMobileOTPAPICall() {
        resendMobileOTPRequestModel.mobileNumber = mobileNum
        viewModel.apicallForResendMobileOTP(resendMobileOTPRequestModel) { (status, data) in
            if status == .Success{
                self.showToast(message: self.viewModel.successMessage)
                self.initTimer()
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    
}

extension SignUpVerifyViewController: CountdownDelegate {
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



extension SignUpVerifyViewController : UITextFieldDelegate{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == mobileOTP {
            let currentString = textField.text ?? ""
            guard let stringRange = Range(range, in: currentString) else { return false }
            let newString = currentString.replacingCharacters(in: stringRange, with: string)
            textField.text = format(with: "XXX XXX", phone: newString)
            return false
        }
        return true
    }
}
