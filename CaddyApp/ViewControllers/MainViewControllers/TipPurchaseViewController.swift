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
    var amountToShow: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        tipLabel.text = "Leave a $\(amountToShow) Tip"
        fetchProducts()
    }

    func fetchProducts() {
//        com.DialedIn.LeaveTip
        let request = SKProductsRequest(productIdentifiers: ["com.DialedIn.LeaveTip"])
        request.delegate = self
        print("request", request)
        request.start()
    }

    func tipAmount(_ amount: Int) {
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
