//
//  AdviceViewController.swift
//  CaddyApp
//
//  Created by Vincent on 12/6/21.
//

import UIKit

/// - View Hierarchy
///     - view
///         - scrollview
///             - distanceLabelContainerView
///                 - distanceLabel
///             - optionsLabel
///             - moreInfoButton
///             - underClubLargeContainer
///                 - underClubNameRect
///                     - underClubLabel
///                 - underClubSwingDistanceBox.mainContainer
///                 - underClubGapBox.mainContainer
///
///             - overClubLargeContainer
///                 - overClubNameRect
///                     - overClubLabel
///                 - overClubSwingDistanceBox.mainContainer
///                 - overClubGapBox.mainContainer
///             
///
///
///
///

class AdviceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    override func viewWillLayoutSubviews() {
        addSubviews()
        makeFramesForAllViews()
    }
    
    override func viewDidLayoutSubviews() {
        if advice.clubBelowGap < advice.clubAboveGap {
            underClubGapBox.mainTextLabel.textColor = myGreen
            overClubGapBox.mainTextLabel.textColor = .red
        } else if advice.clubBelowGap > advice.clubAboveGap {
            underClubGapBox.mainTextLabel.textColor = .red
            overClubGapBox.mainTextLabel.textColor = myGreen
        }
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(scrollView)
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Result", style: .done, target: self, action: #selector(addResultOfStroke))
        
        tabBarController?.tabBar.isOpaque = true
        view.backgroundColor = UIColor(red: 240, green: 240, blue: 240)
    }

    // MARK: - VIEWS & UIOBJECTS
    
    func addSubviews() {
        

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
        
        scrollView.addSubview(aimShotBox)
        aimShotBox.addSubview(aimShotHeader)
        aimShotBox.addSubview(aimShotTips)
        aimShotBox.addSubview(colorOfFlagImage)
        
        
        scrollView.addSubview(hillBox)
        hillBox.addSubview(hillHeaderLabel)
        hillBox.addSubview(hillTipsLabel)
        // Center View Frame
        // ((big container width) / 2) - ((width of View Frame) / 2)

        
    }

    func makeFramesForAllViews() {
        
        let pad: CGFloat = 5
        
        let farBottomItemInScrollView = hillBox
        let padFromNavBarView = UIView()
        let largeBoxSize = CGSize(width: scrollView.width - pad * 2, height: 250)
        let clubContainers = CGSize(width: scrollView.width - pad * 2, height: 110)

        if let navController = navigationController {
            view.addSubview(padFromNavBarView)
            padFromNavBarView.backgroundColor = .clear
            padFromNavBarView.frame = CGRect(x: 0, y: navController.navigationBar.bottom, width: view.bounds.width, height: 15)

        } else {
            print("nav controller is not there")
        }
        
        let thisHeight = farBottomItemInScrollView.bottom + 200
        scrollView.frame = CGRect(x: 0, y: padFromNavBarView.bottom, width: view.width, height: view.bounds.height)
        scrollView.contentSize = CGSize(width: view.bounds.maxX, height: thisHeight)
        self.setContentScrollView(scrollView)
    
        let distanceWidth = scrollView.width - (2 * 20)
        let distanceLabelContainerView: UIView = {
            let someView = UIView(frame: CGRect(x: 20,
                                                y: 20,
                                                width: scrollView.width - 40,
                                                height: 50))
            someView.backgroundColor = .clear
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
            distanceLabel.trailingAnchor.constraint(equalTo: distanceLabelContainerView.trailingAnchor, constant: -20),

        ])

        distanceLabel.frame = CGRect(x: (scrollView.width / 2) - (distanceWidth / 2),
                                     y: 20,
                                     width: distanceWidth + 2,
                                     height: 50)
        distanceLabel.sizeToFit()


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

        moreInfoButton.frame = CGRect(x: optionsLabel.right + 2,
                                      y: optionsLabel.top,
                                      width: 20,
                                      height: 20)
        moreInfoButton.center = CGPoint(x: moreInfoButton.frame.midX, y: optionsLabel.frame.midY)

        underClubLargeContainer.frame = CGRect(x: 0,
                                               y: optionsLabel.bottom + pad,
                                               width: clubContainers.width,
                                               height: clubContainers.height)
        underClubNameRect.frame = CGRect(x: pad,
                                         y: pad,
                                         width: underClubLargeContainer.width / 3,
                                         height: underClubLargeContainer.height - 10)

        underClubLabel.frame = CGRect(x: -2,
                                      y: 2,
                                      width: underClubNameRect.width - 20,
                                      height: underClubNameRect.height)
        NSLayoutConstraint.activate([
            underClubLabel.leadingAnchor.constraint(equalTo: underClubNameRect.leadingAnchor, constant: pad),
            underClubLabel.trailingAnchor.constraint(equalTo: underClubNameRect.trailingAnchor, constant: -pad),
            underClubLabel.centerYAnchor.constraint(equalTo: underClubNameRect.centerYAnchor),
            overClubLabel.leadingAnchor.constraint(equalTo: overClubNameRect.leadingAnchor, constant: pad),
            overClubLabel.trailingAnchor.constraint(equalTo: overClubNameRect.trailingAnchor, constant: -pad),
            overClubLabel.centerYAnchor.constraint(equalTo: overClubNameRect.centerYAnchor),

        ])

        overClubLargeContainer.frame = CGRect(x: 0,
                                              y: underClubLargeContainer.bottom + pad,
                                              width: clubContainers.width,
                                              height: clubContainers.height)
        overClubNameRect.frame = CGRect(x: pad,
                                        y: pad,
                                        width: overClubLargeContainer.width / 3,
                                        height: overClubLargeContainer.height - 10)

        overClubLabel.frame = CGRect(x: -2,
                                     y: 2,
                                     width: overClubNameRect.width,
                                     height: overClubNameRect.height)

        let roomForUnderBoxes = underClubLargeContainer.width - underClubNameRect.width - pad

        underClubSwingDistanceBox.setupFrames(with: CGRect(x: underClubNameRect.right + 10,
                                                           y: underClubNameRect.top,
                                                           width: roomForUnderBoxes / 2 - 10,
                                                           height: underClubNameRect.height))

        underClubSwingDistanceBox.layoutViews()
        underClubSwingDistanceBox.setMainText("\(advice.closestClubBelow.fullDistance)")
        underClubSwingDistanceBox.setHeaderText("Full Swing".uppercased())

        underClubGapBox.setupFrames(with: CGRect(x: underClubSwingDistanceBox.mainContainer.right + pad,
                                                 y: underClubSwingDistanceBox.mainContainer.top,
                                                 width: underClubSwingDistanceBox.mainContainer.width,
                                                 height: underClubSwingDistanceBox.mainContainer.height))
        underClubGapBox.layoutViews()
        underClubGapBox.setMainText("\(advice.distanceToPin - advice.closestClubBelow.fullDistance)")
        underClubGapBox.setHeaderText("Long".uppercased())

        let roomForOverBoxes = overClubLargeContainer.width - overClubNameRect.width - pad

        overClubSwingDistanceBox.setupFrames(with: CGRect(x: overClubNameRect.right + 10,
                                                          y: overClubNameRect.top,
                                                          width: roomForOverBoxes / 2 - 10,
                                                          height: overClubNameRect.height))
        overClubSwingDistanceBox.layoutViews()
        overClubSwingDistanceBox.setMainText("\(advice.closestClubAbove.fullDistance)")
        overClubSwingDistanceBox.setHeaderText("full swing".uppercased())

        overClubGapBox.setupFrames(with: CGRect(x: overClubSwingDistanceBox.mainContainer.right + pad,
                                                y: overClubSwingDistanceBox.mainContainer.top,
                                                width: overClubSwingDistanceBox.mainContainer.width,
                                                height: overClubSwingDistanceBox.mainContainer.height))
        overClubGapBox.layoutViews()
        overClubGapBox.setMainText("\(abs(advice.distanceToPin - advice.closestClubAbove.fullDistance))")
        overClubGapBox.setHeaderText("Short".uppercased())
        
        aimShotBox.frame =  CGRect(x: pad,
                                   y: overClubLargeContainer.bottom + 10,
                                   width: largeBoxSize.width,
                                   height: largeBoxSize.height)
        
        aimShotHeader.frame =  CGRect(x: pad,
                                      y: pad,
                                      width: 150,
                                      height: 50)
        
        aimShotTips.frame =  CGRect(x: pad,
                                    y: aimShotHeader.bottom + pad,
                                    width: aimShotBox.width - pad - colorOfFlagImage.frame.width - pad - pad,
                                    height: aimShotBox.height - aimShotHeader.height - pad - pad)
        
        
        colorOfFlagImage.frame =  CGRect(x: aimShotBox.right - pad - colorOfFlagImage.frame.size.width,
                                         y: pad,
                                         width: colorOfFlagImage.frame.size.width,
                                         height: colorOfFlagImage.frame.size.height)
        
        hillBox.frame =  CGRect(x: aimShotBox.left,
                                y: aimShotBox.bottom + pad,
                                width: largeBoxSize.width,
                                height: largeBoxSize.height)
        
        hillHeaderLabel.frame =  CGRect(x: pad,
                                        y: pad,
                                        width: (hillBox.width / 2) - pad*2,
                                        height: 50)
        
        hillTipsLabel.frame =  CGRect(x: pad,
                                    y: hillHeaderLabel.bottom + pad,
                                    width: aimShotBox.width - pad - colorOfFlagImage.frame.width - pad - pad,
                                    height: hillBox.height - hillHeaderLabel.height - pad - pad)
        
    }
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
//        label.backgroundColor = .white
        label.layer.backgroundColor = UIColor.clear.cgColor
        label.backgroundColor = .clear
        label.textAlignment = .center
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
//        label.layer.backgroundColor = UIColor.white.cgColor
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
//        thisView.backgroundColor = .lightGray

        return thisView
    }()
    
   
    
    

    @objc func tappedMoreInfo() {
        print("tapped")
        
//        let alert = UIAlertController(title: "Club Gaps Explained", message: "The 'SHORT' box indicates the club that wouldn't necessarily reach the distance to the pin if hit normal distance. \n\nThe 'LONG' club is the club whose distance is further than the distance to the pin.\n\nThe number that is green indicates the closer club", preferredStyle: .alert)
        
        let alert = UIAlertController(title: "Club Gaps Explained", message: "The listed clubs are the clubs whose distances are right below and right above the distance to the pin.\n\nThe number in the box indicates the gap between this club's distance and the distance to the pin.\n\nThe green number is the closer club", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("default")
                
            case .cancel:
                print("cancel")
                
            case .destructive:
                print("destructive")
                
            @unknown default:
                print("whateverIDC")
            }
        }))
        present(alert, animated: true, completion: nil)
        
        //        print("tapped more info")
