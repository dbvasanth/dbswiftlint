//
//  PathalogyTestTableViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 03/10/22.
//

import UIKit

class PathalogyTestTableViewCell: UITableViewCell {
    @IBOutlet weak var headerLabelName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var datas = [PackageCalculatorModelDataSubcategory](){
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    func initialSetup(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib.init(nibName: "PathologyTestCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "PathologyTestCollectionViewCell")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension PathalogyTestTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return datas.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas[section].innercategory?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PathologyTestCollectionViewCell", for: indexPath) as! PathologyTestCollectionViewCell
        cell.dataInitialization(data: datas[indexPath.section].innercategory?[indexPath.row] ?? PackageCalculatorModelDataInnercategory())
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let name = datas[indexPath.section].innercategory?[indexPath.row].name ?? ""
        let SizeOfString = name.SizeOfString(font: UIFont(name: "Helvetica Neue Medium", size: 12)!)
        return CGSize(width: SizeOfString.width + 60, height: 44)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        }
    
    
}
