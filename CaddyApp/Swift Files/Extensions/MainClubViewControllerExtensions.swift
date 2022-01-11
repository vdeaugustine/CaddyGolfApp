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
            font = UIFont(name: "Helvetica-Bold", size: 18)
            adjustsFontSizeToFitWidth = true
            text = labelText
            textAlignment = .center
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
            font = UIFont(name: "Helvetica-BoldOblique", size: 80)
            adjustsFontSizeToFitWidth = true
            text = labelText
            //    label.heightAnchor.constraint(equalToConstant: 49.0)
            //        label.translatesAutoresizingMaskIntoConstraints = true
            textAlignment = .center
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
            font = UIFont(name: "Helvetica-BoldOblique", size: 34)
            text = titleText
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    class SwingTypeContainer: UIView {
        init() {
            super.init(frame: CGRect())
            translatesAutoresizingMaskIntoConstraints = true
            layer.cornerRadius = globalCornerRadius
            backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
            isUserInteractionEnabled = true
            frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        }

        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
}

extension MainClubViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == swingsCollectionView {
            let mainArr = currentClub.allPreviousSwings.components(separatedBy: ",")
            print(mainArr.count)
            return mainArr.count
        } else if collectionView == notesCollectionView {
            let mainArr = getAllClubNotes(currentClubTypeAsEnum())
            return mainArr.count
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var myCell = UICollectionViewCell()

        if collectionView == swingsCollectionView {
            myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwingCell", for: indexPath)
            myCell.dropShadow()
            let aSwingView = SwingTypeContainer()
            aSwingView.frame = CGRect(x: 0, y: 0, width: myCell.width, height: myCell.height)

            let x = UILabel(frame: CGRect())
            x.text = "\(indexPath.row)"
            aSwingView.addSubview(x)
            x.frame = CGRect(x: aSwingView.width / 2, y: aSwingView.height / 2, width: 20, height: 20)

            myCell.addSubview(aSwingView)

        } else if collectionView == notesCollectionView {
            let thisClubNote = getAllClubNotes(currentClubTypeAsEnum())[indexPath.row]
            myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotesCell", for: indexPath)
            myCell.dropShadow()
            let aNoteView = RoundedBox()
//            aSwingView.frame = CGRect(x: 0, y: 0, width: myCell.width, height: myCell.height)
            myCell.addSubview(aNoteView.mainContainer)
            aNoteView.setupFrames(with:  CGRect(x: 0,
                                                y: 0,
                                                width: myCell.width,
                                                height: myCell.height))
            aNoteView.layoutViews()
            aNoteView.setHeaderText(thisClubNote.title ?? "")
            aNoteView.setMainText(thisClubNote.subTitle ?? "")
            aNoteView.headerLabel.adjustsFontSizeToFitWidth = false
        }

        return myCell
    }

//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 150
//    }
}
