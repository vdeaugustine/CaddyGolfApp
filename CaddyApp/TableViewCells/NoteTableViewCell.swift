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
    var pageToGoToIfTapped: UIViewController?
    var navigationController: UINavigationController!
    var letButtonBeTapped = false

    override func awakeFromNib() {
        super.awakeFromNib()
        noteContentPreview.dropShadow()
        noteContentPreview.isUserInteractionEnabled = true
        let noteContextGesture = UIGestureRecognizer(target: self, action: #selector(goToPage))
        noteContentPreview.addGestureRecognizer(noteContextGesture)
        if letButtonBeTapped {
            let goToPageButton = TransparentButton(superView: noteContentPreview)
            goToPageButton.addTarget(self, action: #selector(goToPage), for: .touchUpInside)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    @objc func goToPage() {
        print("label was tapped")

        guard let pageToGo = pageToGoToIfTapped else {
            return
        }

        navigationController.pushViewController(pageToGo, animated: true)
    }
}
