//
//  AdviceViewController.swift
//  CaddyApp
//
//  Created by Vincent on 12/6/21.
//

import UIKit

class AdviceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var clubRecLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = true
        label.text = "Placeholder text"
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 54)
        label.adjustsFontSizeToFitWidth = true
//        label.clipsToBounds = true
        label.numberOfLines = 1
        return label

    }()

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
        return segControl
    }()

    var tableView = UITableView()

    var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.clipsToBounds = true
        return scrollView
    }()

    override func viewWillLayoutSubviews() {
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.addSubview(scrollView)
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

       
        
        let padFromNavBarView = UIView()

        if let navController = navigationController {
            view.addSubview(padFromNavBarView)
            padFromNavBarView.backgroundColor = .clear
            padFromNavBarView.frame = CGRect(x: 0, y: navController.navigationBar.bottom, width: view.bounds.width, height: 15)

        } else {
            print("nav controller is not there")
        }

        
        view.addSubview(scrollView)
        scrollView.backgroundColor = .red
        
        scrollView.addSubview(tipsTypeSegControl)
        scrollView.addSubview(clubRecLabel)
        clubRecLabel.frame = CGRect(x: scrollView.left + 20, y: scrollView.top + 20, width: view.frame.width - 50, height: 50)
        clubRecLabel.backgroundColor = .orange
//        clubRecLabel.sizeThatFits(CGSize(width: 50, height: 50))
        
        
        
        
//        NSLayoutConstraint.activate(
//            [
//                clubRecLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 15),
//                clubRecLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 15),
//                clubRecLabel.widthAnchor.constraint(equalTo: view.widthAnchor)
//            ]
//        )
        NSLayoutConstraint.activate(
            [
                tipsTypeSegControl.heightAnchor.constraint(equalToConstant: 50),
                tipsTypeSegControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
                tipsTypeSegControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
                tipsTypeSegControl.topAnchor.constraint(equalTo: clubRecLabel.bottomAnchor)
            ]
        )
        
        let thisHeight = tipsTypeSegControl.bottom + 20
        scrollView.frame = CGRect(x: 0, y: padFromNavBarView.bottom, width: view.width, height: view.bounds.height)
        scrollView.contentSize = CGSize(width: view.bounds.maxX, height: thisHeight)
        

//        tipsTypeSegControl.frame = CGRect(x: 0, y: 0, width: view.width - 20, height: 50)

//        tipsTypeSegControl.frame = CGRect(x: 20, y: 20, width: scrollView.width, height: scrollView.height)
//        let tipsSegControlConstraints = [
//            tipsTypeSegControl.topAnchor.constraint(equalTo: scrollView.topAnchor),
//            tipsTypeSegControl.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
//            tipsTypeSegControl.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
//            tipsTypeSegControl.heightAnchor.constraint(equalToConstant: 50),
//        ]
//        NSLayoutConstraint.activate(tipsSegControlConstraints)

//        tipsLabel.frame = CGRect(x: 20, y: 20, width: tipsTypeSegControl.width, height: 0)
//        NSLayoutConstraint.activate([
//            tipsLabel.topAnchor.constraint(equalTo: tipsTypeSegControl.bottomAnchor, constant: 30),
//            tipsLabel.widthAnchor.constraint(equalToConstant: tipsTypeSegControl.width),
//            tipsLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20)
//        ])
        tipsLabel.backgroundColor = .blue
        scrollView.backgroundColor = .red

//        let tipsLabelConstraints = [
//            tipsLabel.topAnchor.constraint(equalTo: tipsTypeSegControl.bottomAnchor, constant: 35),
//            tipsLabel.leadingAnchor.constraint(equalTo: tipsTypeSegControl.leadingAnchor),
//            tipsLabel.trailingAnchor.constraint(equalTo: tipsTypeSegControl.trailingAnchor),
//            tipsLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -20)
//        ]
//        NSLayoutConstraint.activate(tipsLabelConstraints)

        let longOrShort = advice.closestClubDistance - advice.distanceToPin < 0 ? "long" : "short"

//        SelectedClubLabel.text = "Your \(advice.closestClub.name) goes \(advice.closestClub.fullDistance) which is a \(advice.closestClubGap) gap. Go with a \(longOrShort) \(advice.closestClub.name)"
//        YardsToPin.text = "\(advice.distanceToPin) Yards to the Pin"

//        view.addSubview(tableView)
    }

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
