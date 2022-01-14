//
//  NewHomeViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/10/22.
//

import UIKit

class NewHomeViewController: UIViewController, UIScrollViewDelegate {
    @IBOutlet var pageControl: UIPageControl!
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var tableView: UITableView!
    var pages: [String] = ["Notes", "Clubs", "Settings"]
    var colors: [UIColor] = [.red, .green, .blue]
    var pageFrame = CGRect.zero
    var currentIndex = 0
    var pageFrames: [CGRect] = [CGRect]()
    var tableViewModel = ["Notes", "Clubs", "Settings"]
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"
        pageControl.numberOfPages = pages.count
        setupScreens()
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false
//        var scrollButton = TransparentButton(superView: scrollView)
//        scrollButton.addTarget(self, action: #selector(goToPage), for: .touchUpInside)
        pageControl.tintColor = .blue
        pageControl.backgroundStyle = .prominent
        tableView.delegate = self
        tableView.dataSource = self
//        scrollView.bounces = false
        
        
        for frame in pageFrames {
            print("page frame", frame)
            print("scroll frame", scrollView.frame)
            print("scroll content")
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let pageNumber = scrollView.contentOffset.x / scrollView.frame.size.width
//        pageControl.currentPage = Int(pageNumber)
//        print("pageControlNumber", pageControl.currentPage)
//        let thisPageFrame = pageFrames[Int(pageNumber)]
//        scrollView.scrollRectToVisible(thisPageFrame, animated: true)
//        scrollView.setContentOffset(thisPageFrame.origin, animated: true)
    }

    func setupScreens() {
        for index in 0 ..< pages.count {
            pageFrame.origin.x = (scrollView.frame.size.width) * CGFloat(index)
            pageFrame.size = scrollView.frame.size
            pageFrames.append(pageFrame)

            let backImage = UIImage(named: "background\(index+1)")
            let backImageView = UIImageView(image: backImage)
            backImageView.frame = pageFrame
            scrollView.addSubview(backImageView)
            let thisButton = UIButton(frame: CGRect(x: 0,
                                                    y: 0,
                                                    width: backImageView.width,
                                                    height: backImageView.height))
            thisButton.addTarget(self, action: #selector(goToPage), for: .touchUpInside)
            let thisLabel = UILabel(frame:  CGRect(x: 0,
                                                   y: 0,
                                                   width: backImageView.width,
                                                   height: backImageView.height))
            thisLabel.text = pages[index]
            thisLabel.textAlignment = .center
            thisLabel.font = UIFont(name: "Helvetica-Bold", size: 45)
            thisLabel.textColor = .white
            thisLabel.layer.backgroundColor = UIColor(red: 0 / 255, green: 0 / 255, blue: 0 / 255, alpha: 0.4).cgColor
            
            
            
//            thisLabel.backgroundColor = colors[index]
            backImageView.addSubview(thisLabel)
            backImageView.addSubview(thisButton)
            
        }

        scrollView.contentSize = CGSize(width: scrollView.width * CGFloat(pages.count),
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
//        let thisPageFrame = pageFrames[Int(pageNumber)]
//        scrollView.scrollRectToVisible(thisPageFrame, animated: true)
//        scrollView.setContentOffset(thisPageFrame.origin, animated: true)
//        scrollView.contentOffset = CGPoint(x: thisPageFrame.origin.x, y: 0)
        
    }
    
    
    
    
    
    
    func scrollViewDidChangeAdjustedContentInset(_ scrollView: UIScrollView) {
        print("did change")
    }

    
    
    

    @IBAction func pageControlValChange(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: 1.0)
        currentIndex = pageControl.currentPage
        scrollView.scrollRectToVisible(pageFrames[currentIndex], animated: true)
        print("pages frames")
        for page in pageFrames {
            print(page)
        }
        
        print("scrollview rect")
        print(scrollView.contentOffset)
        print(currentIndex)
    }

    @objc func goToPage() {
        print("tapped and current index", currentIndex)

        switch pageControl.currentPage {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "allNotesViewController") as! AllNotesViewController
            vc.comingFrom = "home"
            vc.title = "Notes"
            navigationController?.pushViewController(vc, animated: true)

        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "ClubsViewController") as! ClubsViewController
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            return
        default:
            return
        }
    }
}

extension NewHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomePageTableViewCell
//        let cell = tableView.dequeueReusableCell(withIdentifier: "club", for: indexPath) as! ClubCell

//        cell.textLabel!.text = tableViewModel[indexPath.row]
        
        if indexPath.row == 0 {
//            cell.leftIcon = UIImageView(image: UIImage(named: "notebookIcon"))
//            cell.leftIcon = UIImageView(image: UIImage(named: "basicRedFlag"))
            cell.leftIcon.image = UIImage(systemName: "note.text")
        }
        if indexPath.row == 1 {
            cell.leftIcon.image = UIImage(systemName: "list.dash")
        }
        
        if indexPath.row == 2 {
            cell.leftIcon.image = UIImage(systemName: "gearshape.2")
        }
        cell.mainLabel.text = tableViewModel[indexPath.row]

        
        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewModel.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch indexPath.row {
        case 0:
            let vc = storyboard?.instantiateViewController(withIdentifier: "allNotesViewController") as! AllNotesViewController
            vc.comingFrom = "home"
            vc.title = "Notes"
            navigationController?.pushViewController(vc, animated: true)

        case 1:
            let vc = storyboard?.instantiateViewController(withIdentifier: "ClubsViewController") as! ClubsViewController
            navigationController?.pushViewController(vc, animated: true)
        case 2:
            let vc = storyboard?.instantiateViewController(withIdentifier: "SettingsTableViewController") as! SettingsTableViewController
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}
