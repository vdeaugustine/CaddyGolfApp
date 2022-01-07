//
//  NoteEntryViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/5/22.
//

import UIKit

class NoteEntryViewController: UIViewController {
    @IBOutlet var noteField: UITextView!
    @IBOutlet var titleField: UITextField!
    public var completion: ((String, String) -> Void)?
    var hasContentAlready = false
    var noteContent = ""
    var titleContent = ""
    var comingFrom = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "New Note"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        if hasContentAlready {
            titleField.text = titleContent
            noteField.text = noteContent
        }

        // Do any additional setup after loading the view.
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
                }
            }
        }
    }
}
