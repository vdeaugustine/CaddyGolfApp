//
//  AddNewClubViewController.swift
//  CaddyApp
//
//  Created by Vincent on 12/13/21.
//

import UIKit

class AddNewClubViewController: UIViewController, UITextFieldDelegate {
    // MARK: - VARIABLES/PROPERTIES

    let clubsForPicker: [String] = ["Pitching Wedge", "9 Iron", "8 Iron", "7 Iron", "6 Iron", "5 Iron", "4 Iron", "Driver"]
    var clubTypeSelected = "Wood" // Just default value because it's first on picker
    var clubName = "Driver" // Just default value because it's first on picker
    var clubTypeChangedAtLeastOnce = false
    var clubNumChangedAtLeastOnce = false
    @IBOutlet weak var clubNumberPicker: UIPickerView!
    @IBOutlet weak var clubTypeSegment: UISegmentedControl!
    var useThisArrForClubsOptions: [String] = woods
    var typeSelectedIndex: Int = 0
    var numSelectedIndex: Int = 0

    @IBOutlet weak var submitButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var mainTitleRectView: UIView!
    @IBOutlet weak var mainTitleLabbel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubNumberPicker.delegate = self
        clubNumberPicker.dataSource = self
        submitButton.dropShadow()
        cancelButton.dropShadow()
        submitButton.layer.cornerRadius = 8
        cancelButton.layer.cornerRadius = 8
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ModalTransitionMediator.instance.sendPopoverDismissed(modelChanged: true)

    }

    // MARK: - IBActions

    @IBAction func exit(_ sender: UIButton) {
        super.dismiss(animated: true, completion: nil)
    }
    
    
    /// Function that is called when SAVE is tapped to save new club to bag
    @IBAction func saveClub(_ sender: UIButton) {
        print("Saved club tapped")

        clubName = useThisArrForClubsOptions[numSelectedIndex]

        print("Trying to save", clubName)
        print(typeSelectedIndex, numSelectedIndex)
        // Need to get userBag so we can edit it
        let userDefaults = UserDefaults.standard

        do {
            let userBagReturned = try userDefaults.getCustomObject(forKey: "user_bag", castTo: UserBag.self)
            mainBag = userBagReturned
        } catch {
            print(error.localizedDescription)
        }
        guard !thatClubIsAlreadyInBag(clubName: clubName, bag: mainBag) else {
            print("Already in bag, Not adding it!")
            print("Club: ", clubName)
            print("Bag: ", mainBag)
            _ = navigationController?.popViewController(animated: true)
            return
        }
        print("Club Type Selected \(clubTypeSelected)")
        print("Club Name: ", clubName)
        print("TypeIndex", typeSelectedIndex, "Num Index", numSelectedIndex)
        let fullDist = { () -> Int in
            var distRet = 1
            if let someClubType = clubTypesEnum(rawValue: clubTypeSelected) {
                switch someClubType {
                case .irons:
                    if let someClub = ironTypes(rawValue: clubName) {
                        switch someClub {
                        case .nineIron:
                            distRet = standardDistanceForClub.nineIron.rawValue
                        case .eightIron:
                            distRet = standardDistanceForClub.eightIron.rawValue
                        case .sevenIron:
                            distRet = standardDistanceForClub.eightIron.rawValue
                        case .sixIron:
                            distRet = standardDistanceForClub.eightIron.rawValue
                        case .fiveIron:
                            distRet = standardDistanceForClub.eightIron.rawValue
                        case .fourIron:
                            distRet = standardDistanceForClub.eightIron.rawValue
                        case .threeIron:
                            distRet = standardDistanceForClub.eightIron.rawValue
                        case .twoIron:
                            distRet = standardDistanceForClub.eightIron.rawValue
                        case .oneIron:
                            distRet = standardDistanceForClub.eightIron.rawValue
                        }
                    }

                case .woods:
                    if let someClub = woodTypes(rawValue: clubName) {
                        switch someClub {
                        case .driver:
                            distRet = standardDistanceForClub.driver.rawValue
                        case .twoWood:
                            distRet = standardDistanceForClub.twoWood.rawValue
                        case .threeWood:
                            distRet = standardDistanceForClub.threeWood.rawValue
                        case .fourWood:
                            distRet = standardDistanceForClub.fourWood.rawValue
                        case .fiveWood:
                            distRet = standardDistanceForClub.fiveWood.rawValue
                        }
                    }
                case .wedges:
                    if let someClub = wedgesTypes(rawValue: clubName) {
                        switch someClub {
                        case .wedge60:
                            distRet = standardDistanceForClub.wedge60.rawValue
                        case .wedge58:
                            distRet = standardDistanceForClub.wedge58.rawValue
                        case .wedge56:
                            distRet = standardDistanceForClub.wedge56.rawValue
                        case .wedge54:
                            distRet = standardDistanceForClub.wedge54.rawValue
                        case .wedge52:
                            distRet = standardDistanceForClub.wedge52.rawValue
                        case .pitching:
                            distRet = standardDistanceForClub.pitchingWedge.rawValue
                        }
                    }
                case .hybrids:
                    if let someClub = hybridTypes(rawValue: clubName) {
                        switch someClub {
                        case .fiveIron:
                            distRet = standardDistanceForClub.fiveHybrid.rawValue
                        case .fourHybrid:
                            distRet = standardDistanceForClub.fourHybrid.rawValue
                        case .threeHybrid:
                            distRet = standardDistanceForClub.threeHybrid.rawValue
                        case .twoHybrid:
                            distRet = standardDistanceForClub.twoHybrid.rawValue
                        case .oneHybrid:
                            distRet = standardDistanceForClub.oneHybrid.rawValue
                        }
                    }
                }
            }

            return distRet
        }()
        let threfDist = Int(0.75 * Double(fullDist))
        let maxDist = Int(1.25 * Double(fullDist))

        let newClubObject = ClubObject(name: clubName, type: clubTypeSelected, fullDistance: fullDist, threeFourthsDistance: threfDist, maxDistance: maxDist, averageFullDistance: 0, previousFullHits: "")

        mainBag.allClubs2DArray[typeSelectedIndex].append(newClubObject)
        mainBag.woodsArray = mainBag.allClubs2DArray[0]
        mainBag.ironsArray = mainBag.allClubs2DArray[1]
        mainBag.hybridsArray = mainBag.allClubs2DArray[2]
        mainBag.wedgesArray = mainBag.allClubs2DArray[3]
        doSave(userDefaults: userDefaults, saveThisBag: mainBag)

        // Go back to previous view controller in the navigation stack
//        _ = navigationController?.popViewController(animated: true)
        
        
//
//        if let firstVC = self.presentingViewController as? ClubsViewController {
//            print("GOTHERE")
//                    DispatchQueue.main.async {
//                        firstVC.clubsTableView.reloadData()
//                    }
//                }
//        else {
//            print("DIDNOTGETHERE")
//        }
//
        super.dismiss(animated: true, completion: nil)
        
        
    }

    @IBAction func clubTypeSelected(_ sender: UISegmentedControl) {
        clubTypeChangedAtLeastOnce = true
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred(intensity: 1.0)
        typeSelectedIndex = clubTypeSegment.selectedSegmentIndex
        switch clubTypeSegment.selectedSegmentIndex {
        case 0:
            print("Wood Selected")
            clubTypeSelected = "Wood"
            useThisArrForClubsOptions = woods
            clubNumberPicker.reloadAllComponents()
        case 1:
            print("Iron Selected")
            clubTypeSelected = "Iron"
            useThisArrForClubsOptions = irons
            clubNumberPicker.reloadAllComponents()
        case 2:
            print("Hybrid Selected")
            clubTypeSelected = "Hybrid"
            useThisArrForClubsOptions = hybrids
            clubNumberPicker.reloadAllComponents()
        case 3:
            print("Wedge Selected")
            clubTypeSelected = "Wedge"
            useThisArrForClubsOptions = wedges
            clubNumberPicker.reloadAllComponents()
        default:
            break
        }
    }
}

// MARK: - UIPicker Handling

extension AddNewClubViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return useThisArrForClubsOptions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return useThisArrForClubsOptions[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Selected \(useThisArrForClubsOptions[row])")
        clubNumChangedAtLeastOnce = true
        numSelectedIndex = row
        clubName = useThisArrForClubsOptions[row]
    }
}
