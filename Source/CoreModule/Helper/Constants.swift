//
//  Constants.swift
//  uGlow
//
//  Created by Doodleblue on 30/07/21.
//

import Foundation
import UIKit
import DropDown

class Validation{
    func validateEmail(enteredEmail:String) -> Bool {
        
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
        
    }
    func isValidPassword(password: String) -> Bool {
        let passwordPattern =
            // At least 8 characters
            #"(?=.{8,20})"# +

            // At least one capital letter
            #"(?=.*[A-Z])"# +

            // At least one lowercase letter
            #"(?=.*[a-z])"# +

            // At least one digit
            #"(?=.*\d)"# +

            // At least one special character
            #"(?=.*[!$%^*\/()@#<>\"'&?_{}|:;`~.,-=+])"#

        let result = password.range(
            of: passwordPattern,
            options: .regularExpression
        )
        return (result != nil)
//        let passwordRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[#$^+=!*()@%&]).{8,20}$"
//        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
}

/*
 App constants
 */
let APPName = "Manipal"

struct Constants {
    static let tabBarHeight : CGFloat = 150
    static let screenHeight : CGFloat = UIScreen.main.bounds.height
    static let screenWidth : CGFloat = UIScreen.main.bounds.width
    @available(iOS 13.0, *)
    static let sceneDelegate = UIApplication.shared.connectedScenes.first!.delegate as? SceneDelegate
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    static let window = UIApplication.shared.windows.first(where: { (window) -> Bool in window.isKeyWindow})
    static let appVersion = "Version \(Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "")"
    static let secret = "asdkshEDBUFUN64H$$lkKR"
    static let platformType = "iOS"
    static let guestUser = "Guest User"
    
    let dropdown = DropDown()
    
    
    func setDropDown(text:String,withData:[String],anchorView:UIView,completion:@escaping(_ text:String,_ index:Int)->()){
        var selectIndx = -1
        // The view to which the drop down will appear on
        dropdown.anchorView = anchorView // UIView or UIBarButtonItem
        //  dropdown.transform = AppUserdefault.currentLanguage == "ar" ? CGAffineTransform.init(scaleX: -1, y: 1) : .identity
        dropdown.direction = .bottom
        dropdown.bottomOffset = CGPoint.init(x: -29, y: anchorView.frame.origin.y + anchorView.frame.size.height)
        dropdown.width = anchorView.frame.size.width + 39
        dropdown.dismissMode = .automatic
        dropdown.cellHeight = 60
        dropdown.dataSource = withData
        dropdown.selectionBackgroundColor = UIColor.init(red: 3/255.0, green: 78/255.0, blue: 161/255.0, alpha: 1.0)

        self.dropdown.backgroundColor = .white
        dropdown.selectedTextColor = .white
        for arr in (withData).enumerated(){
            if arr.element == text{
                selectIndx = arr.offset
                debugPrint("Selected Index::",selectIndx)
            }
        }
        dropdown.selectRow(at: selectIndx)
        dropdown.cellNib = UINib(nibName: "DropDownTableViewCell", bundle: nil)

        dropdown.customCellConfiguration = { (index: Index, item: String, cell: DropDownCell) -> Void in
            guard let cell = cell as? DropDownTableViewCell else { return }
            cell.selectionStyle = UITableViewCell.SelectionStyle.blue
            cell.isSelected = true
            cell.isHighlighted = true
            cell.selectedBackgroundView?.backgroundColor = .red
            cell.viewSeperator.backgroundColor  = UIColor.init(red: 205/255.0, green: 204/255.0, blue: 203/355.0, alpha: 1.0)
        }


        dropdown.selectionAction = { (index: Int, item: String) in
            debugPrint("Selected item: \(item) at index: \(index)")
            completion(item,index)
            self.dropdown.hide()
        }
        dropdown.show()
    }
    
