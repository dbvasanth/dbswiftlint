//
//  TestimonialsTableViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 26/09/22.
//

import UIKit

class TestimonialsTableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: UICollectionView!
    var datas = HomeTestimonialList(){
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
        collectionView.register(UINib.init(nibName: "TestiMonialsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "TestiMonialsCollectionViewCell")
    }
    
}

extension TestimonialsTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.data?.list?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TestiMonialsCollectionViewCell", for: indexPath) as! TestiMonialsCollectionViewCell
        cell.initialization(data: datas.data?.list?[indexPath.row] ?? HomeTestimonialListDataList())
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.bounds.width - 10) / 1.25
        return CGSize(width: width, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        }
}
