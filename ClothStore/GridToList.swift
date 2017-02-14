//
//  GridToList.swift
//  ClothStore
//
//  Created by Appinventiv on 14/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class GridToList: UICollectionViewCell {

    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var listImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func populateWithData(_ data: Model)
    {
        listLabel.text = data.name
        listImageView.image = data.image
    }


}
