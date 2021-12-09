//
//  AdviceViewController.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/6/21.
//

import UIKit

class AdviceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "some", for: indexPath)
        cell.textLabel?.text = "Nothing Bro"
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    /*
     // MARK: - Navigation

     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
     }
     */
}