//
//        scrollView.addSubview(moreInfoView)
////        scrollView.addSubview(moreInfoButton)
////        scrollView.bringSubviewToFront(moreInfoView)
//        view.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(dismissInfoBox)))
//        moreInfoButton.addTarget(self, action: #selector(tappedMoreInfo), for: .touchUpInside)
//
//        moreInfoView.frame = CGRect(x: moreInfoButton.right + 20,
//                                    y: moreInfoButton.top,
//                                    width: 200,
//                                    height: 200)
//        let infoLabel: UILabel = {
//            let label = UILabel()
//            label.numberOfLines = 0
//            label.frame = CGRect(x: 5,
//                                 y: 5,
//                                 width: self.moreInfoView.width - 10,
//                                 height: self.moreInfoView.height - 10)
//            label.backgroundColor = .magenta
//            label.text = "You clicked on more information"
//
//            return label
//        }()
//
//        let dismissButton: UIButton = {
//            let button = UIButton()
//            button.frame = CGRect(x: 0,
//                                  y: 0,
//                                  width: moreInfoView.width,
//                                  height: moreInfoView.height)
//            button.addTarget(self, action: #selector(dismissInfoBox), for: .touchUpInside)
//            return button
//        }()
//        moreInfoView.addSubview(infoLabel)
//        moreInfoView.addSubview(dismissButton)
//        moreInfoView.bringSubviewToFront(dismissButton)
    }

    @objc func dismissInfoBox() {
        moreInfoView.removeFromSuperview()
        print("dismiss tapped")
    }
    
    // MARK: - UnderClub

    var underClubLargeContainer: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
        return thisView
    }()

    var underClubNameRect: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
