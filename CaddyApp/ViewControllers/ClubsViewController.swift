//
//  ViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/3/21.
//

import UIKit
import GoogleMobileAds


/// This is the main ViewController. Where user will be changing and viewing bag
class ClubsViewController: UIViewController {
    
    @IBOutlet weak var bannerContainer: UIView!
    
    private let banner: GADBannerView = {
        let banner = GADBannerView()
//        let banner = GADBannerView(adSize: GADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        banner.translatesAutoresizingMaskIntoConstraints = false
        banner.backgroundColor = .secondarySystemBackground

        return banner
    }()
    
    @IBOutlet var clubsTableView: UITableView!

    @IBOutlet var swingTypeToggle: UIButton!

    @IBOutlet weak var swingTypeSegControl: UISegmentedControl!
    @IBAction func changeSwingType(_ sender: Any) {
        let generator = UIImpactFeedbackGenerator(style: .soft)
        generator.impactOccurred(intensity: 1.0)
        self.clubsTableView.reloadData()
    }
    
    
    var currentSwingTypeState = swingTypeState.threeFourths

    override func viewWillAppear(_ animated: Bool) {
        swingTypeSegControl.selectedSegmentIndex = 1
        clubsTableView.delaysContentTouches = false
        
        clubsTableView.reloadData()
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred(intensity: 0.88)
    }

    override func viewWillLayoutSubviews() {
    }

    override func viewDidAppear(_ animated: Bool) {
        clubsTableView.insetsContentViewsToSafeArea = true
        clubsTableView.cellLayoutMarginsFollowReadableWidth = true
        self.setContentScrollView(clubsTableView)
        // When the clubs view is loaded, it should update mainBag with whatever is in the userDefaults
        // ... although, this might be moved to viewDidLoad() or some other function at a later time. If the mainBag is a global variable that can be edited in other viewControllers, then we might not have to call from UserDefaults, because the mainBag will have already been updated
        do {
            let getUserBag = try UserDefaults.standard.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
            print("immediately after")
            mainBag = getUserBag
        } catch {
            print(error.localizedDescription)
        }
        sortBag()
        clubsTableView.reloadData()

        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetAllClubDistances))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        banner.rootViewController = self
        banner.load(GADRequest())
        bannerContainer.addSubview(banner)
        
        NSLayoutConstraint.activate([
            banner.leadingAnchor.constraint(equalTo: bannerContainer.leadingAnchor),
            banner.topAnchor.constraint(equalTo: bannerContainer.topAnchor),
            banner.rightAnchor.constraint(equalTo: bannerContainer.rightAnchor),
            banner.bottomAnchor.constraint(equalTo: bannerContainer.bottomAnchor),
            banner.heightAnchor.constraint(equalToConstant: bannerHeight)
//            bannerContainer.heightAnchor.constraint(equalToConstant: 0)
            // use the above code if you want to turn off ads
            // what you could do is set the equaltoconstant for banner height a global variable and just change it to 0 if ads are turned off
        ])

        
        
        ModalTransitionMediator.instance.setListener(listener: self)

        clubsTableView.dataSource = self
        clubsTableView.delegate = self
        clubsTableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        let userDefaults = UserDefaults.standard

        navigationItem.rightBarButtonItems?.append(UIBarButtonItem(title: "Reset", style: .done, target: self, action: #selector(resetAllClubDistances)))
        // If there is nothing saved in the UserDefaults (i.e. the first time opening this app)
        if !userDefaults.bool(forKey: "setup") {
            print("\nOK NOT SETUP. LETS TRY\n")
            userDefaults.set(true, forKey: "setup")
            doSave(userDefaults: userDefaults, saveThisBag: mainBag)

        } else {
            do {
                let getUserBag = try userDefaults.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
                mainBag = getUserBag
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    /// This will make all of the clubs in the User's bag back to default distances.
    // will need to be updated at a later time
    @objc func resetAllClubDistances() {
        let alert = UIAlertController(title: "Reset all clubs", message: "Are you sure you would like to reset your bag to default?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
            switch action.style {
            case .default:
                print("yes default")
                mainBag = defaultBag()
                doSave(userDefaults: UserDefaults.standard, saveThisBag: mainBag)
                self.clubsTableView.reloadData()
            case .cancel:
                print("yes cancel")

            case .destructive:
                print("yes destructive")

            @unknown default:
                print("whateverIDC")
            }
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { action in
            switch action.style {
            case .default:
                print("cancel default")

            case .cancel:
                print("cancel cancel")

            case .destructive:
                print("cancel destructive")

            @unknown default:
                print("whateverIDC")
            }
        }))
        present(alert, animated: true, completion: nil)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    @IBAction func swingTypeToggleTapped(_ sender: UIButton) {
        switch currentSwingTypeState {
        case .fullSwing:
            print("FULLSWING")
            currentSwingTypeState = .maxSwing
            swingTypeToggle.setTitle("MAX", for: .normal)
        case .maxSwing:
            print("MAXSWING")
            currentSwingTypeState = .threeFourths
            swingTypeToggle.setTitle("3/4", for: .normal)
        case .threeFourths:
            print("TFSWING")
            currentSwingTypeState = .fullSwing
            swingTypeToggle.setTitle("FULL", for: .normal)
        }
        clubsTableView.reloadData()
    }
}

// MARK: - TABLE VIEW STUFF

extension ClubsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: Making Table View Cell

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "club", for: indexPath) as! ClubCell
        let currentClubForCell = mainBag.allClubs2DArray[indexPath.section][indexPath.row]
        // if something is broken, look here first
//        let currentClubNameForCell = currentClubForCell.name.uppercased()
        let currentClubNameForCell = currentClubForCell.name
        cell.clubNameLabel.text = currentClubNameForCell
        switch swingTypeSegControl.selectedSegmentIndex {
        case 0:
            cell.yardsBox.setMainText("\(currentClubForCell.threeFourthsDistance)")
            cell.yardsBox.setHeaderText("3/4 Swing")
        case 1:
            cell.yardsBox.setMainText("\(currentClubForCell.fullDistance)")
            cell.yardsBox.setHeaderText("Full Swing")
        case 2:
            cell.yardsBox.setMainText("\(currentClubForCell.maxDistance)")
            cell.yardsBox.setHeaderText("Max Swing")
        default:
            break
        }
        
        cell.notesBox.setHeaderText("Notes")
        
//        var thisClubIdentifier: AllClubNames = .driver
//        for item in AllClubNames.allCases {
//            if item.rawValue == currentClubNameForCell {
//                thisClubIdentifier = item
//                break
//            }
//        }
        
        let recentNotesArr = getAllClubNotes(currentClubNameForCell)
        if recentNotesArr.count > 0 {
            let recentNote = recentNotesArr[0]
            cell.notesBox.setMainText(recentNote.subTitle ?? "")
            cell.notesBox.mainTextLabel.textColor = .black


        } else {
            cell.notesBox.setMainText("No notes yet.")
            cell.notesBox.mainTextLabel.textColor = .red
        }
        
       

        
        cell.yardsBox.layoutViews()
        cell.notesBox.layoutViews()
        cell.myViewController = self

//        cell.textLabel?.text = currentClubNameForCell

//        cell.yardsLabel.text = {
//            switch currentSwingTypeState {
//            case .fullSwing:
//                return "\(currentClubForCell.fullDistance)"
//            case .threeFourths:
//                return "\(currentClubForCell.threeFourthsDistance)"
//            case .maxSwing:
//                return "\(currentClubForCell.maxDistance)"
//            }
//
//        }()

        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }

    // MARK: Row Selected

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(mainBag.allClubs2DArray[indexPath.section][indexPath.row]) selected")
        tableView.deselectRow(at: indexPath, animated: true)
        currentClub = mainBag.allClubs2DArray[indexPath.section][indexPath.row]
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred(intensity: 0.88)

        // Create new view controller that will be used to edit club distance
        let clubVC = storyboard?.instantiateViewController(identifier: "MainClubViewController") as! MainClubViewController
        let clubName = mainBag.allClubs2DArray[indexPath.section][indexPath.row].name
        clubVC.title = "\(clubName)".capitalized

        // This is what sends us to the next view controller for editing distance
        navigationController?.pushViewController(clubVC, animated: true)
    }

    // MARK: Rest of Table View Stuff

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove it from the data model
            mainBag.allClubs2DArray[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // Make sure you save the updated bag to defaults so the delete is perminent
            doSave(userDefaults: UserDefaults.standard, saveThisBag: mainBag)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainBag.allClubs2DArray[section].count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return mainBag.types.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mainBag.types[section]
    }

