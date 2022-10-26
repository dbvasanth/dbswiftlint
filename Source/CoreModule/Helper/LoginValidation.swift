//
//  LoginValidation.swift
//  uGlow
//
//  Created by kongesh on 05/10/21.
//

import Foundation
struct LoginValidation {
    /*
     Validation of Email
     */
    static func isValidEmail(testStr:String) -> Bool { //Validate the email field
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    /*
    Validation of Password
    */
    
    static func isValidupperCase(textStr:String) -> Bool {
        
        let upperRex = ".*[A-Z].*"
        let upperCaseTest = NSPredicate(format: "SELF MATCHES %@", upperRex)
        let upperCaseValidate =  upperCaseTest.evaluate(with: textStr)
        return upperCaseValidate
    }
    
    static func isValidlowerCase(textStr:String) -> Bool {
        
        let lowerCaseRex = ".*[a-z].*"
        let lowerCaseTest = NSPredicate(format: "SELF MATCHES %@", lowerCaseRex)
        let lowerCaseValidate =  lowerCaseTest.evaluate(with: textStr)
        return lowerCaseValidate
    }
    
    static func isValidNumber(textStr:String) -> Bool {
        let numberRex = ".*[0-9].*"
        let numberTest = NSPredicate(format: "SELF MATCHES %@", numberRex)
        let numberValidate =  numberTest.evaluate(with: textStr)
        return numberValidate
    }
    
    static func isVaidSymbol(textStr:String) -> Bool{
        
        let regex = ".*[^A-Za-z0-9].*"
        let symbolTest = NSPredicate(format: "SELF MATCHES %@", regex)
        let symbolValidate =  symbolTest.evaluate(with: textStr)
        return symbolValidate
    }
    
    static func isValidPassword(textStr:String) -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        return passwordValidation.evaluate(with: textStr)
    }
}

