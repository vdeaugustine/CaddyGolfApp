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
            font = UIFont(name: "Helvetica-Bold", size: 80)
            adjustsFontSizeToFitWidth = true
            text = labelText
            textAlignment = .center
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    class RectTitle: UILabel {
        init(_ titleText: String) {
            super.init(frame: CGRect())
            font = UIFont(name: "Helvetica-Bold", size: 34)
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
            var mainArr = currentClub.allPreviousSwings.components(separatedBy: ",")
            print(mainArr.count)

            if mainArr[mainArr.count - 1] == "" {
                mainArr.remove(at: mainArr.count - 1)
            }

            return mainArr.count
        } else if collectionView == notesCollectionView {
            let mainArr = getAllClubNotes(currentClubTypeAsEnum())
            return mainArr.count > 0 ? mainArr.count : 1
        } else {
            return 0
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var myCell = UICollectionViewCell()

        if collectionView == swingsCollectionView {
            myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SwingCell", for: indexPath)

            let aSwingView = RoundedBox()
            let arrOfPrevHits = currentClub.allPreviousSwings.components(separatedBy: ",").reversed() as [String]
            print("arr of all swings", arrOfPrevHits)
            let thisSwing = arrOfPrevHits[indexPath.row]
            myCell.addSubview(aSwingView.mainContainer)
            aSwingView.setupFrames(with: CGRect(x: 0,
                                                y: 0,
                                                width: myCell.width,
                                                height: myCell.height))
            aSwingView.layoutViews()
            aSwingView.setHeaderText("Full Swing")
            aSwingView.setMainText(thisSwing)
            aSwingView.headerLabel.font = UIFont(name: "Helvetica-Bold", size: 45)
            aSwingView.headerLabel.adjustsFontSizeToFitWidth = true

        } else if collectionView == notesCollectionView {
            let allTheseNotes = getAllClubNotes(currentClubTypeAsEnum())
            myCell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotesCell", for: indexPath)
            let aNoteView = RoundedBox()
            myCell.addSubview(aNoteView.mainContainer)
            aNoteView.setupFrames(with: CGRect(x: 0,
                                               y: 0,
                                               width: myCell.width,
                                               height: myCell.height))
            aNoteView.layoutViews()
            aNoteView.headerLabel.font = UIFont(name: "Helvetica-Bold", size: 45)
            aNoteView.headerLabel.adjustsFontSizeToFitWidth = true

            if allTheseNotes.count <= 0 {
                aNoteView.setHeaderText("No notes for this club yet")
                aNoteView.setMainText("Tap to add notes")
                return myCell
            }
            let thisClubNote = allTheseNotes[indexPath.row]
            
            aNoteView.setHeaderText(thisClubNote.title ?? "")
            aNoteView.setMainText(thisClubNote.subTitle ?? "")
            
            return myCell
            
        }

        return myCell
    }
}
