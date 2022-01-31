//
//  ViewSingleNoteViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/10/22.
//

import UIKit

class ViewSingleNoteViewController: UIViewController {
    @IBOutlet var mainNoteTextView: UITextView!
    @IBOutlet var titleLabel: UITextField!

    @IBOutlet var mainNoteBottomConstraint: NSLayoutConstraint!

    var isInEditState = false

    var titleText: String?
    var noteText: String?
    var thisClubNote: ClubNote?
    var thisMainNote: MainNote?
    var typeOfNote: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Note"

        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditNote))
        mainNoteTextView.isUserInteractionEnabled = isInEditState
        titleLabel.isUserInteractionEnabled = isInEditState
        if let titleText = titleText {
            titleLabel.text = titleText
        }
        if let noteText = noteText {
            mainNoteTextView.text = noteText
        }
    }

    @objc func didTapEditNote() {
        guard !(thisMainNote == nil && thisClubNote == nil) else {
            return
        }
        print("tapped edit note")

        isInEditState = !isInEditState
        // Editing is enabled
        if isInEditState {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                target: self,
                                                                action: #selector(didTapEditNote))

            titleLabel.isUserInteractionEnabled = isInEditState
            mainNoteTextView.isUserInteractionEnabled = isInEditState

        } else {
            // Editing is not enabled at the moment
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                                target: self,
                                                                action: #selector(didTapEditNote))

            titleLabel.isUserInteractionEnabled = isInEditState
            mainNoteTextView.isUserInteractionEnabled = isInEditState

            mainNoteBottomConstraint.constant = -5

            playSound(whichSound: "Scribble")
            saveNote()

            var mainNoteUpdated = false
            var clubNoteUpdated = false

            if let thisClubNote = self.thisClubNote {
                updateClubNote(note: thisClubNote, newTitle: titleLabel.text!, newSubtitle: mainNoteTextView.text, type: currentClubTypeAsEnum())
                clubNoteUpdated = true
            }
            if let thisMainNote = self.thisMainNote {
                updateMainNote(note: thisMainNote, newTitle: titleLabel.text!, newContent: mainNoteTextView.text)
                mainNoteUpdated = true
            }

//            if !mainNoteUpdated && !clubNoteUpdated {
//                print(thisClubNote)
//                print(thisMainNote)
//                fatalError()
//            }
        }
    }

    func saveNote() {
    }
}
