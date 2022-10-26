//
//  ContactUsViewController.swift
//  Manipal
//
//  Created by DB-MM-034 on 30/09/22.
//

import UIKit

class ContactUsViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel = ContactUsViewModel()
    var contactRequestModel = ContactRequestModel()
    var contactList : ContactUsModel?
    var stateList : [StateModelData]?
    var cityList : [CityModelData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup(){
        tableView.register(UINib.init(nibName: "ContactUsSupportTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactUsSupportTableViewCell")
        tableView.register(UINib.init(nibName: "LetsTalkTableViewCell", bundle: nil), forCellReuseIdentifier: "LetsTalkTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        getContactListApiCall()
        getStateListApiCall()
    }
    
    func getContactListApiCall(){
        viewModel.apicallForGetContactList() { status, data in
            if status == .Success{
                self.contactList = data
                self.tableView.reloadData()
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    func getStateListApiCall(){
        viewModel.apicallForGetStateList() { status, data in
            if status == .Success{
                self.stateList = data?.data
                self.tableView.reloadData()
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    func getCityListApiCall(id: String){
        viewModel.apicallForGetCityList(id) { status, data in
            if status == .Success{
                self.cityList = data?.data
                self.tableView.reloadData()
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
}

extension ContactUsViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0,1,2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ContactUsSupportTableViewCell", for: indexPath) as! ContactUsSupportTableViewCell
            cell.dataInitialization(indexPath: indexPath, data: self.contactList?.data ?? ContactUsModelData())
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "LetsTalkTableViewCell", for: indexPath) as! LetsTalkTableViewCell
            cell.stateList = stateList
            cell.cityList = cityList
            cell.sendMessage = {
                self.contactRequestModel.name = cell.nameTextField.text ?? ""
                self.contactRequestModel.phoneNumber = cell.mobileNumberTextField.text ?? ""
                self.contactRequestModel.email = cell.emailTextField.text ?? ""
                self.contactRequestModel.message = cell.messageTextView.text ?? ""
                self.contactRequestModel.cityId = cell.cityId
                self.viewModel.apicallForAddContactList(self.contactRequestModel) { status, data in
                    if status == .Success{
                        self.showToast(message: self.viewModel.successErrorMessage)
                        DispatchQueue.main.asyncAfter(deadline: .now()+2.0) {
                            self.navigationController?.popViewController(animated: true)
                        }
                    } else {
                        self.showToast(message: self.viewModel.errMessage)
                    }
                }
            }
            cell.stateId = { text in
                self.contactRequestModel.stateId = text
                self.getCityListApiCall(id: text)
            }
            cell.messageToast = { text in
                self.showToast(message: text)
            }
            cell.state = {
                self.tableView.setContentOffset(.init(x: 0, y: 1060), animated: false)
            }
            cell.city = {
                self.tableView.setContentOffset(.init(x: 0, y: 1150), animated: false)
            }
            
            return cell
        }
    }
    
    
}
