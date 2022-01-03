//
//  SketchTestViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/31/21.
//

import UIKit

class MainClubViewController: UIViewController {
    
    var swingsCollectionView: UICollectionView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //        view.backgroundColor = UIColor(red: 115 / 255.0, green: 197 / 255.0, blue: 114 / 255.0, alpha: 1.0)
        newSetUpSubViews()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        maxNumber.text = "\(currentClub.maxDistance)"
        fullNumber.text = "\(currentClub.fullDistance)"
        tfNumber.text = "\(currentClub.threeFourthsDistance)"
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

    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        scrollView.isScrollEnabled = true
        return scrollView

    }()

    func newSetUpSubViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(yardagesLargeRectView)
        yardagesLargeRectView.addSubview(yardagesRectTitle)
        scrollView.addSubview(swingsLargeRectView)
        swingsLargeRectView.addSubview(swingsRectTitle)
        scrollView.addSubview(notesLargeRectView)
        notesLargeRectView.addSubview(notesRectTitle)
        
        yardagesLargeRectView.addSubview(tfContainer)
        yardagesLargeRectView.addSubview(fullSwingContainer)
        yardagesLargeRectView.addSubview(maxSwingContainer)
        
        tfContainer.addSubview(tfHeader)
        tfHeader.addSubview(tfHeaderLabel)
        tfContainer.addSubview(tfNumber)
        
        fullSwingContainer.addSubview(fullHeader)
        fullHeader.addSubview(fullHeaderLabel)
        fullSwingContainer.addSubview(fullNumber)
        
        maxSwingContainer.addSubview(maxHeader)
        maxHeader.addSubview(maxHeaderLabel)
        maxSwingContainer.addSubview(maxNumber)
        
        swingsLargeRectView.addSubview(firstSwingRect)
        
    }

    func newLayoutSubviews() {
//        scrollView.frame = view.bounds
        let setUpDimensions = view.bounds
        let padRectsFromSides: CGFloat = 10
        let padLabel: CGFloat = 4
        yardagesLargeRectView.frame = CGRect(x: padRectsFromSides,
                                             y: padRectsFromSides * 2,
                                             width: setUpDimensions.width - (2 * padRectsFromSides),
                                             height: 201)
        yardagesLargeRectView.dropShadow()
        //        let sizeOfLabel = clubLabel.sizeThatFits(CGSize(width: yardagesLargeRectView.width, height: yardagesLargeRectView.height))
        yardagesRectTitle.frame = CGRect(x: padLabel,
                                         y: 2 * padRectsFromSides,
                                         width: setUpDimensions.width - 50,
                                         height: 50)

        let tappedYardages = UITapGestureRecognizer(target: self, action: #selector(didTapYardagesButton))
        yardagesLargeRectView.addGestureRecognizer(tappedYardages)

        swingsLargeRectView.frame = CGRect(x: padRectsFromSides,
                                           y: yardagesLargeRectView.bottom + padRectsFromSides * 2,
                                           width: setUpDimensions.width - (2 * padRectsFromSides),
                                           height: 201)
        swingsLargeRectView.dropShadow()
        swingsRectTitle.frame = CGRect(x: padLabel,
                                       y: 2 * padRectsFromSides,
                                       width: setUpDimensions.width - 50,
                                       height: 50)

        notesLargeRectView.frame = CGRect(x: padRectsFromSides,
                                          y: swingsLargeRectView.bottom + padRectsFromSides * 2,
                                          width: setUpDimensions.width - (2 * padRectsFromSides),
                                          height: 201)
        notesLargeRectView.dropShadow()
        notesRectTitle.frame = CGRect(x: padLabel,
                                      y: 2 * padRectsFromSides,
                                      width: setUpDimensions.width - 50,
                                      height: 50)

        // MARK: Swing Types with Yardages

        let widthOfSwingTypeBoxes = (yardagesLargeRectView.width - padRectsFromSides * 4) / 3
        let heightOfSwingTypeBoxes: CGFloat = 110

        tfContainer.frame = CGRect(x: padRectsFromSides,
                                   y: yardagesRectTitle.bottom + padRectsFromSides,
                                   width: widthOfSwingTypeBoxes,
                                   height: heightOfSwingTypeBoxes)
        tfContainer.dropShadow()

        fullSwingContainer.frame = CGRect(x: padRectsFromSides + tfContainer.right,
                                    y: yardagesRectTitle.bottom + padRectsFromSides,
                                    width: widthOfSwingTypeBoxes,
                                    height: heightOfSwingTypeBoxes)
        fullSwingContainer.dropShadow()

        maxSwingContainer.frame = CGRect(x: padRectsFromSides + fullSwingContainer.right,
                                   y: yardagesRectTitle.bottom + padRectsFromSides,
                                   width: widthOfSwingTypeBoxes,
                                   height: heightOfSwingTypeBoxes)
        maxSwingContainer.dropShadow()

        tfHeader.frame = CGRect(x: 0,
                                y: 0,
                                width: tfContainer.width,
                                height: tfContainer.height / 3)

        tfHeaderLabel.frame = CGRect(x: 0,
                                     y: 0,
                                     width: tfHeader.width,
                                     height: tfHeader.height)
        
        tfNumber.frame = CGRect(x: -2,
                                y: tfHeader.bottom + 18,
                                width: tfContainer.width,
                                height: tfContainer.height / 3)
        
        fullHeader.frame = CGRect(x: 0,
                                y: 0,
                                width: fullSwingContainer.width,
                                height: fullSwingContainer.height / 3)
        
        fullHeaderLabel.frame = CGRect(x: 0,
                                     y: 0,
                                     width: fullHeader.width,
                                     height: fullHeader.height)
        
        fullNumber.frame = CGRect(x: -2,
                                y: fullHeader.bottom + 18,
                                width: fullSwingContainer.width,
                                height: fullSwingContainer.height / 3)
        
        
        maxHeader.frame = CGRect(x: 0,
                                y: 0,
                                width: fullSwingContainer.width,
                                height: fullSwingContainer.height / 3)
        
        maxHeaderLabel.frame = CGRect(x: 0,
                                     y: 0,
                                     width: maxHeader.width,
                                     height: maxHeader.height)
        
        maxNumber.frame = CGRect(x: -2,
                                y: maxHeader.bottom + 18,
                                width: maxSwingContainer.width,
                                height: maxSwingContainer.height / 3)
        
        firstSwingRect.frame = CGRect(x: padRectsFromSides,
                                      y: swingsRectTitle.bottom + 5,
                                      width: swingsLargeRectView.width - padRectsFromSides * 2,
                                      height: swingsLargeRectView.height - swingsRectTitle.frame.maxY - padRectsFromSides)
        print()
        print("height of swings rect", swingsLargeRectView.height)
        print("swings bottom - label bottom", swingsRectTitle.bottom - swingsLargeRectView.bottom)
        print("swings bottom", swingsLargeRectView.bottom)
        print("title bottom", swingsRectTitle.bottom)
        print("BREAK")
        
        let thisheight = maxSwingContainer.frame.maxY + 500
        print("height", thisheight)
        print("view height",view.height)
        print("viewbounds ",view.bounds)
        scrollView.frame = CGRect(x: 0, y: 0, width: setUpDimensions.width, height: setUpDimensions.height)
        scrollView.contentSize = CGSize(width: setUpDimensions.width, height: thisheight)
        
        let tappedSwings = UITapGestureRecognizer(target: self, action: #selector(didTapSwingsButton))
        swingsLargeRectView.addGestureRecognizer(tappedSwings)
    }

    // MARK: - UIViews NEW
    // MARK: Large Rect Views / Containers

    let yardagesLargeRectView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
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
        view.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
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
        view.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
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

    let tfContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
        view.isUserInteractionEnabled = true
        return view
    }()

    let fullSwingContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
        view.isUserInteractionEnabled = true
        return view
    }()

    let maxSwingContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
        view.isUserInteractionEnabled = true
        return view
    }()

    let tfHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 255 / 255)
        view.isUserInteractionEnabled = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    let fullHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 255 / 255)
        view.isUserInteractionEnabled = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    let maxHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 255 / 255)
        view.isUserInteractionEnabled = true
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    let tfHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.text = "3/4 Swing"
        //    label.heightAnchor.constraint(equalToConstant: 49.0)
        //        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center

        return label
    }()
    
    let fullHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Full Swing"
        //    label.heightAnchor.constraint(equalToConstant: 49.0)
        //        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center

        return label
    }()
    
    let maxHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Max Swing"
        //    label.heightAnchor.constraint(equalToConstant: 49.0)
        //        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center

        return label
    }()

    let tfNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 80)
        label.adjustsFontSizeToFitWidth = true
        label.text = "\(currentClub.threeFourthsDistance)"
        //    label.heightAnchor.constraint(equalToConstant: 49.0)
        //        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center
        //        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let fullNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 80)
        label.adjustsFontSizeToFitWidth = true
        label.text = "\(currentClub.fullDistance)"
        //    label.heightAnchor.constraint(equalToConstant: 49.0)
        //        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center
        //        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let maxNumber: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 80)
        label.adjustsFontSizeToFitWidth = true
        label.text = "\(currentClub.maxDistance)"
        //    label.heightAnchor.constraint(equalToConstant: 49.0)
        //        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center
        //        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()
    
    let firstSwingRect = swingRect()

    // MARK: - Button Actions

    @objc private func didTapYardagesButton() {
        print("Yardages Was Tapped")
        yardagesLargeRectView.showAnimation {
        }
        // Create new view controller that will be used to edit club distance
        let clubVC = storyboard?.instantiateViewController(identifier: "EditClubDistance") as! EditClubDistanceViewController

        clubVC.title = "\(currentClub.name.capitalized) Distances"
        // This is what sends us to the next view controller for editing distance
        navigationController?.pushViewController(clubVC, animated: true)
    }

    @objc private func didTapSwingsButton() {
        print("Swings Was Tapped")
        swingsLargeRectView.showAnimation {
        }
        // Create new view controller that will be used to edit club distance
        let swingsVC = storyboard?.instantiateViewController(identifier: "SwingsViewController") as! SwingsViewController

        swingsVC.title = "\(currentClub.name.capitalized) Swings"
        // This is what sends us to the next view controller for editing distance
        navigationController?.pushViewController(swingsVC, animated: true)
    }

    @objc private func didTapNotesButton() {
        print("Notes Was Tapped")
        notesLargeRectView.showAnimation {
        }
    }
}

extension MainClubViewController {
    
    func makePrevSwingRect () -> UIView{
        
        let viewToReturn: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = true
            view.layer.cornerRadius = 8
            view.backgroundColor = .red
//            view.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
            view.isUserInteractionEnabled = true
            return view
        }()
        return viewToReturn
    }
    
    class swingRect: UIView {
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            self.translatesAutoresizingMaskIntoConstraints = true
            self.layer.cornerRadius = 8
            self.backgroundColor = .red
            self.isUserInteractionEnabled = false
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }
    
}
