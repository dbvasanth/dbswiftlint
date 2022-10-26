//
//  HomeViewController.swift
//  Manipal
//
//  Created by DB-MM-034 on 22/09/22.
//

import UIKit

class HomeViewController: BaseViewController {
    
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var homeTableView: UITableView!
    
    var viewModel = HomeViewModel()
    var bannerList : HomeBannerModel?
    var packageList : HomePackageList?
    var conditionList : HomeConditiosList?
    var testimonialList : HomeTestimonialList?
    var sideMenuView = SideMenuView()
    
    var TRUTestHeader = ["Assurance of quality","One stop solution","Latest technologies","Data integrity"]
    var TRUTestDescription = ["Lorem ipsum dolor sit amet consec","All kinds of routine pathology tests","Lorem ipsum dolor sit amet consec","Lorem ipsum dolor sit amet consec"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
    }
    func initialize(){
        searchView.layer.applySketchShadow(color: .white, alpha: 0.15, x: 0, y: 4, blur: 15, spread: 0)
        homeTableView.register(UINib.init(nibName: TableViewCell.UPCOMINGBOOKINGSTABLEVIEWCELL, bundle: nil), forCellReuseIdentifier: TableViewCell.UPCOMINGBOOKINGSTABLEVIEWCELL)
        homeTableView.register(UINib.init(nibName: TableViewCell.HOMEBANNERTABLEVIEWCELL, bundle: nil), forCellReuseIdentifier: TableViewCell.HOMEBANNERTABLEVIEWCELL)
        homeTableView.register(UINib.init(nibName: TableViewCell.HEALTHPACKAGETABLEVIEWCELL, bundle: nil), forCellReuseIdentifier: TableViewCell.HEALTHPACKAGETABLEVIEWCELL)
        homeTableView.register(UINib.init(nibName: TableViewCell.TESTCONDITIONTABLEVIEWCELL, bundle: nil), forCellReuseIdentifier: TableViewCell.TESTCONDITIONTABLEVIEWCELL)
        homeTableView.register(UINib.init(nibName: TableViewCell.TRUTESTTABLEVIEWCELL, bundle: nil), forCellReuseIdentifier: TableViewCell.TRUTESTTABLEVIEWCELL)
        homeTableView.register(UINib.init(nibName: TableViewCell.TESTIMONIALSTABLEVIEWCELL, bundle: nil), forCellReuseIdentifier: TableViewCell.TESTIMONIALSTABLEVIEWCELL)
        homeTableView.register(UINib.init(nibName: TableViewCell.HOMETABLEVIEWHEADERVIEW, bundle: nil), forHeaderFooterViewReuseIdentifier: TableViewCell.HOMETABLEVIEWHEADERVIEW)
        homeTableView.delegate = self
        homeTableView.dataSource = self
        homeTableView.backgroundColor = .clear
        homePageApiCall()
    }
    func homePageApiCall(){
        viewModel.apicallForBannerList("?city=gurugram&pincode=122001&latitude=12.223434&longitude=35.465&state=delhi-ncr") { status, data in
            if status == .Success{
                self.bannerList = data
                self.homeTableView.reloadData()
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }

        viewModel.apicallForPackageList("?pincode=122001&city=gurugram&state=delhi-ncr&latitude=12.223434&longitude=35.465") { status, data in
            if status == .Success{
                self.packageList = data
                self.homeTableView.reloadData()
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
       
        viewModel.apicallForConditionList("?pincode=122001&city=gurugram&state=delhi-ncr&latitude=12.223434&longitude=35.465") { status, data in
            if status == .Success{
                self.conditionList = data
                self.homeTableView.reloadData()
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
       
        viewModel.apicallForTestimonialList("?page=1&limit=10") { status, data in
            if status == .Success{
                self.testimonialList = data
                debugPrint("dsdsds",self.testimonialList?.data?.list?.count ?? 0)
                self.homeTableView.reloadData()
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
        
    }
    
    @IBAction func sideMenuAction(_ sender: UIButton) {
        SideMenuView().showSideMenu() { (selectedIndex) in
            guard let data = selectedIndex else {
                return
            }
            self.sideMenuNavigation(index: data)
        }
    }
    @IBAction func shoppingCartAction(_ sender: UIButton) {
        if let NextVc =  Storyboard.contactus.instantiateViewController(withIdentifier: Screen.PACKAGECALCULATORVIEWCONTROLLER) as? PackageCalculaorViewController{
            self.navigationController?.pushViewController(NextVc, animated: true)
        }
    }
    @IBAction func notificationAction(_ sender: UIButton) {
        if let NextVc =  Storyboard.contactus.instantiateViewController(withIdentifier: Screen.CONTACTUSVIEWCONTROLLER) as? ContactUsViewController{
            self.navigationController?.pushViewController(NextVc, animated: true)
        }
    }
    

}

extension HomeViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 4 ? 4 : 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.section == 0 ? 0 : UITableView.automaticDimension
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        switch section{
        case 0,1:
            return 0.1
        default:
            return 40
        }
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section{
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.UPCOMINGBOOKINGSTABLEVIEWCELL, for: indexPath) as! UpcomingBookingsTableViewCell
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.HOMEBANNERTABLEVIEWCELL, for: indexPath) as! HomeBannerTableViewCell
            cell.datas = bannerList ?? HomeBannerModel()
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.HEALTHPACKAGETABLEVIEWCELL, for: indexPath) as! HealthPackageTableViewCell
            cell.datas = packageList ?? HomePackageList()
            return cell
        case 3:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.TESTCONDITIONTABLEVIEWCELL, for: indexPath) as! TestConditionTableViewCell
            cell.datas = conditionList ?? HomeConditiosList()
            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.TRUTESTTABLEVIEWCELL, for: indexPath) as! TRUtestTableViewCell
            cell.titleLabel.text = TRUTestHeader[indexPath.row]
            cell.descriptionLabel.text = TRUTestDescription[indexPath.row]
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.TESTIMONIALSTABLEVIEWCELL, for: indexPath) as! TestimonialsTableViewCell
            cell.datas = testimonialList ?? HomeTestimonialList()
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerview = tableView.dequeueReusableHeaderFooterView(withIdentifier: TableViewCell.HOMETABLEVIEWHEADERVIEW) as! HomeTableViewHeaderView
        switch section{
        case 0:
            headerview.labelHeader.text = "Upcoming Bookings"
            headerview.labelHeader.isHidden = true
            headerview.viewAllButton.isHidden = true
        case 1:
            headerview.labelHeader.isHidden = true
            headerview.viewAllButton.isHidden = true
        case 2:
            headerview.labelHeader.text = "Health Packages"
            headerview.labelHeader.isHidden = false
            headerview.viewAllButton.isHidden = false
        case 3:
            headerview.labelHeader.text = "Book a Test by Conditions"
            headerview.labelHeader.isHidden = false
            headerview.viewAllButton.isHidden = false
        case 4:
            headerview.labelHeader.text = "Features of Manipal TRUtest"
            headerview.viewAllButton.isHidden = true
            headerview.labelHeader.isHidden = false
        case 5:
            headerview.labelHeader.text = "Testimonials"
            headerview.labelHeader.isHidden = false
        default:
            break
        }
        return headerview
    }
}
