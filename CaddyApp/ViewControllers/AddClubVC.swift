//
//  AddClubVC.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 5/25/22.
//

import UIKit

class AddClubVC: UIViewController, AddClubDelegate {
    func selectedType(_ type: clubTypesEnum) {
        print("selected type called")
        clubType = type
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

    func selectedNumber(_ number: Int) {
        clubNumber = number
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
        }
    }

    private let cells = ["Club Type", "Club Number", "Full Swing Distance"]
    private var clubType: clubTypesEnum = .woods
    private var clubNumber: Int = 1

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(AddClubCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
        tableView.alwaysBounceVertical = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = .systemGray4
        tableView.layer.cornerRadius = 10
        tableView.separatorStyle = .singleLine
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(didTapSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(didTapCancel))
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 10),
            tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            tableView.heightAnchor.constraint(equalToConstant: 3 * 60 + 10),

        ])
    }

    private func presentClubTypeActionSheet() {
        let woodsAction = UIAlertAction(title: "Wood", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.clubType = .woods
            self.selectedType(.woods)
        }
        let ironsAction = UIAlertAction(title: "Iron", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.clubType = .irons
            self.selectedType(.irons)
        }
        let hybridsAction = UIAlertAction(title: "Hybrid", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.clubType = .hybrids
            self.selectedType(.hybrids)
        }
        let wedgesAction = UIAlertAction(title: "Wedge", style: .default) { [weak self] _ in
            guard let self = self else { return }
            self.clubType = .wedges
            self.selectedType(.wedges)
        }

        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)

        let alert = UIAlertController(title: "Select Club Type", message: nil, preferredStyle: .actionSheet)
        alert.addAction(woodsAction)
        alert.addAction(ironsAction)
        alert.addAction(hybridsAction)
        alert.addAction(wedgesAction)
        alert.addAction(cancelAction)

        present(alert, animated: true)
    }

    private func presentClubNumberActionSheet() {
        let one = UIAlertAction(title: "1", style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            self.selectedNumber(1)
        }
        let two = UIAlertAction(title: "2", style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            self.selectedNumber(2)
        }
        let three = UIAlertAction(title: "3", style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            self.selectedNumber(3)
        }
        let four = UIAlertAction(title: "4", style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            self.selectedNumber(4)
        }
        let five = UIAlertAction(title: "5", style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            self.selectedNumber(5)
        }
        let six = UIAlertAction(title: "6", style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            self.selectedNumber(6)
        }
        let seven = UIAlertAction(title: "7", style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            self.selectedNumber(7)
        }
        let eight = UIAlertAction(title: "8", style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            self.selectedNumber(8)
        }
        let nine = UIAlertAction(title: "9", style: .default) {
            [weak self] _ in
            guard let self = self else { return }
            self.selectedNumber(9)
        }

        let alert = UIAlertController(title: "Select Club Type", message: nil, preferredStyle: .actionSheet)

        if clubType == .woods || clubType == .irons || clubType == .hybrids {
            alert.addAction(one)
            alert.addAction(two)
            alert.addAction(three)
            alert.addAction(four)
            alert.addAction(five)
        }
        if clubType == .irons {
            alert.addAction(six)
            alert.addAction(seven)
            alert.addAction(eight)
            alert.addAction(nine)
        }

        present(alert, animated: true)
    }

    @objc func didTapSave() {
    }

    @objc func didTapCancel() {
        dismiss(animated: true)
    }
}

extension AddClubVC: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! AddClubCell
        cell.labelText = cells[indexPath.row]
        if indexPath.row == 0 {
            cell.answerText = "\(clubType.rawValue)"
        } else if indexPath.row == 1 {
            cell.answerText = "\(clubNumber)"
        }
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        switch indexPath.row {
        case 0:
            presentClubTypeActionSheet()
        case 1:
            presentClubNumberActionSheet()
        case 2:
            break
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //        if editingStyle == .delete {
        //            <#Model#>.remove(at: indexPath.row)
        //            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        //            DispatchQueue.main.async { [weak self] in
        //                guard let self = self else {
        //                    return
        //                }
        //                self.tableView.reloadData()
        //            }
        //        }
    }
}

protocol AddClubDelegate {
    func selectedType(_ type: clubTypesEnum)
    func selectedNumber(_ number: Int)
}

class AddClubCell: UITableViewCell {
    var labelText: String!
    var answerText: String?
    var delegate: AddClubDelegate!

    lazy var firstLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        label.adjustsFontSizeToFitWidth = true
        label.text = labelText
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    lazy var secondLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .link
        label.adjustsFontSizeToFitWidth = true
        label.text = answerText ?? ""
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        return label
    }()

    override func layoutSubviews() {
        contentView.backgroundColor = .systemGray4
        contentView.addSubview(firstLabel)
        contentView.addSubview(secondLabel)
        NSLayoutConstraint.activate([
            firstLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            firstLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            firstLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            firstLabel.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2 / 3),

            secondLabel.leadingAnchor.constraint(equalTo: firstLabel.trailingAnchor, constant: 10),
            secondLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            secondLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5),
            secondLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),

        ])
    }
}
