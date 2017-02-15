//
//  GridToList.swift
//  ClothStore
//
//  Created by Appinventiv on 14/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class GridToList: UICollectionViewCell {
    
    // MARK: @IBOutlet

    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var listImageView: UIImageView!
    
    // MARK: CELL LIFE CYCLE
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        listLabel.text = ""
        listImageView.image = nil
    }
    
    // MARK: @PRIVATE FUNCTION
    
    func populateWithData(_ data: Model)
    {
        listLabel.text = data.name
        listImageView.image = data.image
    }


}
