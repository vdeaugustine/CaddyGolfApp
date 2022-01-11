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
        var scrollButton = TransparentButton(superView: scrollView)
        scrollButton.addTarget(self, action: #selector(goToPage), for: .touchUpInside)
        pageControl.tintColor = .blue
        pageControl.backgroundStyle = .prominent
        // Do any additional setup after loading the view.
    }
    
    func setupScreens() {
        for index in 0 ..< pages.count {
            pageFrame.origin.x = scrollView.frame.size.width * CGFloat(index)
            pageFrame.size = scrollView.frame.size
            pageFrames.append(pageFrame)
            
            let thisButton = UIButton(frame: pageFrame)
            thisButton.addTarget(self, action: #selector(goToPage), for: .touchUpInside)
            let thisLabel = UILabel(frame: pageFrame)
            thisLabel.text = pages[index]
            thisLabel.textAlignment = .center
            thisLabel.backgroundColor = colors[index]
            self.scrollView.addSubview(thisLabel)
            self.scrollView.addSubview(thisButton)
            
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
        print("pageControlNumber", pageControl.currentPage)
    }
    
    
    
    @IBAction func pageControlValChange(_ sender: Any) {
        
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: 1.0)
        currentIndex = pageControl.currentPage
        scrollView.scrollRectToVisible(pageFrames[currentIndex], animated: true)
        print(currentIndex)
        
        
       
    }
    
    @objc func goToPage() {
        print("tapped and current index", currentIndex)
        
        switch pageControl.currentPage {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "allNotesViewController") as! AllNotesViewController
            vc.comingFrom = "home"
            vc.title = "Notes"
            self.navigationController?.pushViewController(vc, animated: true)
            
        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "ClubsViewController") as! ClubsViewController
            self.navigationController?.pushViewController(vc, animated: true)
        case 2:
            return
        default:
            return
        }
        
        
        
        
    }
    
    
    

}
