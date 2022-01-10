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


    var yardsBox = RoundedBox()

    /// The box that is smaller.
    /// - SuperView: notesBoxContainer, View
    var notesBox = RoundedBox()
    var myViewController: UIViewController?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = myGreen
        yardageBoxContainer.layer.cornerRadius = globalCornerRadius
        clubNameBox.layer.cornerRadius = globalCornerRadius
        notesBoxContainer.layer.cornerRadius = globalCornerRadius
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
        yardsBox.setupFrames(padFromSides: 0, nestedIn: yardageBoxContainer)
        yardsBox.layoutViews()

        notesBox.setMainText("Some Notes Go Here")
        notesBoxContainer.addSubview(notesBox.mainContainer)
        notesBox.setupFrames(padFromSides: 0, nestedIn: notesBoxContainer)
        notesBox.layoutViews()

        let notesTransparentButton = TransparentButton(superView: notesBoxContainer)
        let yardageTransparentButton = TransparentButton(superView: yardageBoxContainer)
        notesTransparentButton.addTarget(self, action: #selector(didTapNotes), for: .touchUpInside)
        yardageTransparentButton.addTarget(self, action: #selector(didTapSwing), for: .touchUpInside)
    }

    @objc func didTapSwing() {
        print("Swing was tapped")
    }

    @objc func didTapNotes() {
        print("Notes Was Tapped")
        super.showAnimation {
        }
        let notesVC = myViewController?.storyboard?.instantiateViewController(withIdentifier: "allNotesViewController") as! AllNotesViewController

        notesVC.comingFrom = "club"

        myViewController?.navigationController?.pushViewController(notesVC, animated: true)
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
