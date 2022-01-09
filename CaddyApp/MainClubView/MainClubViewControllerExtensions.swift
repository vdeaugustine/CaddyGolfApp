//
//  MainClubViewControllerExtensions.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/2/22.
//

import Foundation
import UIKit

class LargeRect: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = true
        layer.cornerRadius = globalCornerRadius
        backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
        isUserInteractionEnabled = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MainClubViewController {
    class customView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            translatesAutoresizingMaskIntoConstraints = true
            layer.cornerRadius = globalCornerRadius
            isUserInteractionEnabled = false
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    

    class Header: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            translatesAutoresizingMaskIntoConstraints = true
            layer.cornerRadius = globalCornerRadius
            //    view.backgroundColor = .red
            backgroundColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 255 / 255)
            isUserInteractionEnabled = true
            layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class HeaderLabel: UILabel {
        
        init(_ labelText: String) {
            super.init(frame: CGRect())
            self.font = UIFont(name: "Helvetica-Bold", size: 18)
            self.adjustsFontSizeToFitWidth = true
            self.text = labelText
            self.textAlignment = .center
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class NumberLabel: UILabel {
        
        init(_ labelText: String) {
            super.init(frame: CGRect())
            self.font = UIFont(name: "Helvetica-BoldOblique", size: 80)
            self.adjustsFontSizeToFitWidth = true
            self.text = labelText
            //    label.heightAnchor.constraint(equalToConstant: 49.0)
            //        label.translatesAutoresizingMaskIntoConstraints = true
            self.textAlignment = .center
            //        label.translatesAutoresizingMaskIntoConstraints = false
        }
        
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//
//        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class RectTitle: UILabel {
        
        
        init(_ titleText: String) {
            super.init(frame: CGRect())
            self.font = UIFont(name: "Helvetica-BoldOblique", size: 34)
            self.text = titleText
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class SwingTypeContainer: UIView {
        init() {
            super.init(frame: CGRect())
            self.translatesAutoresizingMaskIntoConstraints = true
            self.layer.cornerRadius = globalCornerRadius
            self.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
            self.isUserInteractionEnabled = true
            self.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
    
}

extension MainClubViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var arrOfPrevHits: [String]
        arrOfPrevHits = currentClub.allPreviousSwings.components(separatedBy: ",")
        print(arrOfPrevHits.count)
        return arrOfPrevHits.count
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwingCell", for: indexPath)
        myCell.dropShadow()
        let aSwingView = SwingTypeContainer()
        aSwingView.frame = CGRect(x: 0, y: 0, width: myCell.width, height: myCell.height)
        
        
        
        let x = UILabel(frame: CGRect())
        x.text = "\(indexPath.row)"
        aSwingView.addSubview(x)
        x.frame = CGRect(x: aSwingView.width / 2, y: aSwingView.height / 2, width: 20, height: 20)
        
        myCell.addSubview(aSwingView)
        
        return myCell
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 150
//    }
    
    
    
    
}
