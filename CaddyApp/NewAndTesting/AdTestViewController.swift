//
//  AdTestViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/24/22.
//

import GoogleMobileAds
import UIKit

class AdTestViewController: UIViewController {
    
    
    
    private let banner: GADBannerView = {
        let banner = GADBannerView()
//        let banner = GADBannerView(adSize: GADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"

        banner.backgroundColor = .secondarySystemBackground

        return banner
    }()

    private var interstitial: GADInterstitialAd?
    
    @IBAction func doSomething(_ sender: Any) {
      if let interstitial = interstitial {
        interstitial.present(fromRootViewController: self)
      } else {
        print("Ad wasn't ready")
      }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        super.viewDidLoad()
        let request = GADRequest()
        GADInterstitialAd.load(withAdUnitID: "ca-app-pub-3940256099942544/4411468910",
                               request: request,
                               completionHandler: { [self] ad, error in
                                   if let error = error {
                                       print("Failed to load interstitial ad with error: \(error.localizedDescription)")
                                       return
                                   }
                                   interstitial = ad
                                   interstitial?.fullScreenContentDelegate = self
                               }
        )
        banner.rootViewController = self
        view.addSubview(banner)
        banner.load(GADRequest())
        banner.delegate = self
        // Do any additional setup after loading the view.

        banner.frame =  CGRect(x: 0,
                               y: view.frame.height - 150,
                               width: view.frame.width,
                               height: 75)
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

extension AdTestViewController: GADBannerViewDelegate {
    func bannerViewDidReceiveAd(_ bannerView: GADBannerView) {
        print("bannerViewDidReceiveAd")
    }

    func bannerView(_ bannerView: GADBannerView, didFailToReceiveAdWithError error: Error) {
        print()
        print()
        print()

        print("bannerView:didFailToReceiveAdWithError: \(error.localizedDescription)")
        print()
        print()
        print()
    }

    func bannerViewDidRecordImpression(_ bannerView: GADBannerView) {
        print("bannerViewDidRecordImpression")
    }

    func bannerViewWillPresentScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillPresentScreen")
    }

    func bannerViewWillDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewWillDIsmissScreen")
    }

    func bannerViewDidDismissScreen(_ bannerView: GADBannerView) {
        print("bannerViewDidDismissScreen")
    }
}

extension AdTestViewController: GADFullScreenContentDelegate {
    /// Tells the delegate that the ad failed to present full screen content.
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        print("Ad did fail to present full screen content.")
    }

    /// Tells the delegate that the ad presented full screen content.
    func adDidPresentFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did present full screen content.")
    }

    /// Tells the delegate that the ad dismissed full screen content.
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        print("Ad did dismiss full screen content.")
    }
}
