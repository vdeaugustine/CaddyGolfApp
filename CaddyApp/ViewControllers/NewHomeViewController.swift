//
//  NewHomeViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/10/22.
//

import UIKit

class NewHomeViewController: UIViewController, UIScrollViewDelegate {
    
    

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var scrollView: UIScrollView!
    var pages: [String] = ["Notes", "Clubs", "Settings"]
    var colors: [UIColor] = [.red, .green, .blue]
    var pageFrame = CGRect.zero
    var currentIndex = 0
    var pageFrames : [CGRect] = [CGRect]()
    override func viewDidLoad() {
        super.viewDidLoad()

        pageControl.numberOfPages = pages.count
        setupScreens()
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
        // Do any additional setup after loading the view.
    }
    
    func setupScreens() {
        for index in 0 ..< pages.count {
            pageFrame.origin.x = scrollView.frame.size.width * CGFloat(index)
            pageFrame.size = scrollView.frame.size
            pageFrames.append(pageFrame)
            
            let thisLabel = UILabel(frame: pageFrame)
            thisLabel.text = pages[index]
            thisLabel.textAlignment = .center
            thisLabel.backgroundColor = colors[index]
            self.scrollView.addSubview(thisLabel)
        }
        
        scrollView.contentSize = CGSize(width: (scrollView.width * CGFloat(pages.count)),
                                        height: scrollView.height)
        scrollView.delegate = self
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
        pageControl.currentPage = Int(pageNumber)
    }
    
    @IBAction func pageControlValChange(_ sender: Any) {
        
        currentIndex = pageControl.currentPage
        scrollView.scrollRectToVisible(pageFrames[currentIndex], animated: true)
        
        
        
       
    }
    
    
    

}
