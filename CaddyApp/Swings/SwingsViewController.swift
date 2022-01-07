//
//  SwingsViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/1/22.
//

import UIKit

class SwingsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - Properties

    @IBOutlet var viewForYardages: UIView!

    @IBOutlet var swingsTableView: UITableView!
    @IBOutlet var swingTypeSegmentControl: UISegmentedControl!
    var swingTypeSelected: swingTypeState = .threeFourths

    override func viewDidLoad() {
        super.viewDidLoad()
        swingsTableView.delegate = self
        swingsTableView.dataSource = self

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        
        switch currentSwingType {
        case .fullSwing:
            swingTypeSegmentControl.selectedSegmentIndex = 1
            averageNumberLabel.text = "\(currentClub.averageFullDistance)"
        case .maxSwing:
            swingTypeSegmentControl.selectedSegmentIndex = 2
            averageNumberLabel.text = "\(currentClub.averageMaxDistance)"
        case .threeFourths:
            swingTypeSegmentControl.selectedSegmentIndex = 0
            averageNumberLabel.text = "\(currentClub.averageThreeFourthsDistance)"
        }
    }

    override func viewWillLayoutSubviews() {
        setUpSubviews()
    }

    override func viewDidLayoutSubviews() {
        layoutSubviews()
    }

    override func viewWillDisappear(_ animated: Bool) {
        print("VIEW WILL DISAPPEAR")
    }

    // MARK: - Yardages Views

    let averageYardsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
        view.isUserInteractionEnabled = true
        return view
    }()

    let averageYardsHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 255 / 255)
        view.isUserInteractionEnabled = false
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    let averageYardsHeaderLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.text = "AVERAGE"
        //    label.heightAnchor.constraint(equalToConstant: 49.0)
        //        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center

        return label
    }()

    let fixedYardsContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 255 / 255, green: 255 / 255, blue: 255 / 255, alpha: 255 / 255)
        view.isUserInteractionEnabled = true
        return view
    }()

    let fixedYardsHeader: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = true
        view.layer.cornerRadius = 8
        //    view.backgroundColor = .red
        view.backgroundColor = UIColor(red: 220 / 255, green: 220 / 255, blue: 220 / 255, alpha: 255 / 255)
        view.isUserInteractionEnabled = false
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()

    let fixedYardsLabelHeader: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 18)
        label.adjustsFontSizeToFitWidth = true
        label.text = "Fixed"
        //    label.heightAnchor.constraint(equalToConstant: 49.0)
        //        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center

        return label
    }()

    let averageNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 80)
        label.adjustsFontSizeToFitWidth = true
        label.text = "\(0)"
        //    label.heightAnchor.constraint(equalToConstant: 49.0)
        //        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center
        //        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    let fixedNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-BoldOblique", size: 80)
        label.adjustsFontSizeToFitWidth = true
        switch currentSwingType {
        case .fullSwing:
            label.text = "\(currentClub.fullDistance)"
        case .maxSwing:
            label.text = "\(currentClub.maxDistance)"
        case .threeFourths:
            label.text = "\(currentClub.threeFourthsDistance)"
        }

        //    label.heightAnchor.constraint(equalToConstant: 49.0)
        //        label.translatesAutoresizingMaskIntoConstraints = true
        label.textAlignment = .center
        //        label.translatesAutoresizingMaskIntoConstraints = false

        return label
    }()

    // MARK: - Setup Subviews

    func setUpSubviews() {
        viewForYardages.addSubview(averageYardsContainer)
        viewForYardages.addSubview(fixedYardsContainer)

        averageYardsContainer.addSubview(averageYardsHeader)
        averageYardsHeader.addSubview(averageYardsHeaderLabel)
        averageYardsContainer.addSubview(averageNumberLabel)

        fixedYardsContainer.addSubview(fixedYardsHeader)
        fixedYardsHeader.addSubview(fixedYardsLabelHeader)
        fixedYardsContainer.addSubview(fixedNumberLabel)
    }

    func layoutSubviews() {
        let padTopFromRect: CGFloat = 10
        let padSidesFromRect: CGFloat = 40
        let heightOfBoxes: CGFloat = 100
        let widthOfBoxes: CGFloat = (viewForYardages.frame.width - (4 * padSidesFromRect)) / 2

        averageYardsContainer.frame = CGRect(x: padSidesFromRect,
                                             y: padTopFromRect,
                                             width: widthOfBoxes,
                                             height: heightOfBoxes)
        averageYardsContainer.dropShadow()

        let tappedAverage = UITapGestureRecognizer(target: self, action: #selector(doAddSwingAlert))
        averageYardsContainer.addGestureRecognizer(tappedAverage)
        let tappedFixed = UITapGestureRecognizer(target: self, action: #selector(fixedTapped))
        fixedYardsContainer.addGestureRecognizer(tappedFixed)

        averageYardsHeader.frame = CGRect(x: 0,
                                          y: 0,
                                          width: averageYardsContainer.width,
                                          height: averageYardsContainer.height / 3)
        averageYardsHeaderLabel.frame = CGRect(x: 0,
                                               y: 0,
                                               width: averageYardsHeader.width,
                                               height: averageYardsHeader.height)

        fixedYardsContainer.frame = CGRect(x: averageYardsContainer.right + (2 * padSidesFromRect),
                                           y: padTopFromRect,
                                           width: widthOfBoxes,
                                           height: heightOfBoxes)
        fixedYardsContainer.dropShadow()
        fixedYardsHeader.frame = CGRect(x: 0,
                                        y: 0,
                                        width: fixedYardsContainer.width,
                                        height: fixedYardsContainer.height / 3)
        fixedYardsLabelHeader.frame = CGRect(x: 0,
                                             y: 0,
                                             width: fixedYardsHeader.width,
                                             height: fixedYardsHeader.height)

        averageNumberLabel.frame = CGRect(x: -2,
                                          y: averageYardsHeader.bottom + 18,
                                          width: averageYardsContainer.width,
                                          height: averageYardsContainer.height / 3)

        fixedNumberLabel.frame = CGRect(x: -2,
                                        y: fixedYardsHeader.bottom + 18,
                                        width: fixedYardsContainer.width,
                                        height: fixedYardsContainer.height / 3)
    }

    // MARK: - IBActions

    @IBAction func swingTypeChanged(_ sender: UISegmentedControl) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred(intensity: 1.0)
        switch swingTypeSegmentControl.selectedSegmentIndex {
        case 0:
            currentSwingType = .threeFourths
            swingTypeSelected = .threeFourths
            averageNumberLabel.text = "\(currentClub.averageThreeFourthsDistance)"
            fixedNumberLabel.text = "\(currentClub.threeFourthsDistance)"
        case 1:
            currentSwingType = .fullSwing
            swingTypeSelected = .fullSwing
            averageNumberLabel.text = "\(currentClub.averageFullDistance)"
            fixedNumberLabel.text = "\(currentClub.fullDistance)"
        case 2:
            currentSwingType = .maxSwing
            swingTypeSelected = .maxSwing
            averageNumberLabel.text = "\(currentClub.averageMaxDistance)"
            fixedNumberLabel.text = "\(currentClub.maxDistance)"
        default:
            print()
        }
        swingsTableView.reloadData()
    }

    @IBAction func deleteAllButtonTapped(_ sender: UIButton) {
        let alert = UIAlertController(title: "Are you sure you want to delete all distances?", message: "This action cannot be undone", preferredStyle: .alert)
        var doDelete = false
        alert.addAction(UIAlertAction(title: "YES", style: .destructive, handler: { [self] _ in
            doDelete = true
            if doDelete {
                print("DOING DELETE")
                switch swingTypeSelected {
                case .fullSwing:
                    currentClub.previousFullHits = ""
                    currentClub.averageFullDistance = getAvgFromStr(currentClub.previousFullHits)
                    averageNumberLabel.text = "\(currentClub.averageFullDistance)"
                case .maxSwing:
                    currentClub.previousMaxHits = ""
                    currentClub.averageMaxDistance = getAvgFromStr(currentClub.previousMaxHits)
                    averageNumberLabel.text = "\(currentClub.averageMaxDistance)"

                case .threeFourths:
                    currentClub.previousThreeFourthsHits = ""
                    currentClub.averageThreeFourthsDistance = getAvgFromStr(currentClub.previousThreeFourthsHits)
                    averageNumberLabel.text = "\(currentClub.averageThreeFourthsDistance)"
                }
                saveCurrentClub()
                swingsTableView.reloadData()
            }
        }))
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

extension SwingsViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var arrOfPrevHits: [String]
        switch swingTypeSelected {
        case .fullSwing:
            arrOfPrevHits = currentClub.previousFullHits.components(separatedBy: ",")
        case .maxSwing:
            arrOfPrevHits = currentClub.previousMaxHits.components(separatedBy: ",")
        case .threeFourths:
            arrOfPrevHits = currentClub.previousThreeFourthsHits.components(separatedBy: ",")
        }
        if arrOfPrevHits.last == "" {
            _ = arrOfPrevHits.popLast()
        }

        if arrOfPrevHits.count > 0 {
            print(arrOfPrevHits)
            print("")
            return arrOfPrevHits.count + 1
        } else {
            print(arrOfPrevHits)
            return 1
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "addNew")!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "swingsCell")!
            let arrOfPrevHits: [String]
            switch swingTypeSelected {
            case .fullSwing:
                arrOfPrevHits = getSwings(typeOfSwing: .fullSwing)
            case .maxSwing:
                arrOfPrevHits = getSwings(typeOfSwing: .maxSwing)
            case .threeFourths:
                arrOfPrevHits = getSwings(typeOfSwing: .threeFourths)
            }

            cell.textLabel?.text = arrOfPrevHits[indexPath.row - 1]
            return cell
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            doAddSwingAlert()
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteFromCurrentClubPrevHits(thisIndex: indexPath.row - 1, from: swingTypeSelected)

            tableView.deleteRows(at: [indexPath], with: .bottom)
        }
        switch swingTypeSelected {
        case .threeFourths:
            averageNumberLabel.text = "\(currentClub.averageThreeFourthsDistance)"
        case .fullSwing:
            averageNumberLabel.text = "\(currentClub.averageFullDistance)"
        case .maxSwing:
            averageNumberLabel.text = "\(currentClub.averageMaxDistance)"
        }
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.row == 0 {
            return false
        } else {
            return true
        }
    }

    // MARK: - Objc Functions

    @objc func fixedTapped() {
        print("fixedTapped")

        // 1. Create the alert controller.
        let alert = UIAlertController(title: "Change Fixed Distance", message: nil, preferredStyle: .alert)

        // 2. Add the text field
        alert.addTextField { textField in
            textField.placeholder = "Yardage"
            textField.keyboardType = .numberPad
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "UPDATE", style: .default, handler: { [weak alert] _ in
            let textField = alert?.textFields![0]
            if let theDistance = Int((textField?.text)!) {
                switch currentSwingType {
                case .fullSwing:
                    currentClub.fullDistance = theDistance
                    self.fixedNumberLabel.text = "\(currentClub.fullDistance)"
                case .maxSwing:
                    currentClub.maxDistance = theDistance
                    self.fixedNumberLabel.text = "\(currentClub.maxDistance)"
                case .threeFourths:
                    currentClub.threeFourthsDistance = theDistance
                    self.fixedNumberLabel.text = "\(currentClub.threeFourthsDistance)"
                }

                saveCurrentClub()
                self.swingsTableView.reloadData()
            }

            print("Text field: \(textField?.text ?? "")")

        }))

        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        // 4. Present the alert.
        present(alert, animated: true, completion: nil)
    }

    @objc func doAddSwingAlert() {
        // 1. Create the alert controller.
        let alert = UIAlertController(title: "Enter Distance of Previous Shot".uppercased(), message: nil, preferredStyle: .alert)

        // 2. Add the text field
        alert.addTextField { textField in
            textField.placeholder = "Yardage"
            textField.keyboardType = .numberPad
        }

        // 3. Grab the value from the text field, and print it when the user clicks OK.
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] _ in
            let textField = alert?.textFields![0]
            if let theDistance = Int((textField?.text)!), theDistance > 0 {
                switch self.swingTypeSelected {
                case .fullSwing:
                    addSwing(typeOfSwing: .fullSwing, distance: theDistance)
                    self.averageNumberLabel.text = "\(currentClub.averageFullDistance)"
                case .maxSwing:
                    addSwing(typeOfSwing: .maxSwing, distance: theDistance)
                    self.averageNumberLabel.text = "\(currentClub.averageMaxDistance)"
                case .threeFourths:
                    addSwing(typeOfSwing: .threeFourths, distance: theDistance)
                    self.averageNumberLabel.text = "\(currentClub.averageThreeFourthsDistance)"
                }

                saveCurrentClub()
                self.swingsTableView.reloadData()
            } else {
                print("NOT ADDING")
            }

            print("Text field: \(textField?.text ?? "")")

        }))

        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))

        // 4. Present the alert.
        present(alert, animated: true, completion: nil)
    }
}
