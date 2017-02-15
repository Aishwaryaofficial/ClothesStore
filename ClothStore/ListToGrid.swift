//
//  ListToGrid.swift
//  ClothStore
//
//  Created by Appinventiv on 14/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ListToGrid: UICollectionViewCell {
    
    // MARK: @IBOutlet
    
    @IBOutlet weak var gridLabel: UILabel!
    @IBOutlet weak var gridImageView: UIImageView!
    
    // MARK: CELL LIFE CYCLE

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        gridLabel.text = ""
        gridImageView.image = nil
        
    }

    // MARK: @PRIVATE FUNCTION
    
    func populateWithData(_ data: Model)
    {
        gridLabel.text = data.name
        gridImageView.image = data.image
    }

   
}
