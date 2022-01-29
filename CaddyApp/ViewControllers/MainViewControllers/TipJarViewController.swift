//
//  TipJarViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/24/22.
//

import UIKit

protocol TipDelegate {
    func tipAmount (_ amount: Int)
}

class TipJarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var tableView: UITableView!

    let tipSizes = ["$1", "$5", "$10"]

    var tipAmountDelegate: TipDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        if indexPath.section == 0 {
            cell.textLabel?.text = tipSizes[indexPath.row]
        } else if indexPath.section == 1{
            cell.textLabel?.text = "Turn Off Ads"
        } else {
            cell.textLabel?.text = "Leave a Review"
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return tipSizes.count
        default:
            return 1
        }
    }
    
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Leave a tip"
        case 1:
            return "One-time Purchase"
        case 2:
            return "Other Ways to Support"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 0 {
            let newVC = storyboard?.instantiateViewController(withIdentifier: "TipPurchaseViewController") as! TipPurchaseViewController
            self.tipAmountDelegate = newVC
            switch indexPath.row {
            case 0:
                tipAmountDelegate!.tipAmount(1)
            case 1:
                tipAmountDelegate!.tipAmount(5)
            case 2:
                tipAmountDelegate!.tipAmount(10)
            default:
                break
                
            }
            present(newVC, animated: true, completion: {
                print("completion")
            })
            
            
        }
        
        
    }
}
