//
//  PackageCalculaorViewController.swift
//  Manipal
//
//  Created by DB-MM-034 on 30/09/22.
//

import UIKit

class PackageCalculaorViewController: UIViewController {
    @IBOutlet weak var packageTableView: UITableView!
    @IBOutlet weak var searchView: UIView!
    @IBOutlet weak var searchTextField: UITextField!
    
    var viewModel = PackageCalculatorViewModel()
    var packageCalculator : PackageCalculatorModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    func initialSetup(){
        searchView.layer.applySketchShadow(color: .white, alpha: 0.15, x: 0, y: 4, blur: 15, spread: 0)
        packageTableView.register(UINib.init(nibName: "PathalogyTestTableViewCell", bundle: nil), forCellReuseIdentifier: "PathalogyTestTableViewCell")
        packageTableView.register(UINib.init(nibName: "RadiologyTableViewCell", bundle: nil), forCellReuseIdentifier: "RadiologyTableViewCell")
        packageTableView.register(UINib.init(nibName: "PackageRequiredTableViewCell", bundle: nil), forCellReuseIdentifier: "PackageRequiredTableViewCell")
        packageTableView.delegate = self
        packageTableView.dataSource = self
        packageCalculatorApiCall()
    }
    
    func packageCalculatorApiCall(){
        viewModel.apicallForCalculatePackage { status, data in
            if status == .Success{
                self.packageCalculator = data
                self.packageTableView.reloadData()
            } else {
                self.showToast(message: self.viewModel.errMessage)
            }
        }
    }
    
    @IBAction func backTapped(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    

}

extension PackageCalculaorViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.packageCalculator?.data?.count ?? 0 + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row{
        case 0...(self.packageCalculator?.data?.count ?? 0):
            let cell = tableView.dequeueReusableCell(withIdentifier: "PathalogyTestTableViewCell", for: indexPath) as! PathalogyTestTableViewCell
            cell.headerLabelName.text = self.packageCalculator?.data?[indexPath.row].name ?? ""
            
            cell.datas = packageCalculator?.data?[indexPath.row].subcategory ?? [PackageCalculatorModelDataSubcategory]()
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PackageRequiredTableViewCell", for: indexPath) as! PackageRequiredTableViewCell
            cell.nextAction = {

            }
            return cell
        }
    }
    
    
}
