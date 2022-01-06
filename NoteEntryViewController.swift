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
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.title = "New Note"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        // Do any additional setup after loading the view.
    }
    
    @objc func didTapSave() {
        if let note = noteField.text, !noteField.text.isEmpty {
//            completion?(note)
        }
    }

    

}