    func hideDropDown(){
        dropdown.hide()
        dropdown.show()
    }

}

// Storyboard
struct Storyboard {
    static let main: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
    static let onboard: UIStoryboard = UIStoryboard(name: "Onboarding", bundle: nil)
    static let contactus: UIStoryboard = UIStoryboard(name: "ContactUs", bundle: nil)
    static let webView: UIStoryboard = UIStoryboard(name: "WebView", bundle: nil)
}

// App Fonts
struct Font {
    static let NunitoSansRegular = "NunitoSans-Regular"
    static let OpenSansBoldItalic = "OpenSans-BoldItalic"
    static let OpenSansExtraBold = "OpenSans-ExtraBold"
    static let OpenSansExtraBoldItalic = "OpenSans-ExtraBoldItalic"
    static let OpenSansItalic = "OpenSans-Italic"
    static let OpenSansLight = "OpenSans-Light"
    static let OpenSansLightItalic = "OpenSans-LightItalic"
    static let OpenSansRegular = "OpenSans-Regular"
    static let OpenSansSemiBold = "OpenSans-SemiBold"
    static let OpenSansSemiBoldItalic = "OpenSans-SemiBoldItalic"
    static let PoppinsLight = "Poppins-Light"
    static let PoppinsBold = "Poppins-Bold"
    static let BrownBold = "brown_bold-2"
    
}

// App Colors
struct AppColor {
    static let white = UIColor.white
    static let black = UIColor.black
    static let red = UIColor.red
    static let clear = UIColor.clear
    static let blue = UIColor(red: 3/255.0, green: 78/255.0, blue: 161/255.0, alpha: 1)
    static let light = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25)
    static let unSelectedTextColor = UIColor(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
    static let green = UIColor.init(red: 19/255.0, green: 198/255.0, blue: 184/255.0, alpha: 1.0)
}

struct Screen {
    //Auth
    static let ONBOARDVIEWCONTROLLER = "OnboardViewController"
    static let LOGINVIEWCONTROLLER = "LoginViewController"
    static let SIGNUPVIEWCONTROLLER = "SignUpViewController"
    static let SIGNUPVERIFYVIEWCONTROLLER = "SignUpVerifyViewController"
    static let SIGNUPEMAILVERIFYVIEWCONTROLLER = "SignupEmailVerifyViewController"
    static let FORGOTPASSWORDVIEWCONTROLLER = "ForgotPasswordViewController"
    static let RESETPASSWORDVIEWCONTROLLER = "ResetPasswordViewController"
    static let RESETPASSWORDSUCCESSVIEWCONTROLLER = "ResetPasswordSuccessViewController"
    static let TABBARCONTROLLER = "TabbarViewController"
    static let HOMEVIEWCONTROLLER = "HomeViewController"
    static let WEBVIEWCONTROLLER = "WebViewViewController"
    static let GALLERYVIEWCONTROLLER = "GalleryViewController"
    static let CONTACTUSVIEWCONTROLLER = "ContactUsViewController"
    static let PACKAGECALCULATORVIEWCONTROLLER = "PackageCalculaorViewController"
    static let PACKAGECALCULATORSUMMARYVIEWCONTROLLER = "PackageCalculatorSummaryViewController"
}

struct TableViewCell{
    static let UPCOMINGBOOKINGSTABLEVIEWCELL = "UpcomingBookingsTableViewCell"
    static let HOMEBANNERTABLEVIEWCELL = "HomeBannerTableViewCell"
    static let HEALTHPACKAGETABLEVIEWCELL = "HealthPackageTableViewCell"
    static let TESTCONDITIONTABLEVIEWCELL = "TestConditionTableViewCell"
    static let TRUTESTTABLEVIEWCELL = "TRUtestTableViewCell"
    static let TESTIMONIALSTABLEVIEWCELL = "TestimonialsTableViewCell"
    static let HOMETABLEVIEWHEADERVIEW = "HomeTableViewHeaderView"
    static let SIDEMENUTABLEVIEWCELL = "SideMenuTableViewCell"
}

struct CollectionViewCell{
    static let ONBOARDCELL  = "OnBoardCollectionViewCell"
    static let GALLERYCATEGORYCELL = "GalleryCategoriesCollectionViewCell"
    static let GALLERYIMAGESCELL = "GalleryImagesCollectionViewCell"
}

enum RegisterStatus : Int {
    case basicInfo = 1
    case mobileVerified = 2
    case emailVerified = 3
}

enum WebViewType : String {
    case aboutUs = "About Us"
    case termsConditions = "Terms and Conditions"
    case privacy = "Privacy Policy"
}

struct Message {
    static let internetError = "Please check your internet connection!"
    static let unKnownError = "Something went wrong"
    static let noData = "No data found"
    //Login
    static let emailAndMobileIsEmpty = "Please enter Mobile Number / Email Address"
    static let emailIsEmpty = "Please enter email"
    static let correctEmailId = "Please enter a valid email address"
    static let mobile = "Please enter a valid mobile number"
    static let password = "Please enter password"
    static let confirmPassword = "Please enter confirm password"
    static let passwordDoNotMatch = "Passwords do not match, please try again"
    static let otp = "Please enter otp"

    static let invalidPassword = "New Password shall be minimum of 5 characters minimum with at least: one small letter, one capital letter, one special character, and 1 number"
    static let startDate = "Please select start date"
    static let endDate = "Please select end date"

    //Register
    static let name = "Please enter name"
    static let dob = "Please select dob"
    static let emptyPhone = "Please enter mobile number"
    static let validPhoneNumber = "Please enter valid mobile number"
    static let password5Characters = "Password must be at least 5 characters (combination of lowercase, uppercase, digits & symbols)"
    
    static let date = "Please select date"
    static let validDate = "Please select valid date"
    static let time = "Please select time"
    static let times = "Select valid time"
    static let validTime = "Please select valid time"


    //Otp
    static let otpIsEmpty = "Please enter otp"
    static let invalidOtp = "Please enter valid otp"
    
    
    static let cardName = "Please enter card holder name"
    static let validAccNo = "Please enter IBAN"
    static let expiryDate = "Please enter expiry date as this format MM/YYYY"
    static let cvv = "Please enter valid cvv"
    
    
    //Manual address
    static let addressEmpty = "Please enter address"
    static let address1Empty = "Please enter address1"
    static let address2Empty = "Please enter address2"
    static let pincodeEmpty = "Please enter postcode"

    static let noGalleryImage = "No image in the gallery"
    static let completeProfile = "Please complete your profile"
    
    static let contactUsMessage = "Message is required"
    static let contactUsName = "Name is required"
    static let contactUsPhone = "Phone number is required"
    static let contactUsEmail = "Email is required"
    static let contactUsState = "State is required"
    static let contactUsCity = "City is required"
    
    
}

struct AlertTitle {
    static let CameraPermission = "Camera Not found"
    static let PhotoGalleryAccessPermission = "\(APPName) does not have access to your photo gallery. please tap on Setting and allow photo gallery access permission."
    static let CameraAccessPermission = "\(APPName) does not have access to your device camera. please tap on Setting and allow camera access permission."
    static let NeedCameraPermission = "Need Camera Permission"
    static let NeedPhotoPermission = "Need Photo Permission"
    static let NeedLocationPermission = "Need Location Permission"
    static let NeedCalendarPermission = "Need Calendar Permission"
    static let CalendarAccessPermission = "\(APPName) does not have access to your Calendar. please tap on Setting and allow calendar access permission."
    static let LocationAccessPermission = "\(APPName) does not have access to your Location. please tap on Setting and allow location access permission."
    static let NeedMailConfiguration = "Please add email account in your device"
}

