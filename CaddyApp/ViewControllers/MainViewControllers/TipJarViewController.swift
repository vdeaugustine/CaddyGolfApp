//
//  TipJarViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/24/22.
//

import UIKit
import StoreKit

protocol TipDelegate {
    func tipAmount (_ amount: tipAmounts)
}

class TipJarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, SKPaymentTransactionObserver, SKProductsRequestDelegate {
    @IBOutlet var tableView: UITableView!

    let tipSizes = ["$1", "$5", "$10"]

    var tipAmountDelegate: TipDelegate?
    var tipAmountIndex: Int!
    var theResponse: SKProductsResponse?
    var myProduct: SKProduct?
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        fetchProducts()
        // Do any additional setup after loading the view.
    }
    
    func fetchProducts() {
        
        let request = SKProductsRequest(productIdentifiers: [tipAmounts.oneDollar.rawValue, tipAmounts.fiveDollars.rawValue, tipAmounts.tenDollars.rawValue])
        request.delegate = self
        request.start()
        
    }
    
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response)
        print("did receve response")
        print(response.products)
        theResponse = response
        if let theResponse = theResponse {
            for item in Array(theResponse.products) {
                print(item.productIdentifier)
                print(item.localizedTitle)
                print(item.localizedDescription)
            }
        }
//        if let product = response.products.first {
//            myProduct = product
//            print(product.productIdentifier)
//            print(product.price)
//            print(product.localizedTitle)
//            print(product.localizedDescription)
//        } else {
//            print("Problem getting product from response.products.first")
//        }
    }
    
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                break
            case .purchased, .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
                UserDefaults.standard.setValue(false, forKey: "adsEnabled")
                let alert = UIAlertController(title: "Thank you so much!", message: "Your generous donation will go towards adding new features and making this app better.\n\nEnjoy the app with no ads!", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "You are welcome!", style: .default, handler: { action in
                    switch action.style {
                    case .default:
                        self.dismiss(animated: true, completion: nil)

                    case .cancel:
                        print("cancel")

                    case .destructive:
                        print("destructive")

                    @unknown default:
                        print("whateverIDC")
                    }
                }))
                
                
                
                present(alert, animated: true, completion: nil)
            case .failed, .deferred:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            @unknown default:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
            }
        }

    }
    
    
    func didTapPurchase() {
        print("Tap Purchase")
        guard let myProduct = myProduct else {
            print("DAM")
            return
        }
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: myProduct)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
        } else {
            print("Double Dam")
        }
    }
    
    
    

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TipTypeTableViewCell
        

        if indexPath.section == 0 {
            cell.tipTypeLabel.text = tipSizes[indexPath.row]
            switch indexPath.row {
            case 0:
                cell.tipTypeImage.image = UIImage(named: "bagOfTees")
                cell.tipTypeLabel.text = "Bag-of-Tees-Sized Tip"
            case 1:
                cell.tipTypeImage.image = UIImage(named: "golfBall")
                cell.tipTypeLabel.text = "New-Ball-Sized Tip"
            case 2:
                cell.tipTypeImage.image = UIImage(named: "bucketOfBalls")
                cell.tipTypeLabel.text = "Bucket-of-Range-Balls-Sized Tip"

            default:
                break
            }
        } else {
            cell.tipTypeImage.image = UIImage(systemName: "square.and.pencil")
            cell.tipTypeLabel.text = "Leave a review"
        }
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return tipSizes.count
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "All Tip Sizes Remove Ads"
        case 1:
            return "Other Ways to Support"
        default:
            return ""
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.section == 0 {
            if let theResponse = theResponse {
                switch indexPath.row {
                case 0:
                    for product in theResponse.products {
                        if product.productIdentifier == tipAmounts.oneDollar.rawValue {
                            myProduct = product
                            break
                        }
                    }
                case 1:
                    for product in theResponse.products {
                        if product.productIdentifier == tipAmounts.fiveDollars.rawValue {
                            myProduct = product
                            break
                        }
                    }
                case 2:
                    for product in theResponse.products {
                        if product.productIdentifier == tipAmounts.tenDollars.rawValue {
                            myProduct = product
                            break
                        }
                    }
                default:
                    break
                }
                didTapPurchase()
            }
            
            
            
//            print(indexPath.row)
//            if let theResponse = theResponse {
//                myProduct = theResponse.products[indexPath.row]
//                didTapPurchase()
//            } else {
//                print("Couldn't get the response for some reason")
//            }
            
//            let newVC = storyboard?.instantiateViewController(withIdentifier: "TipPurchaseViewController") as! TipPurchaseViewController
//            self.tipAmountDelegate = newVC
            
//            switch indexPath.row {
//            case 0:
////                tipAmountDelegate!.tipAmount(.oneDollar)
//
//            case 1:
////                tipAmountDelegate!.tipAmount(.fiveDollars)
//
//            case 2:
////                tipAmountDelegate!.tipAmount(.tenDollars)
//            default:
//                break
//
//            }
           
//            present(newVC, animated: true, completion: {
//                print("completion")
//            })
            
            
        }
        
        else {
            promptRating()
            
            
            
        }
        
        
    }
    
    func promptRating() {
            
            let defaults = UserDefaults.standard
            let hasPresentedStoreKitRatePrompt = defaults.bool(forKey: "hasPresentedStoreKitRatePrompt")
            
            if hasPresentedStoreKitRatePrompt == false {
                
                guard let scene = view.window?.windowScene else {
                    print("no scene")
                    return
                }
                if #available(iOS 14.0, *) {
                    SKStoreReviewController.requestReview(in: scene)
                } else {
                    SKStoreReviewController.requestReview()
                }
                
                defaults.set(true, forKey: "hasPresentedStoreKitRatePrompt")
            } else {
                
                let alert = UIAlertController(title: "You have already left a review", message: "Thank you for already leaving a review. I truly appreciate your feedback", preferredStyle: .alert)
                
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
                
//                if let url = URL(string: "itms-apps://apple.com/app/id1534974973") {
//                    UIApplication.shared.open(url)
//                } else {
//                    print("error with app store URl")
//                }
            }
        }
}
