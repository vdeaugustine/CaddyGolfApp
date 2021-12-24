//
//  AdviceViewController.swift
//  CaddyApp
//
//  Created by Vincent on 12/6/21.
//

import UIKit

class AdviceViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    @IBOutlet var YardsToPin: UILabel!
    @IBOutlet var SelectedClubLabel: UILabel!
    @IBOutlet var tipsLabel: UILabel!
    @IBOutlet var tipsTypeSegControl: UISegmentedControl!

    var tableView = UITableView()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self

        let longOrShort = advice.closestClubDistance - advice.distanceToPin < 0 ? "long" : "short"

        
        SelectedClubLabel.text = "Your \(advice.closestClub.name!) goes \(advice.closestClub.fullSwingDistance) which is a \(advice.closestClubGap) gap. Go with a \(longOrShort) \(advice.closestClub.name!)"
        YardsToPin.text = "\(advice.distanceToPin) Yards to the Pin"

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

    @IBAction func clubTypeSelected(_ sender: UISegmentedControl) {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred(intensity: 1.0)
        switch tipsTypeSegControl.selectedSegmentIndex {
        case 0:
            print("Lie Tips Selected")
            tipsLabel.text = "Lie Tips Selected"
        case 1:
            print("General Tips Selected")
            tipsLabel.text = generalAdvice
        case 2:
            print("Shot Type Tips Selected")
            tipsLabel.text = pitchAdvice
        default:
            break
        }
    }
}
