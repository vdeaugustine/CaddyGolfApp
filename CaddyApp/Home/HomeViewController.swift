//
//  HomeViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/3/22.
//

import UIKit

class HomeViewController: UIViewController {
    @IBOutlet var mainHeaderView: UIView!

    @IBOutlet var clubsView: UIView!

    @IBOutlet var adviceView: UIView!
    @IBOutlet var notesView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        clubsView.isUserInteractionEnabled = true
        adviceView.isUserInteractionEnabled = true
        notesView.isUserInteractionEnabled = true
    }

    override func viewWillAppear(_ animated: Bool) {
    }

    override func viewWillLayoutSubviews() {
        mainHeaderView.layer.cornerRadius = globalCornerRadius
        mainHeaderView.dropShadow()
        let clubsTapped = UITapGestureRecognizer(target: self, action: #selector(didTapClubs))
        clubsView.addGestureRecognizer(clubsTapped)
        let adviceTapped = UITapGestureRecognizer(target: self, action: #selector(didTapAdvice))
        let notesTapped = UITapGestureRecognizer(target: self, action: #selector(didTapNotes))
        adviceView.addGestureRecognizer(adviceTapped)
        clubsView.addGestureRecognizer(clubsTapped)
        notesView.addGestureRecognizer(notesTapped)
        clubsView.layer.cornerRadius = globalCornerRadius
        clubsView.dropShadow()
        adviceView.layer.cornerRadius = globalCornerRadius
        adviceView.dropShadow()
        notesView.layer.cornerRadius = globalCornerRadius
        notesView.dropShadow()
    }

    @objc func didTapClubs() {
        let clubsVC = storyboard?.instantiateViewController(withIdentifier: "ClubsViewController") as! ClubsViewController

        navigationController?.pushViewController(clubsVC, animated: true)
    }

    @objc func didTapAdvice() {
        let clubsVC = storyboard?.instantiateViewController(withIdentifier: "ClubsViewController") as! ClubsViewController

        navigationController?.pushViewController(clubsVC, animated: true)
    }

    @objc func didTapNotes() {
        let notesVC = storyboard?.instantiateViewController(withIdentifier: "allNotesViewController") as! AllNotesViewController

        notesVC.comingFrom = "home"

        navigationController?.pushViewController(notesVC, animated: true)
    }
}