//        thisView.backgroundColor = .white
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
    
    var underClubGapBox = RoundedBox()
    var underClubSwingDistanceBox = RoundedBox()
    
    // MARK: - Over Club

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
//        thisView.backgroundColor = .white
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
    var overClubGapBox = RoundedBox()
    
    
    // MARK: - Aim Shot
    
    var aimShotBox: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
        thisView.layer.cornerRadius = globalCornerRadius
//        thisView.backgroundColor = .magenta
        thisView.backgroundColor = .white
        thisView.dropShadow()
        return thisView
    }()
    
    var aimShotHeader: UILabel = {
        let label = UILabel()
//        label.layer.backgroundColor = UIColor.blue.cgColor
        label.font = UIFont(name: "Helvetica-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Aim shot"
        label.translatesAutoresizingMaskIntoConstraints = true
        return label
    }()
    
    var aimShotTips: UILabel = {
        let label = UILabel()
//        label.layer.backgroundColor = UIColor.green.cgColor
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.text = "This is temp text"
        label.translatesAutoresizingMaskIntoConstraints = true
        
        return label
    }()
    
    var colorOfFlagImage: UIImageView = {
       let image = UIImageView()
        switch advice.flagColor {
        case "Red":
            image.image = UIImage(named: "basicRedFlag")
        case "White":
            image.image = UIImage(named: "basicWhiteFlag")
        case "Blue":
            image.image = UIImage(named: "basicBlueFlag")
        default:
            print("error, not the right flag color")
        }
        
        image.translatesAutoresizingMaskIntoConstraints = true
        image.frame.size = CGSize(width: 192, height: 108)
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    
    
    
    // MARK: - Hill stuff
    
    var hillBox: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
//        thisView.backgroundColor = .orange
        thisView.layer.cornerRadius = globalCornerRadius
//        thisView.backgroundColor = .magenta
        thisView.backgroundColor = .white
        thisView.dropShadow()
        return thisView
    }()
    
    var hillHeaderLabel: UILabel = {
        let label = UILabel()
//        label.layer.backgroundColor = UIColor.blue.cgColor
        label.font = UIFont(name: "Helvetica-Bold", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Hill Slope"
        label.translatesAutoresizingMaskIntoConstraints = true
        
        return label
    }()
    
    var hillTipsLabel: UILabel = {
        let label = UILabel()
//        label.layer.backgroundColor = myGreen.cgColor
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.text = "You are on a slope.\nThese are the tips for the slope type"
        label.translatesAutoresizingMaskIntoConstraints = true
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - Stuff from old version
    
    

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
    
    @objc func addResultOfStroke() {
        
    }
    
    
}
