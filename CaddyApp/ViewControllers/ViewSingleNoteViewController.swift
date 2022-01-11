//
//  ViewSingleNoteViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/10/22.
//

import UIKit

class ViewSingleNoteViewController: UIViewController {

    @IBOutlet weak var mainNoteTextView: UITextView!
    @IBOutlet weak var titleLabel: UITextField!
    var isInEditState = false
    
    var titleText: String?
    var noteText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Note"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(didTapEditNote))
        self.mainNoteTextView.isUserInteractionEnabled = isInEditState
        self.titleLabel.isUserInteractionEnabled = isInEditState
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
        if isInEditState {
//            let rightButton = self.navigationItem.rightBarButtonItem!.customView as! UIButton
//            rightButton.setTitle("Done", for: .normal)
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                                     target: self,
                                                                     action: #selector(didTapEditNote))
            
            self.titleLabel.isUserInteractionEnabled = isInEditState
            self.mainNoteTextView.isUserInteractionEnabled = isInEditState
            isInEditState = false
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit,
                                                                     target: self,
                                                                     action: #selector(didTapEditNote))
            self.titleLabel.isUserInteractionEnabled = isInEditState
            self.mainNoteTextView.isUserInteractionEnabled = isInEditState
            isInEditState = true
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

}
