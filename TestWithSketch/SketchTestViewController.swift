//
//  SketchTestViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/31/21.
//

import UIKit

class SketchTestViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.backgroundColor = UIColor(red: 115 / 255.0, green: 197 / 255.0, blue: 114 / 255.0, alpha: 1.0)
        newSetUpSubViews()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        newLayoutSubviews()

//        yardagesLabel.frame = CGRect(x: ,
//                                     y: ,
//                                     width: sizeOfYardagesLabel.width,
//                                     height: sizeOfYardagesLabel.height)

//        clubLabel.frame = CGRect(x: padRectsFromSides, y: yardagesRect.bottom + 30, width: 50, height: 50)
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        scrollView.contentSize = CGSize(width: view.bounds.maxX, height: view.bounds.maxY)
    }


    // MARK: - Setup Views NEW

    func newSetUpSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(yardagesLargeRectView)
        yardagesLargeRectView.addSubview(yardagesRectTitle)
        scrollView.addSubview(swingsLargeRectView)
        swingsLargeRectView.addSubview(swingsRectTitle)
        scrollView.addSubview(notesLargeRectView)
        notesLargeRectView.addSubview(notesRectTitle)
    }

    func newLayoutSubviews() {
        scrollView.frame = view.bounds
        let padRectsFromSides: CGFloat = 10
        let padLabel: CGFloat = 4
        yardagesLargeRectView.frame = CGRect(x: padRectsFromSides,
                                             y: padRectsFromSides * 2,
                                             width: scrollView.width - (2 * padRectsFromSides),
                                             height: 201)
        yardagesLargeRectView.dropShadow()
//        let sizeOfLabel = clubLabel.sizeThatFits(CGSize(width: yardagesLargeRectView.width, height: yardagesLargeRectView.height))
        yardagesRectTitle.frame = CGRect(x: padLabel,
                                         y: 2 * padRectsFromSides ,
                                         width: scrollView.width - 50,
                                         height: 50)
        
        let tappedYardages = UITapGestureRecognizer(target: self, action: #selector(didTapYardagesButton))
        yardagesLargeRectView.addGestureRecognizer(tappedYardages)
        
        swingsLargeRectView.frame = CGRect(x: padRectsFromSides,
                                           y: yardagesLargeRectView.bottom + padRectsFromSides * 2,
                                             width: scrollView.width - (2 * padRectsFromSides),
                                             height: 201)
        swingsLargeRectView.dropShadow()
        swingsRectTitle.frame = CGRect(x: padLabel,
                                       y: 2 * padRectsFromSides ,
                                         width: scrollView.width - 50,
                                         height: 50)
        
        notesLargeRectView.frame = CGRect(x: padRectsFromSides,
                                           y: swingsLargeRectView.bottom + padRectsFromSides * 2,
                                             width: scrollView.width - (2 * padRectsFromSides),
                                             height: 201)
        notesLargeRectView.dropShadow()
        notesRectTitle.frame = CGRect(x: padLabel,
                                       y: 2 * padRectsFromSides ,
                                         width: scrollView.width - 50,
                                         height: 50)
        
    }

    // MARK: - Setup Views OLD

    func setupSubViews() {
        view.addSubview(scrollView)
//        scrollView.addSubview(mainClubRectView)
//        scrollView.addSubview(yardagesRectView)
//        scrollView.addSubview(swingsRectView)
//        scrollView.addSubview(notesRectView)
        ////        mainClubRect.addSubview(clubLabel)
//        scrollView.addSubview(clubLabel)
//        yardagesRectView.addSubview(yardagesLabel)
//        swingsRectView.addSubview(swingsLabel)
//        notesRectView.addSubview(notesLabel)

        // Do any additional setup after loading the view.
    }

    func layoutSubviews() {
        scrollView.frame = view.bounds
        let padRectsFromSides: CGFloat = 10
        let padBetweenRects: CGFloat = 10
        let widthOfRect: CGFloat = CGFloat((scrollView.width - (padRectsFromSides * 2) - (padRectsFromSides * 2)) / 3)
        mainClubRectView.frame = CGRect(x: padRectsFromSides,
                                        y: padRectsFromSides,
                                        width: scrollView.width - (2 * padRectsFromSides),
                                        height: 180)
        yardagesRectView.frame = CGRect(x: padRectsFromSides,
                                        y: mainClubRectView.bottom + 70,
                                        width: widthOfRect,
                                        height: widthOfRect)
        swingsRectView.frame = CGRect(x: yardagesRectView.right + padBetweenRects,
                                      y: mainClubRectView.bottom + 70,
                                      width: widthOfRect,
                                      height: widthOfRect)

        notesRectView.frame = CGRect(x: swingsRectView.right + padBetweenRects,
                                     y: mainClubRectView.bottom + 70,
                                     width: widthOfRect,
                                     height: widthOfRect)

        let sizeOfLabel = clubLabel.sizeThatFits(CGSize(width: mainClubRectView.width - 10, height: 16))
        clubLabel.frame = CGRect(x: mainClubRectView.left + padRectsFromSides,
                                 y: mainClubRectView.top + padBetweenRects,
                                 width: sizeOfLabel.width + 5,
                                 height: sizeOfLabel.height)

        yardagesLabel.centerXAnchor.constraint(equalTo: yardagesRectView.centerXAnchor).isActive = true
        yardagesLabel.centerYAnchor.constraint(equalTo: yardagesRectView.centerYAnchor).isActive = true
        yardagesLabel.textAlignment = .center

        swingsLabel.centerXAnchor.constraint(equalTo: swingsRectView.centerXAnchor).isActive = true
        swingsLabel.centerYAnchor.constraint(equalTo: swingsRectView.centerYAnchor).isActive = true
        swingsLabel.textAlignment = .center

        notesLabel.centerXAnchor.constraint(equalTo: notesRectView.centerXAnchor).isActive = true
        notesLabel.centerYAnchor.constraint(equalTo: notesRectView.centerYAnchor).isActive = true
        notesLabel.textAlignment = .center

        let tappedYardages = UITapGestureRecognizer(target: self, action: #selector(didTapYardagesButton))
        yardagesRectView.addGestureRecognizer(tappedYardages)

        let tappedSwings = UITapGestureRecognizer(target: self, action: #selector(didTapSwingsButton))
        swingsRectView.addGestureRecognizer(tappedSwings)

        let tappedNotes = UITapGestureRecognizer(target: self, action: #selector(didTapNotesButton))
        notesRectView.addGestureRecognizer(tappedNotes)
    }

    // MARK: - UIViews NEW

    let yardagesLargeRectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
//    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 216 / 255)
        view.isUserInteractionEnabled = true
        return view
    }()

    let yardagesRectTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 34)
        label.text = "Yardages"
//    label.heightAnchor.constraint(equalToConstant: 49.0)
//        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    
    let swingsLargeRectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
//    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 245 / 255, green: 245 / 255, blue: 245 / 255, alpha: 216 / 255)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let swingsRectTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 34)
        label.text = "Swings"
//    label.heightAnchor.constraint(equalToConstant: 49.0)
//        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    
    let notesLargeRectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
//    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 250 / 255, green: 250 / 255, blue: 245 / 255, alpha: 216 / 255)
        view.isUserInteractionEnabled = true
        return view
    }()
    
    let notesRectTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 34)
        label.text = "Notes"
