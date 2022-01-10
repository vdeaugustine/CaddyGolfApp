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
    
    var titleText: String?
    var noteText: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let titleText = titleText {
            titleLabel.text = titleText
        }
        if let noteText = noteText {
            mainNoteTextView.text = noteText
        }

        // Do any additional setup after loading the view.
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
