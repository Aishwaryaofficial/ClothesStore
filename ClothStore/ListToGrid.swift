//
//  ListToGrid.swift
//  ClothStore
//
//  Created by Appinventiv on 14/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ListToGrid: UICollectionViewCell {
    @IBOutlet weak var gridLabel: UILabel!
    @IBOutlet weak var gridImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func populateWithData(_ data: Model)
    {
        gridLabel.text = data.name
        gridImageView.image = data.image
    }

    override func prepareForReuse() {
       super.prepareForReuse()
        gridLabel.text = ""
        gridImageView.image = nil
        
    }

}
