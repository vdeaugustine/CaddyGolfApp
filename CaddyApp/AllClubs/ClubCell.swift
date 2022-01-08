//
//  ClubCell.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/6/21.
//

import UIKit

class ClubCell: UITableViewCell {
    @IBOutlet var notesBoxContainer: UIView!
    @IBOutlet var clubNameBox: UIView!
    @IBOutlet var yardageBoxContainer: UIView!
    @IBOutlet var clubNameLabel: UILabel!
    @IBOutlet var notesButton: UIButton!

    @IBAction func testButtonTouched(_ sender: UIButton) {
        print("Touched button")
    }

    var yardsBox = RoundedBox()
    var notesBox = RoundedBox()
    var myViewController: UIViewController?
//    var yardagesRect:  UIView {
//        let theView = UIView()
//        theView.layer.cornerRadius = 8
//        return theView
//    }

    override func awakeFromNib() {
        super.awakeFromNib()

        yardageBoxContainer.layer.cornerRadius = 8
        clubNameBox.layer.cornerRadius = 8
        notesBoxContainer.layer.cornerRadius = 8
        clubNameLabel.adjustsFontSizeToFitWidth = true

        let pad: CGFloat = 10

        clubNameBox.frame = CGRect(x: pad,
                                   y: pad,
                                   width: 150,
                                   height: super.height - pad * 2)
        clubNameLabel.frame = CGRect(x: -2, y: 0, width: clubNameBox.width, height: clubNameBox.height)

        let startNotesBoxAt = clubNameBox.right + pad

        let screenWidth = UIScreen.main.bounds.width
        let finishYardBoxAt = screenWidth - pad
        let spaceToWorkWith = CGRect(x: startNotesBoxAt, y: pad, width: abs(finishYardBoxAt - startNotesBoxAt), height: super.height - pad * 2)

        yardsBox.setMainText("Yardage")
        yardageBoxContainer.frame = CGRect(x: spaceToWorkWith.minX,
                                           y: spaceToWorkWith.minY,
                                           width: (spaceToWorkWith.width - pad) / 2,
                                           height: spaceToWorkWith.height)
        notesBoxContainer.frame = CGRect(x: yardageBoxContainer.right + pad,
                                         y: spaceToWorkWith.minY,
                                         width: yardageBoxContainer.width,
                                         height: spaceToWorkWith.height)

        yardageBoxContainer.addSubview(yardsBox.mainContainer)
        yardsBox.setupFrames(with: yardageBoxContainer.frame)
        yardsBox.layoutViews()

        notesBox.setMainText("Some Notes Go Here")
        notesBoxContainer.addSubview(notesBox.mainContainer)
        notesBox.setupFrames(with: notesBoxContainer.frame)
        notesBox.layoutViews()
//        notesBoxContainer.isUserInteractionEnabled = true
//        let gesture = UIGestureRecognizer(target: self, action: #selector(didTapNotes))
//        notesBoxContainer.addGestureRecognizer(gesture)

//        yardageBox.frame = CGRect(x: <#T##Double#>, y: <#T##Double#>, width: <#T##Double#>, height: <#T##Double#>)

//        notesBox.addSubview(yardagesRect)
//        yardagesRect.frame = CGRect(x: self.yardageBox.left + 5,
//                                    y: self.yardageBox.top + 5,
//                                    width: self.yardageBox.width - 10,
//                                    height: self.yardageBox.height - 10)
//        yardagesRect.frame = CGRect(x: 0,
//                                    y: 0,
//                                    width: 10,
//                                    height: 10)
//        yardagesRect.backgroundColor = .blue

//        notesBox.addSubview(yardsBox.mainContainer)
//        notesBox.backgroundColor = .darkGray
//        let superFrame = notesBox.frame
//        yardsBox.setupFrames(with: superFrame)
//        var someBox = UIView(frame: superFrame)
//        someBox.backgroundColor = .orange
//        notesBox.addSubview(someBox)
//        yardsBox.setupFrames(padFromSides: 0, nestedIn: yardageBox)

        notesButton.frame = CGRect(x: 0, y: 0, width: notesBoxContainer.width, height: notesBoxContainer.height)
        notesBox.mainContainer.isUserInteractionEnabled = true
//        let gesture = UIGestureRecognizer(target: , action: #selector(didTapNotes))
//        notesBox.mainContainer.addGestureRecognizer(gesture)
//        self.notesBox.mainContainer.backgroundColor = .systemPink
    }

    @objc func didTapNotes() {
        print("Notes Was Tapped")
//        super.showAnimation {
//        }
//        let notesVC = myViewController?.storyboard?.instantiateViewController(withIdentifier: "allNotesViewController") as! AllNotesViewController
//
//        notesVC.comingFrom = "club"
//
//        myViewController?.navigationController?.pushViewController(notesVC, animated: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @IBAction func notesTapped() {
        print("Notes tapped")
//        let notesVC = myViewController?.storyboard?.instantiateViewController(withIdentifier: "allNotesViewController") as! AllNotesViewController
//
//        notesVC.comingFrom = "club"
//
//        myViewController?.navigationController?.pushViewController(notesVC, animated: true)
    }
}