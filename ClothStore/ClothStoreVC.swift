//
//  ClothStoreVC.swift
//  ClothStore
//
//  Created by Appinventiv on 13/02/17.
//  Copyright © 2017 Appinventiv. All rights reserved.
//

import UIKit

class ClothStoreVC: UIViewController {
    
    
    // MARK: @IBOutlet
    
    @IBOutlet weak var clothesCollectionView: UICollectionView!
    @IBOutlet weak var onDeleteOutlet: UIButton!
    @IBOutlet weak var listGridToggle: UIButton!
    @IBOutlet weak var gridListToggle: UIButton!
    
    // variables
    
    var onOffSwitch = Switch.list

    // makeing instence of ProductListFlowLayout , ProductGridFlowLayout
    
    let listFlowlayout = ProductsListFlowLayout()
    let gridFlowlayout = ProductsGridFlowLayout()
    
    //  DATA SOURCE
    
    var data: [[String:String]] = [
        ["name": "TOP","value": "images1" ],
        ["name": "JEANS","value": "image2"],
        ["name": "SWEETER","value": "images3"],
        ["name": "TOP","value": "images1"],
        ["name": "JEANS","value": "image2"],
        ["name": "SWEETER","value": "images3"],
        ["name": "TOP","value": "images1"],
        ["name": "JEANS","value": "image2"],
        ["name": "TOP","value": "images1" ],
        ["name": "JEANS","value": "image2"],
        ["name": "SWEETER","value": "images3"],
        ["name": "TOP","value": "images1"],
        ["name": "JEANS","value": "image2"],
        ["name": "SWEETER","value": "images3"],
        ["name": "TOP","value": "images1"],
        ["name": "JEANS","value": "image2"],
        ["name": "SWEETER","value":"images3" ]
    ]
    
    var dataSelected: [IndexPath] = []
    
    // MARK:  VIEW LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clothesCollectionView.allowsSelection = false
        
        onDeleteOutlet.isHidden = true
        
        clothesCollectionView.dataSource = self
        clothesCollectionView.delegate = self
        
        self.automaticallyAdjustsScrollViewInsets =  false
        
        let gridNib = UINib(nibName: "ListToGrid", bundle: nil)
        clothesCollectionView.register(gridNib, forCellWithReuseIdentifier: "listToGridId")
        
        let listNib = UINib(nibName: "GridToList", bundle: nil)
        clothesCollectionView.register(listNib, forCellWithReuseIdentifier: "gridToListId")
        
        // mark: long press gesture
        
        let lpgrSence = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
        lpgrSence.minimumPressDuration = 0.5
        lpgrSence.delaysTouchesBegan = true
        //lpgrSence.delegate = self
        self.clothesCollectionView.addGestureRecognizer(lpgrSence)
        
        // mark: flow layout
        
//        let flowLayout = UICollectionViewFlowLayout()
//        flowLayout.itemSize = CGSize(width: 170, height: 200)
//        flowLayout.minimumInteritemSpacing = 2
//        flowLayout.minimumLineSpacing = 20
//        flowLayout.scrollDirection = .vertical
//        clothesCollectionView.collectionViewLayout = flowLayout

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.clothesCollectionView.collectionViewLayout.invalidateLayout()
        self.clothesCollectionView.setCollectionViewLayout(self.gridFlowlayout, animated: true)
    }
    
    // MARK:  @IBAction
    
   @IBAction func listGridOnClick(_ sender: UIButton) {
        // button list button On Click
        if onOffSwitch == .list{
            clothesCollectionView.reloadData()
            onOffSwitch = .grid
            UIView.animate(withDuration: 1, animations: {() -> Void in
                self.clothesCollectionView.collectionViewLayout.invalidateLayout()
                self.clothesCollectionView.setCollectionViewLayout(self.listFlowlayout, animated: true)
                self.listGridToggle.isEnabled = false
                }, completion: { (true) in
                    self.gridListToggle.isEnabled = true
                })
            }
        }
   
    @IBAction func gridListOnClick(_ sender: UIButton) {
          // Grid button On Click
     if onOffSwitch == .grid {
        clothesCollectionView.reloadData()
        onOffSwitch = .list
        UIView.animate(withDuration: 1, animations: {() -> Void in
                self.clothesCollectionView.collectionViewLayout.invalidateLayout()
                self.clothesCollectionView.setCollectionViewLayout(self.gridFlowlayout, animated: true)
                self.gridListToggle.isEnabled = false
                }, completion: { (true) in
                    self.listGridToggle.isEnabled = true
                })
            }
        }
    //  delete button Action
    
    @IBAction func onButton(_ sender: UIButton) {
        for index in dataSelected.sorted().reversed() {
            data.remove(at: dataSelected.index(of: index)!)
            clothesCollectionView.deleteItems(at: [index])
        }
        dataSelected.removeAll()
        onDeleteOutlet.isHidden = true
    }
    
    //MARK: PRIVATE FUNCTIONS

    func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        onDeleteOutlet.isHidden = false
        onDeleteOutlet.isEnabled = true
        clothesCollectionView.allowsMultipleSelection = true
        
        if gesture.state == .ended {
            return
        }
        let point = gesture.location(in: self.clothesCollectionView)
        if let indexPath = self.clothesCollectionView.indexPathForItem(at: point) {
            clothesCollectionView.selectItem(at: indexPath, animated: true, scrollPosition: .bottom)
            collectionView(clothesCollectionView, didSelectItemAt: indexPath)
        }
        else {
            print("couldn't find index path")
        }
    }
}

// MARK: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension ClothStoreVC: UICollectionViewDataSource, UICollectionViewDelegate , UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if onOffSwitch == .grid
        {
            guard let listCell = collectionView.dequeueReusableCell(withReuseIdentifier: "listToGridId", for: indexPath) as? ListToGrid else { fatalError("Cell Not Found !") }
            listCell.backgroundColor = .black
            let Data = Model(withJSON: data[indexPath.item])
            listCell.populateWithData(Data)
            return listCell
        }
        else{
                guard let gridCell = collectionView.dequeueReusableCell(withReuseIdentifier: "gridToListId", for: indexPath) as? GridToList else { fatalError("Cell Not Found !") }
                gridCell.backgroundColor = .black
                let Data = Model(withJSON: data[indexPath.item])
                gridCell.populateWithData(Data)
                return gridCell
            }

        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = clothesCollectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.red
        dataSelected.append(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = clothesCollectionView.cellForItem(at: indexPath)
        cell?.backgroundColor = UIColor.black
        dataSelected.remove(at: dataSelected.index(of: indexPath)!)
        if dataSelected.isEmpty{
            onDeleteOutlet.isHidden = true
        }
    }

}// END OF EXTENTION

// MARK:  MODEL CLASS

class Model{
    
    var image : UIImage!
    var name : String!
    
    init(withJSON data : [String:String]) {
        
      self.image = UIImage(named: data["value"]!)
        self.name = data["name"]
    }
}

// MARK: ENUM 

enum Switch{
    case  list,grid
}
