//
//  HeaderTableViewCell.swift
//  ILA-UIKIT
//
//  Created by Neosoft on 04/08/24.
//

import UIKit

protocol HeaderTableViewCellDelegate : AnyObject {
    func updateSelectedCategory(_ selectedCategory: String?)
}

class HeaderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var carousalView: UIView!
    @IBOutlet weak var carousalCollectionView: UICollectionView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var arrCategories: [String] = []
    var arrItems: [ItemList] = []
    var cellDelgate:HeaderTableViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //Carousal Collection View
        self.carousalCollectionView.delegate = self
        self.carousalCollectionView.dataSource = self
        self.carousalCollectionView.isPagingEnabled = true
        self.carousalCollectionView.register(UINib(nibName: UIConstants.carousalCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: UIConstants.carousalCollectionViewCell)
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: width, height: 200)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        self.carousalCollectionView.collectionViewLayout = layout
        self.carousalCollectionView.reloadData()
        self.pageControl.currentPage = 0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    func configureCarousalCollectionView(_ viewModel: ViewControllerViewModel) {
        self.arrItems = viewModel.items
        self.arrCategories = viewModel.typeOFItems
        self.pageControl.numberOfPages = self.arrCategories.count
        self.carousalCollectionView.reloadData()
    }
}

// MARK:- UICollectionViewDataSource
extension HeaderTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: UIConstants.carousalCollectionViewCell, for: indexPath) as! CollectionViewCell
        let category = self.arrCategories[indexPath.item]
        if let data = self.arrItems.first(where: { $0.item == category }) {
            cell.imgView.image = UIImage(named: data.image)
        }
        cell.imgView.contentMode = .scaleToFill
        return cell
    }
}

// MARK:- UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
extension HeaderTableViewCell : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width), height: 200)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

// MARK:- Scrollview handle
extension HeaderTableViewCell {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let _ = scrollView as? UICollectionView {
            let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
            self.pageControl.currentPage = page
            self.cellDelgate?.updateSelectedCategory(self.arrCategories[page])
        }
    }
}

