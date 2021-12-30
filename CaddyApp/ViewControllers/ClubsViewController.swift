//
//  ViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/3/21.
//

import CoreData
import UIKit

/// This is the main ViewController. Where user will be changing and viewing bag
class ClubsViewController: UIViewController {
    @IBOutlet var clubsTableView: UITableView!

    @IBOutlet var swingTypeToggle: UIButton!
    let currentGolfBag = AppDelegate.userGolfBag
    var currentSwingTypeState = swingTypeState(rawValue: 0)
    var ironsArrTest: [SingleClub]?
    var woodsArrTest: [SingleClub]?
    var hybridsArrTest: [SingleClub]?
    var wedgesArrTest: [SingleClub]?
    var allClubOfAllTypes = [[SingleClub]]()

    override func viewDidAppear(_ animated: Bool) {
        clubsTableView.reloadData()
//        printBagOutLines(bag: mainBag)

        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset All", style: .done, target: self, action: #selector(resetAllClubDistances))
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        clubsTableView.dataSource = self
        clubsTableView.delegate = self
        if isFirstSetup() {
            makeStandardBag() }
        // load in the data from CoreData to arrays/objects we can use
        do {
            let bagFetchRequest = try coreDataContext.fetch(UserGolfBag.fetchRequest())
            let clubsFetchRequest = try coreDataContext.fetch(SingleClub.fetchRequest())
            let tempGolfBag = bagFetchRequest[0]
            print(bagFetchRequest.count)
            print(clubsFetchRequest.count)
            for brequest in bagFetchRequest {
                print("******************")
                print(brequest)
                print("******************")
            }
//            let secondBag = bagFetchRequest[1]
            print(tempGolfBag.ironsArr!)
            let ironsSet = tempGolfBag.ironsArr! // this is an NSSet
            ironsArrTest = ironsSet.allObjects as? [SingleClub]
            let woodsSet = tempGolfBag.woodsArr!
            woodsArrTest = woodsSet.allObjects as? [SingleClub]
            let hybridsSet = tempGolfBag.hybridsArr! // this is an NSSet
            hybridsArrTest = hybridsSet.allObjects as? [SingleClub]
            let wedgesSet = tempGolfBag.wedgesArr!
            wedgesArrTest = wedgesSet.allObjects as? [SingleClub]
            allClubOfAllTypes.append(woodsArrTest!)
            allClubOfAllTypes.append(hybridsArrTest!)
            allClubOfAllTypes.append(ironsArrTest!)
            allClubOfAllTypes.append(wedgesArrTest!)
        } catch {
            fatalError()
        }
//        if let ioz = ironsArrTest {
//            print("POINS")
//            for itemx in ioz {
//                print(itemx.name!)
//                print("GO")
//            }
//        } else {
//            print("WTF")
//        }
//       printIronsCoreData()
    }

    /// This will make all of the clubs in the User's bag back to default distances.
    // will need to be updated at a later time
    @objc func resetAllClubDistances() {
        makeStandardBag()
        saveCoreData()
        self.clubsTableView.reloadData()
//        let alert = UIAlertController(title: "Reset all clubs", message: "Are you sure you would like to reset your bag to default?", preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { action in
//            switch action.style {
//            case .default:
//                print("yes default")
//                makeGolfBagStandard()
//                self.clubsTableView.reloadData()
//            case .cancel:
//                print("yes cancel")
//
//            case .destructive:
//                print("yes destructive")
//
//            @unknown default:
//                print("whateverIDC")
//            }
//        }))
//        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: { action in
//            switch action.style {
//            case .default:
//                print("cancel default")
//
//            case .cancel:
//                print("cancel cancel")
//
//            case .destructive:
//                print("cancel destructive")
//
//            @unknown default:
//                print("whateverIDC")
//            }
//        }))
//        present(alert, animated: true, completion: nil)
//        // Taptic feedback when button is tapped
//        let generator = UINotificationFeedbackGenerator()
//        generator.notificationOccurred(.success)
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
        case .none:
            currentSwingTypeState = .fullSwing
        }
        clubsTableView.reloadData()
    }
}

// MARK: - TABLE VIEW STUFF

