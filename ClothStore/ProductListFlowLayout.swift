//
//  ProductListFlowLayout.swift
//  carCollectionView
//
//  Created by Appinventiv on 14/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import UIKit

class ProductsListFlowLayout: UICollectionViewFlowLayout {
    
    let itemHeight: CGFloat = 180
    
    override init() {
        super.init()
        setupLayout()
    }
    
        required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
   
    
    func setupLayout() {
        minimumInteritemSpacing = 0
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    func itemWidth() -> CGFloat {
            return collectionView!.frame.width
        }
    
    override var itemSize: CGSize {
        set {
                self.itemSize = CGSize(width: itemWidth() , height: itemHeight )
            }
        get {
                return CGSize(width: itemWidth(), height:  itemHeight)
            }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
}
