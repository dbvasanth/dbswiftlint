//
//  SideMenuView.swift
//  Manipal
//
//  Created by DB-MBP-008 on 06/10/22.
//

import UIKit

struct SideMenu {
    let title: String?
    let image: UIImage?
}

class SideMenuView: UIView {
    
    @IBOutlet weak var tableViewSideMenu: UITableView!
    @IBOutlet weak var viewProfile: UIView!
    @IBOutlet weak var imgViewProfile: UIImageView!
    @IBOutlet weak var lblProfileName: UILabel!
    @IBOutlet weak var lblProfileID: UILabel!
    
    var arrayMenu = [SideMenu]()
    
    var closerCloseAction: (()->())?
    var closerDidSelectedIndexPath: ((_ index:Int)->())?
    
    // Mark:- Show Auto Dismiss alert
    func showSideMenu(completion:@escaping(_ selectedIndex: Int?)->()) {
        if #available(iOS 13.0, *) {
            for v in Constants.sceneDelegate?.window?.subviews ?? [] {
                if v.tag == 1001 {
                    v.removeFromSuperview()
                }
            }
        } else {
            // Fallback on earlier versions
            for v in Constants.appDelegate?.window?.subviews ?? [] {
                if v.tag == 1001 {
                    v.removeFromSuperview()
                }
            }
        }
        
        let object = Bundle.main.loadNibNamed("SideMenuView", owner: self, options: nil)
        let sidemenu = object![0] as! SideMenuView
        sidemenu.frame = CGRect.init(x: -Constants.screenWidth, y: 0, width: Constants.screenWidth, height: Constants.screenHeight)
        sidemenu.tag = 1001
        sidemenu.createSideMenuList()
        
        sidemenu.lblProfileName.text = (AppUserdefault.firstName == nil || AppUserdefault.firstName?.isEmpty == true)
        ? Constants.guestUser : AppUserdefault.firstName
        sidemenu.lblProfileID.isHidden = (AppUserdefault.accessToken == nil || AppUserdefault.accessToken?.isEmpty == true) ? true : false
        sidemenu.lblProfileID.text = "MANTRU0068468"
        
        sidemenu.tableViewSideMenu.register(UINib(nibName: TableViewCell.SIDEMENUTABLEVIEWCELL, bundle: nil), forCellReuseIdentifier: TableViewCell.SIDEMENUTABLEVIEWCELL)
        sidemenu.tableViewSideMenu.dataSource = sidemenu
        sidemenu.tableViewSideMenu.delegate = sidemenu
        
        sidemenu.viewProfile.clipsToBounds = true
        sidemenu.viewProfile.layer.cornerRadius = 10
        sidemenu.viewProfile.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner] //roundedBottomCorners

//        let leftRecognizer = UISwipeGestureRecognizer(target: sidemenu, action: #selector(swipeMade(_:)))
//        leftRecognizer.direction = .left
//        sidemenu.addGestureRecognizer(leftRecognizer)
        
        DispatchQueue.main.async {
            if #available(iOS 13.0, *) {
                Constants.sceneDelegate?.window?.addSubview(sidemenu)
            }else {
                Constants.appDelegate?.window?.addSubview(sidemenu)
            }
            UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                var rect = sidemenu.frame
                rect.origin.x = 0
                sidemenu.frame = rect
            }, completion: { (finished: Bool) in
                
            })
        }
        
        sidemenu.closerCloseAction = {
            DispatchQueue.main.async {
                UIView.animate(withDuration: 0.2, delay: 0.0, options: [], animations: {
                    var rect = sidemenu.frame
                    rect.origin.x = -Constants.screenWidth
                    sidemenu.frame = rect
                }, completion: { (finished: Bool) in
                    sidemenu.removeFromSuperview()
                    completion(nil)
                })
            }
        }
        
        sidemenu.closerDidSelectedIndexPath = { [weak self] index in
            sidemenu.removeFromSuperview()
            completion(index)
        }
    }
    //--------------------------------------------------------------------------------------------------------------------
    
    func createSideMenuList() {
        arrayMenu.removeAll()
        arrayMenu.append(SideMenu(title: "Home", image: UIImage(named: "SM_Home")))
        arrayMenu.append(SideMenu(title: "Health Packages", image: UIImage(named: "SM_HealthPackages")))
        arrayMenu.append(SideMenu(title: "Book a Test By Conditions", image: UIImage(named: "SM_BookTest")))
        arrayMenu.append(SideMenu(title: "Book a Home Sample Collection", image: UIImage(named: "SM_BookSample")))
        arrayMenu.append(SideMenu(title: "Package Customization", image: UIImage(named: "Sm_PackageCustom")))
        arrayMenu.append(SideMenu(title: "Center Locator", image: UIImage(named: "SM_Locator")))
        arrayMenu.append(SideMenu(title: "Smart Reports", image: UIImage(named: "SM_Reports")))
        arrayMenu.append(SideMenu(title: "Family Members", image: UIImage(named: "SM_FamilyMembers")))
        arrayMenu.append(SideMenu(title: "Enquiry", image: UIImage(named: "SM_Enquiry")))
        arrayMenu.append(SideMenu(title: "About Us", image: UIImage(named: "SM_AboutUs")))
        arrayMenu.append(SideMenu(title: "Gallery", image: UIImage(named: "SM_Gallery")))
        arrayMenu.append(SideMenu(title: "Careers", image: UIImage(named: "SM_Careers")))
        arrayMenu.append(SideMenu(title: "Contact Us", image: UIImage(named: "SM_ContactUs")))
        arrayMenu.append(SideMenu(title: "Terms and Conditions", image: UIImage(named: "SM_Terms")))
        arrayMenu.append(SideMenu(title: "Privacy Policy", image: UIImage(named: "SM_Terms")))
        arrayMenu.append(SideMenu(title: "Logout", image: UIImage(named: "SM_Logout")))
    }
    
//    @objc func swipeMade(_ sender: UISwipeGestureRecognizer) {
//        closerCloseAction?()
//    }
    
    // MARK: - Close side menu button action
    @IBAction func closeAction(_ sender: UIButton) {
        closerCloseAction?()
    }
    
    
    @IBAction func btnProfileTapped(_ sender: UIButton) {
        
    }
    
}
extension SideMenuView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayMenu.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: TableViewCell.SIDEMENUTABLEVIEWCELL) as? SideMenuTableViewCell else {
            return UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.cellConfigureSideMenu(data: arrayMenu[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        closerDidSelectedIndexPath?(indexPath.row)
    }
  
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 53
    }
}
