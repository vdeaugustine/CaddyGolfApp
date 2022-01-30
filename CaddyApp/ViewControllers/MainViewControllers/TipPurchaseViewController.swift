//
//  TipPurchaseViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/26/22.
//

import StoreKit
import UIKit

class TipPurchaseViewController: UIViewController, TipDelegate, SKProductsRequestDelegate, SKPaymentTransactionObserver {
    var myProduct: SKProduct?

    

    @IBOutlet var tipLabel: UILabel!
    var amountToShow: tipAmounts = .fiveDollars

    override func viewDidLoad() {
        super.viewDidLoad()
        switch amountToShow {
        case .oneDollar:
            tipLabel.text = "Leave a $\(1) Tip"
        case .fiveDollars:
            tipLabel.text = "Leave a $\(5) Tip"
        case .tenDollars:
            tipLabel.text = "Leave a $\(10) Tip"
        
            break
        }
        
        fetchProducts()
    }

    func fetchProducts() {
//        com.DialedIn.LeaveTip
       
        let request = SKProductsRequest(productIdentifiers: [amountToShow.rawValue])
        request.delegate = self
        print("request", request)
        request.start()
    }

    func tipAmount(_ amount: tipAmounts) {
        amountToShow = amount
    }

    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response)
        print(response.products)
        if let product = response.products.first {
            myProduct = product
            print(product.productIdentifier)
            print(product.price)
            print(product.localizedTitle)
            print(product.localizedDescription)
        } else {
            print("Problem getting product from response.products.first")
        }
        
        
        
        
    }
    
    
    

    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchasing:
                break
            case .purchased, .restored:
                SKPaymentQueue.default().finishTransaction(transaction)
                SKPaymentQueue.default().remove(self)
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
    
    

    @IBAction func didTapPurchase(_ sender: Any) {
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
    
    @IBAction func didTapNevermind(_ sender: Any) {
        
        self.dismiss(animated: true)
    }
    
    
}
