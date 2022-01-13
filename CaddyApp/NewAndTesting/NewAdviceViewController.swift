//
//  NewAdviceViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/11/22.
//

import UIKit

class NewAdviceViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    // Distance label
    @IBOutlet weak var distanceLabel: UILabel!
    
    // Options Label
    @IBOutlet weak var optionsLabel: UILabel!
    
    
    
    
    // MARK: - Where to aim
    @IBOutlet weak var whereToAimShotContainer: UIView!
    @IBOutlet weak var aimShotTips: UILabel!
    @IBOutlet weak var whereToAimLabel: UILabel!
    @IBOutlet weak var colorOfFlagImage: UIImageView!
    @IBOutlet weak var moreLabel_aim: UIButton!
    @IBAction func moreWasTapped(_ sender: Any) {
        print("tapped")
    }
    
    
    
    // MARK: - Where to put ball in stance
    @IBOutlet weak var ballPlacementContainer: UIView!
    @IBOutlet weak var ballPlacementImageView: UIImageView!
    @IBOutlet weak var ballPlacementLabel: UILabel!
    @IBOutlet weak var ballPlacementTips: UILabel!
    @IBOutlet weak var moreButtonLabelBallPlacement: UIButton!
    @IBAction func ballPlacementMoreTapped(_ sender: Any) {
        print("tapped")
    }
    
    
    func setNecessaryAttributesForProperties() {
        
        // ScrollView
//        scrollView.contentSize = CGSize(width: scrollView.width, height: ballPlacementContainer.bottom + 30)
        scrollView.isScrollEnabled = true
        
        
        // Distance Label
        distanceLabel.translatesAutoresizingMaskIntoConstraints = true
        distanceLabel.text = "Distance to Pin: \(advice.distanceToPin)"
        distanceLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 54)
        distanceLabel.adjustsFontSizeToFitWidth = true
        distanceLabel.layer.cornerRadius = globalCornerRadius
        distanceLabel.backgroundColor = .white
        distanceLabel.textAlignment = .center
        distanceLabel.numberOfLines = 1
        
        
        // Options Label
        optionsLabel.translatesAutoresizingMaskIntoConstraints = true
        optionsLabel.text = "Options"
        optionsLabel.font = UIFont(name: "Helvetica-BoldOblique", size: 20)
        optionsLabel.adjustsFontSizeToFitWidth = false
        optionsLabel.layer.cornerRadius = globalCornerRadius
        optionsLabel.layer.backgroundColor = UIColor.white.cgColor
        optionsLabel.numberOfLines = 1
        
        // whereToAimShotContainer
        whereToAimShotContainer.layer.cornerRadius = globalCornerRadius
        
        // whereToAimShotLabel
        whereToAimLabel.adjustsFontSizeToFitWidth = true
        
        // colorOfFlagImage
        colorOfFlagImage.backgroundColor = .blue
        
        // aimShotTips
        aimShotTips.adjustsFontSizeToFitWidth = true
        
        // moreLabel_aim
        moreLabel_aim.titleLabel?.adjustsFontSizeToFitWidth = true
        moreLabel_aim.titleLabel?.numberOfLines = 1
        
        ballPlacementLabel.adjustsFontSizeToFitWidth = true
        moreButtonLabelBallPlacement.titleLabel?.numberOfLines = 1
        moreButtonLabelBallPlacement.titleLabel?.adjustsFontSizeToFitWidth = true
        
        
        //
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setNecessaryAttributesForProperties()
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}