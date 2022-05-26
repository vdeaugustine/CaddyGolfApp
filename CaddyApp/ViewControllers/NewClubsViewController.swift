//
//  NewClubsViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 5/24/22.
//

import UIKit

class NewClubsViewController: UIViewController {
    // MARK: - Class Properties

    private var currentSwingType: swingTypeState = .fullSwing {
        didSet {
            print("New swing type", currentSwingType)
        }
    }

    // MARK: - Class Methods

    // MARK: - VC Lifecycle

    // MARK: - UI Properties

    private lazy var swingTypeSegControl: UISegmentedControl = {
        let sc = UISegmentedControl()
        sc.translatesAutoresizingMaskIntoConstraints = false
        sc.insertSegment(withTitle: "3/4", at: 0, animated: false)
        sc.insertSegment(withTitle: "Full", at: 1, animated: false)
        sc.insertSegment(withTitle: "Max", at: 2, animated: false)
        sc.selectedSegmentIndex = 1
        sc.addTarget(self, action: #selector(segChanged), for: .valueChanged)
        return sc
    }()

    @objc func segChanged(sender: UISegmentedControl) {
        print("called")
        switch swingTypeSegControl.selectedSegmentIndex {
        case 0:
            currentSwingType = .threeFourths
        case 1:
            currentSwingType = .fullSwing
        case 2:
            currentSwingType = .maxSwing
        default:
            break
        }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(NewClubCellTableViewCell.self, forCellReuseIdentifier: "NewClubCellTableViewCell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()

    private lazy var addClubButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))

    private lazy var resetButton = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(didTapReset))

    // MARK: - UI Methods

    @objc private func didTapReset() {
        print("tapped reset")
        let alert = UIAlertController(title: "Reset all clubs", message: "Are you sure you would like to reset your bag to default? This cannot be undone", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "YES", style: .default, handler: { _ in
            print("yes default")
            mainBag = defaultBag()
            doSave(userDefaults: UserDefaults.standard, saveThisBag: mainBag)

            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.tableView.reloadData()
            }
        }
        )
        )
        alert.addAction(UIAlertAction(title: "CANCEL", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }

    @objc private func didTapAdd() {
        let newVC = AddClubVC()
        let nav = UINavigationController(rootViewController: newVC)
        nav.modalPresentationStyle = .pageSheet
        guard let sheet = nav.sheetPresentationController else {
            return
        }
        sheet.detents = [.medium()]
        sheet.prefersGrabberVisible = true
        present(nav, animated: true)
        
    }

    private func layoutSegControl() {
        NSLayoutConstraint.activate([
            swingTypeSegControl.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            swingTypeSegControl.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            swingTypeSegControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            swingTypeSegControl.heightAnchor.constraint(equalToConstant: 40),
        ])
    }

    private func layoutTableView() {
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: swingTypeSegControl.bottomAnchor, constant: 10),
            tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10),
        ])
    }

    // MARK: - OBJC Functions and Actions

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "My Clubs"
        navigationItem.rightBarButtonItems = [addClubButton, resetButton]
        view.backgroundColor = .black
        view.addSubview(swingTypeSegControl)
        view.addSubview(tableView)
        layoutSegControl()
        layoutTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }
}

extension NewClubsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return mainBag.types.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainBag.allClubs2DArray[section].count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewClubCellTableViewCell", for: indexPath) as! NewClubCellTableViewCell
        cell.club = mainBag.allClubs2DArray[indexPath.section][indexPath.row]
        cell.swingType = currentSwingType
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Remove it from the data model
            mainBag.allClubs2DArray[indexPath.section].remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            // Make sure you save the updated bag to defaults so the delete is perminent
            doSave(userDefaults: UserDefaults.standard, saveThisBag: mainBag)
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return mainBag.types[section]
    }
}
