//
//  AdviceViewController.swift
//  CaddyApp
//
//  Created by Vincent on 12/6/21.
//

import UIKit

class AdviceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    override func viewWillLayoutSubviews() {
        let padFromNavBarView = UIView()

        if let navController = navigationController {
            view.addSubview(padFromNavBarView)
            padFromNavBarView.backgroundColor = .clear
            padFromNavBarView.frame = CGRect(x: 0, y: navController.navigationBar.bottom, width: view.bounds.width, height: 15)

        } else {
            print("nav controller is not there")
        }

        view.addSubview(scrollView)

        scrollView.addSubview(underClubLargeContainer)
//        scrollView.addSubview(distanceLabel)
        underClubLargeContainer.addSubview(underClubNameRect)
        scrollView.addSubview(optionsLabel)
        scrollView.addSubview(moreInfoButton)
        moreInfoButton.addTarget(self, action: #selector(tappedMoreInfo), for: .touchUpInside)

        
        underClubNameRect.addSubview(underClubLabel)

        scrollView.addSubview(overClubLargeContainer)
        overClubLargeContainer.addSubview(overClubNameRect)
        overClubNameRect.addSubview(overClubLabel)

        underClubLargeContainer.addSubview(underClubSwingDistanceBox.mainContainer)
        underClubLargeContainer.addSubview(underClubGapBox.mainContainer)
        overClubLargeContainer.addSubview(overClubSwingDistanceBox.mainContainer)
        overClubLargeContainer.addSubview(overClubGapBox.mainContainer)
        

        // Center View Frame
        // ((big container width) / 2) - ((width of View Frame) / 2)

        let thisHeight = tipsTypeSegControl.bottom + 20
        scrollView.frame = CGRect(x: 0, y: padFromNavBarView.bottom, width: view.width, height: view.bounds.height)
        scrollView.contentSize = CGSize(width: view.bounds.maxX, height: thisHeight)
//
//        NSLayoutConstraint.activate([
//            distanceLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            distanceLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            distanceLabel.heightAnchor.constraint(equalToConstant: 50),
//            distanceLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20)
//
//        ])
        let distanceWidth = scrollView.width - (2 * 20)
        let distanceLabelContainerView: UIView = {
            let someView = UIView(frame: CGRect(x: 20,
                                                y: 20,
                                                width: scrollView.width - 40,
                                                height: 50))
            someView.backgroundColor = .white
            someView.layer.cornerRadius = globalCornerRadius
            return someView
        }()
        scrollView.addSubview(distanceLabelContainerView)
        distanceLabelContainerView.addSubview(distanceLabel)
        distanceLabel.sizeToFit()
        NSLayoutConstraint.activate([
            distanceLabel.leadingAnchor.constraint(equalTo: distanceLabelContainerView.leadingAnchor, constant: 20),
            distanceLabel.topAnchor.constraint(equalTo: distanceLabelContainerView.topAnchor),
            distanceLabel.bottomAnchor.constraint(equalTo: distanceLabelContainerView.bottomAnchor),
            distanceLabel.trailingAnchor.constraint(equalTo: distanceLabelContainerView.trailingAnchor, constant: -20)
            
        ])

        distanceLabel.frame = CGRect(x: (scrollView.width / 2) - (distanceWidth / 2),
                                     y: 20,
                                     width: distanceWidth + 2,
                                     height: 50)
        distanceLabel.sizeToFit()

//        distanceLabel.frame =  CGRect(x: distanceLabel.frame.minX,
//                                      y: distanceLabel.frame.minY,
//                                      width: distanceLabel.width + 20,
//                                      height: distanceLabel.height + 10)

        optionsLabel.frame = CGRect(x: 20,
                                    y: distanceLabel.bottom + 20,
                                    width: 150,
                                    height: 30)
        optionsLabel.sizeToFit()
        optionsLabel.frame = CGRect(x: optionsLabel.frame.minX,
                                    y: optionsLabel.frame.minY,
                                    width: optionsLabel.width + 20,
                                    height: optionsLabel.height + 10)
        optionsLabel.textAlignment = .center
        
        moreInfoButton.frame =  CGRect(x: optionsLabel.right + 2,
                                       y: optionsLabel.top,
                                       width: 20,
                                       height: 20)
        moreInfoButton.center = CGPoint(x: moreInfoButton.frame.midX, y: optionsLabel.frame.midY)

        underClubLargeContainer.frame = CGRect(x: 0,
                                               y: optionsLabel.bottom + 5,
                                               width: scrollView.frame.width,
                                               height: 110)
        underClubNameRect.frame = CGRect(x: 5,
                                         y: 5,
                                         width: underClubLargeContainer.width / 3,
                                         height: underClubLargeContainer.height - 10)

        underClubLabel.frame = CGRect(x: -2,
                                      y: 2,
                                      width: underClubNameRect.width - 20,
                                      height: underClubNameRect.height)
        NSLayoutConstraint.activate([
            underClubLabel.leadingAnchor.constraint(equalTo: underClubNameRect.leadingAnchor, constant: 5),
            underClubLabel.trailingAnchor.constraint(equalTo: underClubNameRect.trailingAnchor, constant: -5),
            underClubLabel.centerYAnchor.constraint(equalTo: underClubNameRect.centerYAnchor),
            overClubLabel.leadingAnchor.constraint(equalTo: overClubNameRect.leadingAnchor, constant: 5),
            overClubLabel.trailingAnchor.constraint(equalTo: overClubNameRect.trailingAnchor, constant: -5),
            overClubLabel.centerYAnchor.constraint(equalTo: overClubNameRect.centerYAnchor),

        ])

        overClubLargeContainer.frame = CGRect(x: 0,
                                              y: underClubLargeContainer.bottom + 5,
                                              width: scrollView.frame.width,
                                              height: 110)
        overClubNameRect.frame = CGRect(x: 5,
                                        y: 5,
                                        width: overClubLargeContainer.width / 3,
                                        height: overClubLargeContainer.height - 10)

        overClubLabel.frame = CGRect(x: -2,
                                     y: 2,
                                     width: overClubNameRect.width,
                                     height: overClubNameRect.height)

        let roomForUnderBoxes = underClubLargeContainer.width - underClubNameRect.width - 5

        underClubSwingDistanceBox.setupFrames(with: CGRect(x: underClubNameRect.right + 10,
                                                           y: underClubNameRect.top,
                                                           width: roomForUnderBoxes / 2 - 10,
                                                           height: underClubNameRect.height))

        underClubSwingDistanceBox.layoutViews()
        underClubSwingDistanceBox.setMainText("\(advice.closestClubBelow.fullDistance)")
        underClubSwingDistanceBox.setHeaderText("Full Swing".uppercased())

        underClubGapBox.setupFrames(with: CGRect(x: underClubSwingDistanceBox.mainContainer.right + 5,
                                                 y: underClubSwingDistanceBox.mainContainer.top,
                                                 width: underClubSwingDistanceBox.mainContainer.width,
                                                 height: underClubSwingDistanceBox.mainContainer.height))
        underClubGapBox.layoutViews()
        underClubGapBox.setMainText("\(advice.distanceToPin - advice.closestClubBelow.fullDistance)")
        underClubGapBox.setHeaderText("Short".uppercased())

        let roomForOverBoxes = overClubLargeContainer.width - overClubNameRect.width - 5

        overClubSwingDistanceBox.setupFrames(with: CGRect(x: overClubNameRect.right + 10,
                                                          y: overClubNameRect.top,
                                                          width: roomForOverBoxes / 2 - 10,
                                                          height: overClubNameRect.height))
        overClubSwingDistanceBox.layoutViews()
        overClubSwingDistanceBox.setMainText("\(advice.closestClubAbove.fullDistance)")
        overClubSwingDistanceBox.setHeaderText("full swing".uppercased())

        overClubGapBox.setupFrames(with: CGRect(x: overClubSwingDistanceBox.mainContainer.right + 5,
                                                y: overClubSwingDistanceBox.mainContainer.top,
                                                width: overClubSwingDistanceBox.mainContainer.width,
                                                height: overClubSwingDistanceBox.mainContainer.height))
        overClubGapBox.layoutViews()
        overClubGapBox.setMainText("\(abs(advice.distanceToPin - advice.closestClubAbove.fullDistance))")
        overClubGapBox.setHeaderText("Long".uppercased())
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(scrollView)
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
    }

