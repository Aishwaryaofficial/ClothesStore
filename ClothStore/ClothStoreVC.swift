//
//  ClothStoreVC.swift
//  ClothStore
//
//  Created by Appinventiv on 13/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ClothStoreVC: UIViewController {

    @IBOutlet weak var clothesCollectionView: UICollectionView!
       var onOffSwitch: Bool = true
   
    // MARK: DATA SOURCE
    
    @IBOutlet weak var listGridToggle: UIButton!
   
    
    let data: [[String:String]] = [
        ["name": "TOP","value": "image10" ],
        ["name": "JEANS","value": "image10"],
        ["name": "SWEETER","value": "image10"],
        ["name": "TOP","value": "image10"],
        ["name": "JEANS","value": "image10"],
        ["name": "SWEETER","value": "image10"],
        ["name": "TOP","value": "image10"],
        ["name": "JEANS","value": "image10"],
        ["name": "SWEETER","value":"image10" ]
    ]
    
// app life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        clothesCollectionView.dataSource = self
        clothesCollectionView.delegate = self
        
        let gridNib = UINib(nibName: "ListToGrid", bundle: nil)
        clothesCollectionView.register(gridNib, forCellWithReuseIdentifier: "listToGridId")
        
        let listNib = UINib(nibName: "GridToList", bundle: nil)
        clothesCollectionView.register(listNib, forCellWithReuseIdentifier: "gridToListId")
        
        // mark: flow layout 
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: 170, height: 200)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumLineSpacing = 20
        flowLayout.scrollDirection = .vertical
        
        clothesCollectionView.collectionViewLayout = flowLayout



        // Do any additional setup after loading the view.
    }
    
// button listGridOnClick
  
    @IBAction func listGridOnClick(_ sender: UIButton) {
        
//        listGridToggle.isSelected = !listGridToggle.isSelected
        
        if listGridToggle.isSelected {
            
            listGridToggle.isSelected = false
            onOffSwitch = true
        }
        else {
            
            listGridToggle.isSelected = true
            onOffSwitch = false
        }
        clothesCollectionView.reloadData()
    }
    
}

// MARK EXTENSION

extension ClothStoreVC: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if onOffSwitch
        {

        guard let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridToListId", for: indexPath) as? GridToList else { fatalError("Cell Not Found !") }
                    let Data = Model(withJSON: data[indexPath.item])
                    listCell.populateWithData(Data)
                    return listCell
        }
        else {
            guard let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "listToGridId", for: indexPath) as? ListToGrid else { fatalError("Cell Not Found !") }
                    let Data = Model(withJSON: data[indexPath.item])
                    gridCell.populateWithData(Data)
                    return gridCell
        }
    
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return  data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if onOffSwitch {
            return CGSize(width: 170, height: 180)

        }
        else
        {
            return CGSize(width: 375, height: 150)
        }
    }
    
    
}

// MARK: CLOTHES MODEL
class Model{
    
    var image : UIImage!
    var name : String!
    
    init(withJSON data : [String:String]) {
        
      self.image = UIImage(named: data["value"]!)
        self.name = data["name"]
    }
}