//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let someView = UIView(frame: CGRect(x: 0,
//                                            y: 0,
//                                            width: view.width,
//                                            height: 75))
//
//        let sectionTitleString = mainBag.types[section]
//        let sectionTitle = UILabel()
//        sectionTitle.translatesAutoresizingMaskIntoConstraints = false
//        someView.addSubview(sectionTitle)
//        sectionTitle.textColor = .white
////        sectionTitle.font.withSize(34)
//        sectionTitle.font = UIFont(name: "Helvetica-BoldOblique", size: 24)
//        sectionTitle.text = sectionTitleString
//        sectionTitle.clipsToBounds = true
//        sectionTitle.adjustsFontSizeToFitWidth = true
////        sectionTitle.center = CGPoint(x: 10, y: someView.frame.height / 2)
//        NSLayoutConstraint.activate(
//            [
//                sectionTitle.leadingAnchor.constraint(equalTo: someView.leadingAnchor, constant: 10),
//                sectionTitle.centerYAnchor.constraint(equalTo: someView.centerYAnchor),
//                sectionTitle.widthAnchor.constraint(equalTo: someView.widthAnchor),
//            ]
//        )
//
//        return someView
//    }
}

extension ClubsViewController: ModalTransitionListener {
    // other code
    // required delegate func
    func popoverDismissed() {
        navigationController?.dismiss(animated: true, completion: nil)
        sortBag()
        clubsTableView.reloadData()
    }
}
