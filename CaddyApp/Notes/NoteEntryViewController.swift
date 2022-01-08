//
//  NoteEntryViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/5/22.
//

import UIKit

class NoteEntryViewController: UIViewController, UITextViewDelegate {
    var textViewPlaceholder: UILabel = {
        let theLabel = UILabel()
        theLabel.text = "Tap to begin editing..."
        theLabel.textColor = .placeholderText
        theLabel.translatesAutoresizingMaskIntoConstraints = false
        theLabel.adjustsFontSizeToFitWidth = true

        return theLabel
    }()

    @IBOutlet var noteField: UITextView!
    @IBOutlet var titleField: UITextField!
    public var completion: ((String, String) -> Void)?
    var hasContentAlready = false
    var noteContent = ""
    var titleContent = ""
    var comingFrom = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        noteField.delegate = self
        title = "New Note"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        navigationController?.navigationBar.prefersLargeTitles = false
        if hasContentAlready {
            titleField.text = titleContent
            noteField.text = noteContent
        }

        // Set up the placeholder for user beginning to edit
        let sizeOfFont: CGFloat = 18
        // Set font of placeholder label and textView to same size
        textViewPlaceholder.font = textViewPlaceholder.font.withSize(sizeOfFont)
        noteField.font = noteField.font?.withSize(sizeOfFont)
        noteField.translatesAutoresizingMaskIntoConstraints = false
        noteField.addSubview(textViewPlaceholder)

        // This part is for making sure the placeholder looks right when lined up with typing curosr
        if let cursorPosition = noteField.selectedTextRange?.start {
            // cursorPosition is a UITextPosition object describing position in the text (text-wise description)

            let caretPositionRectangle: CGRect = noteField.caretRect(for: cursorPosition)

            // Set up the constraints for AutoLayout for textViewPlaceholder
            let placeholderConstraints = [
                textViewPlaceholder.widthAnchor.constraint(equalToConstant: noteField.width),
                textViewPlaceholder.heightAnchor.constraint(equalToConstant: 30),
                // setting centerY of placeholder to the middle of cursor rectangle
                textViewPlaceholder.centerYAnchor.constraint(equalTo: noteField.topAnchor, constant: caretPositionRectangle.midY),
                // Give it some padding so it's not overlapping with cursor
                textViewPlaceholder.leadingAnchor.constraint(equalTo: noteField.leadingAnchor, constant: 10),
            ]
            NSLayoutConstraint.activate(placeholderConstraints)
        }
    }

    @objc func didTapSave() {
        if let title = titleField.text, !title.isEmpty, let note = noteField.text, !note.isEmpty {
            completion?(title, noteField.text)
            titleContent = title
            noteContent = note
            if hasContentAlready {
                print("Has content")

            } else {
                print("does not have content")
                print("title: ", titleContent)
                print("content: ", noteContent)
                if comingFrom == "home" {
                    print("saving main note from entry controller")
                    createMainNote(title: titleContent, content: noteContent)
                } else if comingFrom == "club" {
                    print("saving club note from entry controller")
                    // TODO: - Make this work for all club types not just nine iron
                    createClubNote(title: titleContent, subtitle: noteContent, type: .nineIron)
                    currentClub.mostRecentClubNoteTitle = titleContent
                    saveCurrentClub()
                }
            }
        }
    }

    func textViewDidChange(_ textView: UITextView) {
        textViewPlaceholder.isHidden = !textView.text.isEmpty
    }
}
