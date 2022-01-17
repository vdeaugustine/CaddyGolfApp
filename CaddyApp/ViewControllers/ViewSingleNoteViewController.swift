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
    var isInEditState = false

    var titleText: String?
    var noteText: String?
    var thisClubNote: ClubNote?
    var thisMainNote: MainNote?

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

        // Do any additional setup after loading the view.
    }

    @objc func didTapEditNote() {
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
            
            mainNoteTextView.translatesAutoresizingMaskIntoConstraints = false
            mainNoteTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 20).isActive = true
            mainNoteTextView.backgroundColor = .blue
            
            
            
            saveNote()
            
            if let thisClubNote = thisClubNote {
                updateClubNote(note: thisClubNote, newTitle: titleLabel.text!, newSubtitle: mainNoteTextView.text, type: currentClubTypeAsEnum())
            }
            if let thisMainNote = thisMainNote {
                updateMainNote(note: thisMainNote, newTitle: titleLabel.text!, newContent: mainNoteTextView.text)
            }
            
        }
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */

    func saveNote() {
    }
}
