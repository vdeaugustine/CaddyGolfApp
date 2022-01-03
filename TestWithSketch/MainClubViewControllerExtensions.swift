//
//  MainClubViewControllerExtensions.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/2/22.
//

import Foundation
import UIKit

extension MainClubViewController {
    class customView: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            translatesAutoresizingMaskIntoConstraints = true
            layer.cornerRadius = 8
            backgroundColor = .red
            isUserInteractionEnabled = false
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    class LargeRect: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            translatesAutoresizingMaskIntoConstraints = true
            layer.cornerRadius = 8
            //    view.backgroundColor = .red
            backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
            isUserInteractionEnabled = true
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    class Header: UIView {
        override init(frame: CGRect) {
            super.init(frame: frame)
            translatesAutoresizingMaskIntoConstraints = true
            layer.cornerRadius = 8
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
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.font = UIFont(name: "Helvetica-Bold", size: 18)
            self.adjustsFontSizeToFitWidth = true
            self.text = "3/4 Swing"
            //    label.heightAnchor.constraint(equalToConstant: 49.0)
            //        label.translatesAutoresizingMaskIntoConstraints = true
            self.textAlignment = .center
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class NumberLabel: UILabel {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.font = UIFont(name: "Helvetica-BoldOblique", size: 80)
            self.adjustsFontSizeToFitWidth = true
            self.text = "\(currentClub.threeFourthsDistance)"
            //    label.heightAnchor.constraint(equalToConstant: 49.0)
            //        label.translatesAutoresizingMaskIntoConstraints = true
            self.textAlignment = .center
            //        label.translatesAutoresizingMaskIntoConstraints = false
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class RectTitle: UILabel {
        
//        init(_ titleText: String) {
//            super.init()
//            self.font = UIFont(name: "Helvetica-BoldOblique", size: 34)
//            self.text = titleText
//        }
        
        init(_ titleText: String) {
            super.init(frame: CGRect())
            self.font = UIFont(name: "Helvetica-BoldOblique", size: 34)
            self.text = titleText
        }
//        override init(frame: CGRect) {
//            super.init(frame: frame)
//            self.font = UIFont(name: "Helvetica-BoldOblique", size: 34)
//        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
    class SwingTypeContainer: UIView {
        init() {
            super.init(frame: CGRect())
            self.translatesAutoresizingMaskIntoConstraints = true
            self.layer.cornerRadius = 8
    //            view.backgroundColor = .red
            self.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
            self.isUserInteractionEnabled = true
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
    }
    
}
