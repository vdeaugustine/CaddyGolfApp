//
//  NoteTableViewCell.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/6/22.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    @IBOutlet var noteTitle: UILabel!
    @IBOutlet var noteContentPreview: UITextView!
    var pageToGoToIfTapped: UIViewController!
    var navigationController: UINavigationController!

    override func awakeFromNib() {
        super.awakeFromNib()
        noteContentPreview.dropShadow()
        noteContentPreview.isUserInteractionEnabled = true
        let noteContextGesture = UIGestureRecognizer(target: self, action: #selector(goToPage))
        noteContentPreview.addGestureRecognizer(noteContextGesture)
//        let goToPageButton: TransparentButton = {
//            let button = TransparentButton(superView: self.noteContentPreview)
//            button.translatesAutoresizingMaskIntoConstraints = false
//            button.addTarget(self, action: #selector(goToPage), for: .touchUpInside)
//            button.backgroundColor = .red
//            return button
//        }()
        let goToPageButton = TransparentButton(superView: noteContentPreview)
        goToPageButton.addTarget(self, action: #selector(goToPage), for: .touchUpInside)
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    @objc func goToPage() {
        print("label was tapped")
        
        navigationController.pushViewController(pageToGoToIfTapped, animated: true)
    }
}