// Extension for handling and managing TableView
extension ClubsViewController: UITableViewDelegate, UITableViewDataSource {
    // MARK: Making Table View Cell

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "club", for: indexPath) as! ClubCell
        ////        let currentClubForCell = mainBag.allClubs2DArray[indexPath.section][indexPath.row]
//        guard let currentClubForCell = AppDelegate.userGolfBag.allClubs2DArr?[indexPath.section][indexPath.row] else {
//            // This might give problem of returning a cell even if we don't want one. Look here if you are getting one too many cells
//            return cell
//        }

        let currentClubForCell = allClubOfAllTypes[indexPath.section][indexPath.row]
        let currentClubNameForCell = currentClubForCell.name
//        let currentClubDistance = currentClubForCell.fullDistance
        cell.textLabel?.text = currentClubNameForCell
//        cell.yardsLabel.text = "\(currentClubDistance) yards"
        cell.yardsLabel.text = {
            switch currentSwingTypeState {
            case .fullSwing:
                return "\(currentClubForCell.fullSwingDistance)"
            case .threeFourths:
                return "\(currentClubForCell.threeFourthsDistance)"
            case .maxSwing:
                return "\(currentClubForCell.maxDistance)"
            case .none:
                return ""
            case .some:
                return ""
            }

        }()

        return cell
    }

    // MARK: Row Selected

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if let selectedClub = AppDelegate.userGolfBag.allClubs2DArr?[indexPath.section][indexPath.row] {
//            currentClubCORE = selectedClub
//            let taptic = UIImpactFeedbackGenerator(style: .rigid)
//            taptic.impactOccurred(intensity: 1.0)
//
//            // Create new view controller that will be used to edit club distance
//            let clubVC = storyboard?.instantiateViewController(identifier: "EditClubDistance") as! EditClubDistanceViewController
//            let clubName = selectedClub.name
//
//            clubVC.title = "\(clubName!) Distance"
//
//            // This is what sends us to the next view controller for editing distance
//            navigationController?.pushViewController(clubVC, animated: true)
//        }
    }

    // MARK: Rest of Table View Stuff

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove it from the data model
            let selectedClub = allClubOfAllTypes[indexPath.section][indexPath.row]
            switch selectedClub.type {
            case clubTypesEnum.woods.rawValue:
                woodsArrTest?.remove(at: (woodsArrTest?.firstIndex(of: selectedClub))!)
                AppDelegate.userGolfBag.removeFromWoodsArr(selectedClub)
//                deleteClub(from: .woods, at: indexPath.row)
            case clubTypesEnum.irons.rawValue:
//                deleteClub(from: .irons, at: indexPath.row)
                ironsArrTest?.remove(at: (ironsArrTest?.firstIndex(of: selectedClub))!)
                AppDelegate.userGolfBag.removeFromIronsArr(selectedClub)
            case clubTypesEnum.hybrids.rawValue:
//                deleteClub(from: .hybrids, at: indexPath.row)
                hybridsArrTest?.remove(at: (hybridsArrTest?.firstIndex(of: selectedClub))!)
                AppDelegate.userGolfBag.removeFromHybridsArr(selectedClub)
            case clubTypesEnum.wedges.rawValue:
//                deleteClub(from: .wedges, at: indexPath.row)
                wedgesArrTest?.remove(at: (wedgesArrTest?.firstIndex(of: selectedClub))!)
                AppDelegate.userGolfBag.removeFromWedgesArr(selectedClub)
            default:
                break
            }
            saveCoreData()
//            allClubOfAllTypes[indexPath.section].remove(at: indexPath.row)
            allClubOfAllTypes.removeAll()
            allClubOfAllTypes.append(woodsArrTest!)
            allClubOfAllTypes.append(hybridsArrTest!)
            allClubOfAllTypes.append(ironsArrTest!)
            allClubOfAllTypes.append(wedgesArrTest!)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // Make sure you save the updated bag to defaults so the delete is perminent
//            saveCoreData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allClubOfAllTypes[section].count
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return allClubOfAllTypes.count
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        print(userBagCore.allClubs2DArr)
//        if let x = userBagCore.allClubs2DArr {
//            for i in x {
//                for n in i {
//                    print(n.name)
//                }
//            }
//        }
        return clubTypes[section]
    }
}
