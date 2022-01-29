//
//  AskForTipViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/29/22.
//

import UIKit
import StoreKit

protocol AskForSupport {
    func nowGoTo (thisViewController: UIViewController)
}

class AskForTipViewController: UIViewController {
    
    var presentingDelegate: AskForSupport?
    
    @IBAction func didTapLeaveReview(_ sender: Any) {
        print("tapped leave review")
        guard let scene = view.window?.windowScene else {
            print("no scene")
            return
        }
        SKStoreReviewController.requestReview(in: scene)
        
//        func rateApp() {
//
//            if #available(iOS 10.3, *) {
//
//                SKStoreReviewController.requestReview()
//
//            } else {
//
//                let appID = "Your App ID on App Store"
//                let urlStr = "https://itunes.apple.com/app/id\(appID)" // (Option 1) Open App Page
//                let urlStr = "https://itunes.apple.com/app/id\(appID)?action=write-review" // (Option 2) Open App Review Page
//
//                guard let url = URL(string: urlStr), UIApplication.shared.canOpenURL(url) else { return }
//
//                if #available(iOS 10.0, *) {
//                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
//                } else {
//                    UIApplication.shared.openURL(url) // openURL(_:) is deprecated from iOS 10.
//                }
//            }
//        }
    }
    @IBAction func didTapLeaveTip(_ sender: Any) {
        print("tapped leave tip")
        let vc = storyboard?.instantiateViewController(withIdentifier: "TipJarViewController") as! TipJarViewController

        
        self.dismiss(animated: true, completion: nil)
        presentingDelegate?.nowGoTo(thisViewController: vc)
        
    }
    
    @IBAction func didTapNoThanks(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

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
