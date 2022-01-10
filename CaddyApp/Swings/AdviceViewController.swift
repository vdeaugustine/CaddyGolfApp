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
        scrollView.addSubview(distanceLabel)
        underClubLargeContainer.addSubview(underClubNameRect)
        scrollView.addSubview(optionsLabel)
        underClubNameRect.addSubview(underClubLabel)
        
        scrollView.addSubview(overClubLargeContainer)
        overClubLargeContainer.addSubview(overClubNameRect)
        overClubNameRect.addSubview(overClubLabel)
        


        // Center View Frame
        // ((big container width) / 2) - ((width of View Frame) / 2)

        
        let thisHeight = tipsTypeSegControl.bottom + 20
        scrollView.frame = CGRect(x: 0, y: padFromNavBarView.bottom, width: view.width, height: view.bounds.height)
        scrollView.contentSize = CGSize(width: view.bounds.maxX, height: thisHeight)
        
        let distanceWidth = scrollView.width - (2 * 20)
        distanceLabel.frame = CGRect(x: (scrollView.width / 2) - (distanceWidth / 2),
                                     y: 20,
                                     width: distanceWidth + 2,
                                     height: 50)
        
        optionsLabel.frame =  CGRect(x: 20,
                                     y: distanceLabel.bottom + 20,
                                     width: 150,
                                     height: 30)
        
        underClubLargeContainer.frame = CGRect(x: 0,
                                               y: optionsLabel.bottom + 5,
                                               width: scrollView.frame.width ,
                                               height: 110)
        underClubNameRect.frame = CGRect(x: 5,
                                         y: 5,
                                         width: underClubLargeContainer.width / 3,
                                         height: underClubLargeContainer.height - 10)
        
        underClubLabel.frame =  CGRect(x: -2,
                                       y: 2,
                                       width: underClubNameRect.width,
                                       height: underClubNameRect.height)
        
        overClubLargeContainer.frame = CGRect(x: 0,
                                               y: underClubLargeContainer.bottom + 5,
                                               width: scrollView.frame.width ,
                                               height: 110)
        overClubNameRect.frame = CGRect(x: 5,
                                         y: 5,
                                         width: overClubLargeContainer.width / 3,
                                         height: overClubLargeContainer.height - 10)
        
        overClubLabel.frame =  CGRect(x: -2,
                                       y: 2,
                                       width: overClubNameRect.width,
                                       height: overClubNameRect.height)
        
        let roomForBoxes = underClubLargeContainer.width - underClubNameRect.width - 5
        underClubLargeContainer.addSubview(underClubSwingDistanceBox.mainContainer)
        underClubLargeContainer.addSubview(underClubGapBox.mainContainer)
        underClubSwingDistanceBox.setupFrames(with:  CGRect(x: underClubNameRect.right + 10,
                                                         y: underClubNameRect.top,
                                                         width: roomForBoxes / 2 - 10,
                                                         height: underClubNameRect.height))
        
        underClubSwingDistanceBox.layoutViews()
        underClubSwingDistanceBox.setMainText("\(advice.closestClubBelow.fullDistance)")
        underClubSwingDistanceBox.setHeaderText("Full Swing")
        
        underClubGapBox.setupFrames(with:  CGRect(x: underClubSwingDistanceBox.mainContainer.right + 5,
                                                  y: underClubSwingDistanceBox.mainContainer.top,
                                                  width: underClubSwingDistanceBox.mainContainer.width,
                                                  height: underClubSwingDistanceBox.mainContainer.height))
        underClubGapBox.layoutViews()
        underClubGapBox.setMainText("\(advice.distanceToPin - advice.closestClubBelow.fullDistance)")
        underClubGapBox.setHeaderText("Short".uppercased())
        
        
        
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
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Distance to Pin: \(advice.distanceToPin)"
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 54)
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = globalCornerRadius
//        label.clipsToBounds = true
        label.numberOfLines = 0

        return label

    }()
    
    var optionsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Options"
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 20)
        label.textColor = .placeholderText
        label.adjustsFontSizeToFitWidth = true
        label.layer.cornerRadius = globalCornerRadius
//        label.clipsToBounds = true
        label.numberOfLines = 0

        return label

    }()
    
    var underClubLargeContainer: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
        return thisView
    }()
    
    var underClubNameRect: UIView = {
        let thisView = UIView()
        thisView.translatesAutoresizingMaskIntoConstraints = true
        thisView.dropShadow()
        return thisView
    }()
    
    var underClubLabel: UILabel = {
        let label = UILabel()
        label.text = "\(advice.closestClubBelow.name)"
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 40)
        label.adjustsFontSizeToFitWidth = true
        label.numberOfLines = 1
        label.textAlignment = .left
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