    // MARK: - VIEWS & UIOBJECTS

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true

        return scrollView
    }()

    var distanceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Distance to Pin: \(advice.distanceToPin)"
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 54)
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = globalCornerRadius
        label.backgroundColor = .white
        label.textAlignment = .center
//        label.clipsToBounds = true
        label.numberOfLines = 1

        return label

    }()

    var optionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Options"
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 20)
//        label.textColor = .placeholderText

        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = globalCornerRadius
        label.layer.backgroundColor = UIColor.white.cgColor
//        label.clipsToBounds = true
        label.numberOfLines = 0

        return label

    }()
    
    var moreInfoButton: UIButton = {
       let theButton = UIButton()
        theButton.setBackgroundImage(UIImage(systemName: "info.circle"), for: .normal)

        return theButton
    }()
    
    let moreInfoView: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
        thisView.backgroundColor = .lightGray
        
        return thisView
    }()
    
    @objc func tappedMoreInfo () {
        print("tapped more info")
        
        scrollView.addSubview(moreInfoView)
//        scrollView.addSubview(moreInfoButton)
//        scrollView.bringSubviewToFront(moreInfoView)
        self.view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(dismissInfoBox)))
        moreInfoButton.addTarget(self, action: #selector(tappedMoreInfo), for: .touchUpInside)

        
        self.moreInfoView.frame =  CGRect(x: moreInfoButton.right + 20,
                                 y: moreInfoButton.top,
                                 width: 200,
                                 height: 200)
        let infoLabel: UILabel = {
            let label = UILabel()
            label.numberOfLines = 0
            label.frame =  CGRect(x: 5,
                                  y: 5,
                                  width: self.moreInfoView.width - 10,
                                  height: self.moreInfoView.height - 10)
            label.backgroundColor = .magenta
            label.text = "You clicked on more information"
            
            return label
        }()
        
        let dismissButton: UIButton = {
            let button = UIButton()
            button.frame =  CGRect(x: 0,
                                   y: 0,
                                   width: moreInfoView.width,
                                   height: moreInfoView.height)
            button.addTarget(self, action: #selector(dismissInfoBox), for: .touchUpInside)
            return button
        }()
        self.moreInfoView.addSubview(infoLabel)
        moreInfoView.addSubview(dismissButton)
        moreInfoView.bringSubviewToFront(dismissButton)

        
    }
    
    @objc func dismissInfoBox () {
        self.moreInfoView.removeFromSuperview()
        print("dismiss tapped")
        
    }

    var underClubLargeContainer: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
        return thisView
    }()

    var underClubNameRect: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
        thisView.backgroundColor = .white
        thisView.layer.cornerRadius = globalCornerRadius
        thisView.dropShadow()
        return thisView
    }()

    var underClubLabel: UILabel = {
        let label = UILabel()
        label.text = "\(advice.closestClubBelow.name)"
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        label.textAlignment = .center
        return label
    }()

    var overClubLargeContainer: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
        thisView.layer.cornerRadius = globalCornerRadius
        return thisView
    }()

    var overClubNameRect: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
        thisView.layer.cornerRadius = globalCornerRadius
        thisView.backgroundColor = .white
        thisView.dropShadow()
        return thisView
    }()

    var overClubLabel: UILabel = {
        let label = UILabel()
        label.text = "\(advice.closestClubAbove.name)"
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var clubRecLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Placeholder text"
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 54)
//        label.adjustsFontSizeToFitWidth = true
//        label.clipsToBounds = true
        label.numberOfLines = 0

        return label

    }()

    var overClubSwingDistanceBox = RoundedBox()
    var underClubGapBox = RoundedBox()
    var underClubSwingDistanceBox = RoundedBox()
    var overClubGapBox = RoundedBox()

    var SelectedClubLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    var tipsLabel: UILabel = {
        let tipsLabel = UILabel()
        tipsLabel.translatesAutoresizingMaskIntoConstraints = false
        tipsLabel.numberOfLines = 0
        return tipsLabel
    }()

    var tipsTypeSegControl: UISegmentedControl = {
        let segControl = UISegmentedControl(items: ["Lie Tips", "General Tips", "Shot Type Tips"])
        segControl.addTarget(self, action: #selector(clubTypeSelected(_:)), for: .valueChanged)
        segControl.translatesAutoresizingMaskIntoConstraints = false
        segControl.clipsToBounds = true
        segControl.selectedSegmentIndex = 0
        return segControl
    }()

    var tableView = UITableView()

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "some", for: indexPath)
        cell.textLabel?.text = "Nothing Bro"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // MARK: - Navigation

    @objc func clubTypeSelected(_ sender: UISegmentedControl) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred(intensity: 1.0)
        switch tipsTypeSegControl.selectedSegmentIndex {
        case 0:
            print("Lie Tips Selected")
            tipsLabel.text = "Lie Tips Selected"
        case 1:
            print("General Tips Selected")
            tipsLabel.text = generalAdvice
        case 2:
            print("Shot Type Tips Selected")
            tipsLabel.text = pitchAdvice
        default:
            break
        }
    }
}