//    label.heightAnchor.constraint(equalToConstant: 49.0)
//        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()

    // MARK: - UIViews OLD

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = true
        return scrollView

    }()

    let mainClubRectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
//    view.backgroundColor = .red
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        return view
    }()

    let yardagesRectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
//    view.backgroundColor = .red
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        return view
    }()

    let swingsRectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
//    view.backgroundColor = .black
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        return view
    }()

    let notesRectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
//    view.backgroundColor = .blue
        view.backgroundColor = .white
        view.isUserInteractionEnabled = true
        return view
    }()

    let clubLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 41)
        label.text = "\(currentClub.name)"
//    label.heightAnchor.constraint(equalToConstant: 49.0)
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()

    let yardagesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-MediumItalic", size: 24)
        label.text = "Yardages"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let swingsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-MediumItalic", size: 24)
        label.text = "Swings"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let notesLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Futura-MediumItalic", size: 24)
        label.text = "Notes"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    // MARK: - Button Actions

    @objc private func didTapYardagesButton() {
        print("Yardages Was Tapped")
        yardagesRectView.showAnimation {
        }
        // Create new view controller that will be used to edit club distance
        let clubVC = storyboard?.instantiateViewController(identifier: "EditClubDistance") as! EditClubDistanceViewController

        clubVC.title = "\(currentClub.name.capitalized) Distances"
        // This is what sends us to the next view controller for editing distance
        navigationController?.pushViewController(clubVC, animated: true)
    }

    @objc private func didTapSwingsButton() {
        print("Swings Was Tapped")
        swingsRectView.showAnimation {
        }
    }

    @objc private func didTapNotesButton() {
        print("Notes Was Tapped")
        notesRectView.showAnimation {
        }
    }
}
