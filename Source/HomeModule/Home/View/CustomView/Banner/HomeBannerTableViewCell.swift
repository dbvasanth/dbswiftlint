//
//  HomeBannerTableViewCell.swift
//  Manipal
//
//  Created by DB-MM-034 on 23/09/22.
//

import UIKit

class HomeBannerTableViewCell: UITableViewCell,UIScrollViewDelegate {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    var currentIndex = 0
    var datas = HomeBannerModel(){
        didSet {
            pageControl.numberOfPages = datas.data?.count ?? 0
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
        collectionView.register(UINib.init(nibName: "HomeBannerCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "HomeBannerCollectionViewCell")
        pageControl.currentPage = 0
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension HomeBannerTableViewCell: UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return datas.data?.count ?? 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeBannerCollectionViewCell", for: indexPath) as! HomeBannerCollectionViewCell
        cell.initialization(data: datas.data? [indexPath.row] ?? HomeBannerModelData())
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            return CGSize(width: collectionView.bounds.width, height: collectionView.frame.size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
       
       func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
           return 0
       }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let visibleRect = CGRect(origin: self.collectionView.contentOffset, size: self.collectionView.bounds.size)
           let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
           if let visibleIndexPath = self.collectionView.indexPathForItem(at: visiblePoint) {
               self.pageControl.currentPage = visibleIndexPath.row
           }
    }
    
    
}
