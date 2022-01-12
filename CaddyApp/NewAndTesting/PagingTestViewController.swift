//
//  PagingTestViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/10/22.
//

import UIKit

class PagingTestViewController: UIViewController, UIScrollViewDelegate, UIPageViewControllerDelegate {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    var movies: [String] = ["bad-boys","joker","hollywood"]
    var frame = CGRect.zero
    override func viewDidLoad() {
        super.viewDidLoad()

        // Tells the page control how many little dots to have
        pageControl.numberOfPages = movies.count
        setupScreens()
        // Do any additional setup after loading the view.
    }
    
    
    func setupScreens() {
        for index in 0..<movies.count {
                // 1. The images will be positioned side-by-side in the frame of the scroll view.
                    // The left size of the image will be set to the point where the last one ends
                frame.origin.x = scrollView.frame.size.width * CGFloat(index)
                frame.size = scrollView.frame.size
                
                // 2. The images are loaded and added to the scroll view.
                let imgView = UIImageView(frame: frame)
                    // image asset names are the same as the array
                imgView.image = UIImage(named: movies[index])

                self.scrollView.addSubview(imgView)
            }

            // 3. The contentsize is the total size of the scrollview.
            scrollView.contentSize = CGSize(width: (scrollView.frame.size.width * CGFloat(movies.count)), height: scrollView.frame.size.height)
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
    
   

}
