//
//  CollectionVIewTestViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/2/22.
//

import UIKit

class CollectionVIewTestViewController: UIViewController {

    var myCollectionView:UICollectionView?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let view = UIView()
            view.backgroundColor = .white
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            let height : CGFloat = 50
            
            layout.sectionInset = UIEdgeInsets(top: self.view.height / 2 - height , left: 25, bottom: self.view.height / 2 - height, right: 25)
            layout.itemSize = CGSize(width: height, height: height)
            
            myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
            myCollectionView?.backgroundColor = UIColor.green
            
            myCollectionView?.dataSource = self
            myCollectionView?.delegate = self
            layout.scrollDirection = .horizontal
     
            view.addSubview(myCollectionView ?? UICollectionView())
            
            self.view = view
        }
    }
    extension CollectionVIewTestViewController: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            return 500 // How many cells to display
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath)
            myCell.backgroundColor = UIColor.blue
            return myCell
        }
    }
    extension CollectionVIewTestViewController: UICollectionViewDelegate {
     
        func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           print("User tapped on item \(indexPath.row)")
        }

}

