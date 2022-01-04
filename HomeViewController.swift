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
    
    override func viewWillLayoutSubviews() {
        let clubsTapped = UITapGestureRecognizer(target: self, action: #selector(didTapClubs))
        clubsView.addGestureRecognizer(clubsTapped)
        clubsView.layer.cornerRadius = 8
        clubsView.dropShadow()
    }
    
    @objc func didTapClubs() {
        print("tapped clubs")
        let clubsVC = storyboard?.instantiateViewController(withIdentifier: "ClubsViewController") as! ClubsViewController
        
        navigationController?.pushViewController(clubsVC, animated: true)
        
    }

}
