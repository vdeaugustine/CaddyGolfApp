//
//  TipPurchaseViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/26/22.
//

import UIKit

class TipPurchaseViewController: UIViewController, TipDelegate {

    @IBAction func purchaseButton(_ sender: Any) {
    }
    @IBOutlet weak var tipLabel: UILabel!
    var amountToShow: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "Leave a $\(amountToShow) Tip"
    }
    
    
    
    func tipAmount(_ amount: Int) {
        amountToShow = amount
    }
    


}
