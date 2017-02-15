//
//  ProductGridFlowLayout.swift
//  carCollectionView
//
//  Created by Appinventiv on 14/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import Foundation
import UIKit

class ProductsGridFlowLayout: UICollectionViewFlowLayout {
    
    // here you can define the height of each cell
    let itemHeight: CGFloat = 150
    
    override init() {
        super.init()
        setupLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupLayout()
    }
    
    /**si
     Sets up the layout for the collectionView. 1pt distance between each cell and 1pt distance between each row plus use a vertical layout
     */
    func setupLayout() {
        minimumInteritemSpacing = 1
        minimumLineSpacing = 1
        scrollDirection = .vertical
    }
    
    /// here we define the width of each cell, creating a 2 column layout. In case you would create 3 columns, change the number 2 to 3
    func itemWidth() -> CGFloat {
        return (collectionView!.frame.width/2)-1
    }
    
    override var itemSize: CGSize {
        set {
          self.itemSize = CGSize(width: itemWidth() , height: itemHeight )        }
        get {
            return CGSize(width: itemWidth() , height: itemHeight )        }
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint) -> CGPoint {
        return collectionView!.contentOffset
    }
    
    
}