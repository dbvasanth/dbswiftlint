//
//  LetsTalkTableViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 30/09/22.
//

import UIKit
import DTTextField

class LetsTalkTableViewCell: UITableViewCell {
    @IBOutlet weak var nameTextField: DTTextField!
    @IBOutlet weak var mobileNumberTextField: DTTextField!
    @IBOutlet weak var emailTextField: DTTextField!
    @IBOutlet weak var stateTextField: DTTextField!
    @IBOutlet weak var cityTextField: DTTextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    var sendMessage : (()->())?
    var stateList : [StateModelData]?
    var cityList : [CityModelData]?
    var stateId : ((_ text:String)->())?
    var cityId = ""
    var messageToast : ((_ text:String)->())?
    var city : (()->())?
    var state : (()->())?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    func initialSetup(){
        nameTextField.borderColor = .clear
        mobileNumberTextField.borderColor = .clear
        emailTextField.borderColor = .clear
        stateTextField.borderColor = .clear
        cityTextField.borderColor = .clear
        stateTextField.delegate = self
        cityTextField.delegate = self
        messageTextView.delegate = self
    }
    @IBAction func didChange(_ sender: UITextField) {
        if sender == stateTextField{
            state(text: sender.text ?? "")
            
        }
        if sender == cityTextField{
            city(text: sender.text ?? "")
        }
    }
    
    func state(text: String){
        if text == ""{
            let stateLists = stateList?.map{$0.stateName ?? ""} ?? []
            Constants().setDropDown(text: self.stateTextField.text ?? "", withData: stateLists, anchorView: self.stateTextField) { (text, index) in
                self.stateTextField.text = text
                self.cityTextField.text = ""
                for data in (self.stateList ?? [StateModelData]()).enumerated(){
                    if data.element.stateName == self.stateTextField.text ?? ""{
                        if let textdidchange = self.stateId{
                            textdidchange(self.stateList?[data.offset]._id ?? "")
                        }
                    }
                }
            }
        }else{
            let stateLists = stateList?.map{($0.stateName ?? "").capitalized} ?? []
            let filter = stateLists.filter{$0.contains((text).capitalized)}
            Constants().setDropDown(text: self.stateTextField.text ?? "", withData: filter, anchorView: self.stateTextField) { (text, index) in
                self.stateTextField.text = text
                self.cityTextField.text = ""
                for data in (self.stateList ?? [StateModelData]()).enumerated(){
                    if data.element.stateName == self.stateTextField.text ?? ""{
                        if let textdidchange = self.stateId{
                            textdidchange(self.stateList?[data.offset]._id ?? "")
                        }
                    }
                }
            }
        }
    }
    
    func city(text:String){
        if text == ""{
            let cityLists = cityList?.map{$0.cityName ?? ""} ?? []
            Constants().setDropDown(text: self.cityTextField.text ?? "", withData: cityLists, anchorView: self.cityTextField) { (text, index) in
                self.cityTextField.text = text
                for data in (self.cityList ?? [CityModelData]()).enumerated(){
                    if data.element.cityName == self.cityTextField.text ?? ""{
                        self.cityId = self.cityList?[data.offset]._id ?? ""
                    }
                }
            }
        }else{
            let cityLists = cityList?.map{($0.cityName ?? "").capitalized} ?? []
            let filter = cityLists.filter{$0.contains((text).capitalized)}
            Constants().setDropDown(text: self.cityTextField.text ?? "", withData: filter, anchorView: self.cityTextField) { (text, index) in
                self.cityTextField.text = text
                for data in (self.cityList ?? [CityModelData]()).enumerated(){
                    if data.element.cityName == self.cityTextField.text ?? ""{
                        self.cityId = self.cityList?[data.offset]._id ?? ""
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendMessageTapped(_ sender: UIButton) {
        if validation(){
            if let act = sendMessage{
                act()
            }
        }
    }
    
    func validation() -> Bool {
        var message = ""
        if nameTextField.text?.isEmpty == true{
            message = Message.contactUsName
            nameTextField.showError(message: message)
        }
        if mobileNumberTextField.text?.isEmpty == true{
            message = Message.contactUsPhone
            mobileNumberTextField.showError(message: message)
        }
        if emailTextField.text?.isEmpty == true{
            message = Message.contactUsEmail
            emailTextField.showError(message: message)
        }
        if stateTextField.text?.isEmpty == true{
            message = Message.contactUsState
            stateTextField.showError(message: message)
        }
        if cityTextField.text?.isEmpty == true{
            message = Message.contactUsCity
            cityTextField.showError(message: message)
        }
        if messageTextView.text?.isEmpty == true || messageTextView.text ?? "" == "Enter here"{
            message = Message.contactUsMessage
            if let textdidchange = self.messageToast{
                textdidchange(message)
            }
        }
        if message.isEmpty {
            return true
        }
        return false
    }
    
}

extension LetsTalkTableViewCell: UITextViewDelegate,UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField == stateTextField{
            if let act = state{
                act()
            }
            state(text: stateTextField.text ?? "")
        }else if textField == cityTextField{
            if let act = city{
                act()
            }
            city(text: cityTextField.text ?? "")
        }
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        if messageTextView.text == "Enter here"{
            messageTextView.text = ""
        }
        
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if messageTextView.text == ""{
            messageTextView.text = "Enter here"
        }
    }
}
