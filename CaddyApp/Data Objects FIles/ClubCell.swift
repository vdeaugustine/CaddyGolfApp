//
//  ClubCell.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/6/21.
//

import UIKit

class ClubCell: UITableViewCell {
    @IBOutlet var yardsLabel: UILabel!
    @IBOutlet weak var notesBox: UIView!
    @IBOutlet weak var clubNameBox: UIView!
    @IBOutlet weak var yardageBox: UIView!
    @IBOutlet weak var clubNameLabel: UILabel!
    var yardsBox = RoundedBox()
    var yardagesRect:  UIView {
        let theView = UIView()
        theView.layer.cornerRadius = 8
        return theView
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        yardageBox.layer.cornerRadius = 8
        clubNameBox.layer.cornerRadius = 8
        notesBox.layer.cornerRadius = 8
        clubNameLabel.adjustsFontSizeToFitWidth = true
        
        let pad: CGFloat = 10
        
        clubNameBox.frame = CGRect(x: pad,
                                   y: pad,
                                   width: 150,
                                   height: super.height - pad*2)
        clubNameLabel.frame = CGRect(x: -2, y: 0, width: clubNameBox.width, height: clubNameBox.height)
        

        let startNotesBoxAt = clubNameBox.right + pad
        
        let screenWidth = UIScreen.main.bounds.width
        let finishYardBoxAt = screenWidth - pad
        let spaceToWorkWith = CGRect(x: startNotesBoxAt, y: pad, width: abs(finishYardBoxAt - startNotesBoxAt), height: super.height - pad * 2)
        
        yardsBox.setMainText("Yardage")
        yardageBox.frame = CGRect(x: spaceToWorkWith.minX,
                                  y: spaceToWorkWith.minY,
                                  width: (spaceToWorkWith.width - pad) / 2,
                                  height: spaceToWorkWith.height)
        notesBox.frame = CGRect(x: yardageBox.right + pad,
                                  y: spaceToWorkWith.minY,
                                width: yardageBox.width,
                                  height: spaceToWorkWith.height)
        
        yardageBox.addSubview(yardsBox.mainContainer)
        yardsBox.setupFrames(with: yardageBox.frame)
        yardsBox.layoutViews()
        
        
        
        
        
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
        
        
    }
    
   
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
