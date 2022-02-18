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
    let stackView = UIStackView()
    var pages: [String] = ["Notes", "Clubs", "New Stroke"]
    var colors: [UIColor] = [.red, .green, .blue]
    var pageFrame = CGRect.zero
    var currentIndex = 0
    var pageFrames: [CGRect] = [CGRect]()
    var tableViewModel = ["Notes", "Clubs", "New Stroke", "Support Development"]

    override func viewWillAppear(_ animated: Bool) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred(intensity: 0.88)
     
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"

        pageControl.numberOfPages = pages.count
        setupScreens()
        scrollView.backgroundColor = .white
        scrollView.showsHorizontalScrollIndicator = false

        pageControl.tintColor = .blue
        pageControl.backgroundStyle = .prominent
        tableView.delegate = self
        tableView.dataSource = self
        scrollView.delegate = self

        for frame in pageFrames {
            print("page frame", frame)
            print("scroll frame", scrollView.frame)
            print("scroll content")
        }
    }

    override func viewDidLayoutSubviews() {
    }

    func setupScreens() {

        scrollView.addSubview(stackView)
        scrollView.isPagingEnabled = true

        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal

        for pageNumber in 0 ..< pages.count {
            let thisPage = UIImageView()
            thisPage.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(thisPage)
            thisPage.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
            thisPage.image = UIImage(named: "background\(pageNumber + 1)")

            let tint: UIView = {
                let thisView = UIView()
                thisView.translatesAutoresizingMaskIntoConstraints = false
                thisView.backgroundColor = .black
                thisView.alpha = 0.4
                return thisView
            }()

            thisPage.addSubview(tint)

            NSLayoutConstraint.activate([
                tint.leadingAnchor.constraint(equalTo: thisPage.leadingAnchor),
                tint.topAnchor.constraint(equalTo: thisPage.topAnchor),
                tint.rightAnchor.constraint(equalTo: thisPage.rightAnchor),
                tint.bottomAnchor.constraint(equalTo: thisPage.bottomAnchor),
            ])

            pageFrame.origin.x = scrollView.frame.size.width * CGFloat(pageNumber)
            pageFrame.size = scrollView.frame.size
            pageFrames.append(pageFrame)

            let pageLabel: UILabel = {
                let label = UILabel()
                label.font = UIFont(name: "Helvetica-Bold", size: 48)
                label.adjustsFontSizeToFitWidth = true
                label.text = "\(pages[pageNumber])"
                label.translatesAutoresizingMaskIntoConstraints = false
                label.textColor = .white

                return label
            }()
            thisPage.addSubview(pageLabel)
            NSLayoutConstraint.activate([
                pageLabel.centerXAnchor.constraint(equalTo: thisPage.centerXAnchor),
                pageLabel.centerYAnchor.constraint(equalTo: thisPage.centerYAnchor),
            ])
        }

        stackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
        stackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true

        scrollView.contentSize = CGSize(width: scrollView.width * CGFloat(pages.count),
                                        height: scrollView.height)

        let goToPageButton = UIButton()
        goToPageButton.frame = CGRect(x: 0,
                                      y: 0,
                                      width: scrollView.width * CGFloat(pages.count),
                                      height: scrollView.height)
        goToPageButton.addTarget(self, action: #selector(goToPage), for: .touchUpInside)

        scrollView.addSubview(goToPageButton)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = round(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(page)
    }

    @IBAction func pageControlValChange(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: 1.0)
        scrollView.contentOffset = stackView.arrangedSubviews[pageControl.currentPage].frame.origin
    }

    @objc func goToPage() {
        print("tapped and current index", pageControl.currentPage)

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
            let vc = storyboard?.instantiateViewController(withIdentifier: "NewStrokeViewController") as! NewStrokeViewController
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}

extension NewHomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomePageTableViewCell

        if indexPath.row == 0 {
            cell.leftIcon.image = UIImage(systemName: "note.text")
        }
        if indexPath.row == 1 {
            cell.leftIcon.image = UIImage(systemName: "list.dash")
        }

        if indexPath.row == 2 {
            cell.leftIcon.image = UIImage(systemName: "plus")
        }

        if indexPath.row == 3 {
            cell.leftIcon.image = UIImage(systemName: "star")
        }

        cell.mainLabel.text = tableViewModel[indexPath.row]

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44
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
            let vc = storyboard?.instantiateViewController(withIdentifier: "NewStrokeViewController") as! NewStrokeViewController
            navigationController?.pushViewController(vc, animated: true)

        case 3:
            let vc = storyboard?.instantiateViewController(withIdentifier: "TipJarViewController") as! TipJarViewController
            navigationController?.pushViewController(vc, animated: true)
        default:
            return
        }
    }
}


