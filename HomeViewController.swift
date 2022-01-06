//
//  HomeViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/3/22.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var mainHeaderView: UIView!
    
    @IBOutlet weak var clubsView: UIView!
    
    @IBOutlet weak var adviceView: UIView!
    @IBOutlet weak var notesView: UIView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        clubsView.isUserInteractionEnabled = true
        adviceView.isUserInteractionEnabled = true
        notesView.isUserInteractionEnabled = true
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
    }
    
    
    override func viewWillLayoutSubviews() {
        mainHeaderView.layer.cornerRadius = 8
        mainHeaderView.dropShadow()
        let clubsTapped = UITapGestureRecognizer(target: self, action: #selector(didTapClubs))
        clubsView.addGestureRecognizer(clubsTapped)
        let adviceTapped = UITapGestureRecognizer(target: self, action: #selector(didTapAdvice))
        let notesTapped = UITapGestureRecognizer(target: self, action: #selector(didTapNotes))
        adviceView.addGestureRecognizer(adviceTapped)
        clubsView.addGestureRecognizer(clubsTapped)
        notesView.addGestureRecognizer(notesTapped)
        clubsView.layer.cornerRadius = 8
        clubsView.dropShadow()
        adviceView.layer.cornerRadius = 8
        adviceView.dropShadow()
        notesView.layer.cornerRadius = 8
        notesView.dropShadow()
        
        
    }
    
    @objc func didTapClubs() {
        print("tapped clubs")
        let clubsVC = storyboard?.instantiateViewController(withIdentifier: "ClubsViewController") as! ClubsViewController
        
        navigationController?.pushViewController(clubsVC, animated: true)
        
    }
    
    @objc func didTapAdvice() {
        print("tapped advice")
        let clubsVC = storyboard?.instantiateViewController(withIdentifier: "ClubsViewController") as! ClubsViewController
        
        navigationController?.pushViewController(clubsVC, animated: true)
        
    }
    
    @objc func didTapNotes() {
        print("tapped notes")
        let clubsVC = storyboard?.instantiateViewController(withIdentifier: "NoteEntryViewController") as! NoteEntryViewController
        
        navigationController?.pushViewController(clubsVC, animated: true)
        
    }

}
