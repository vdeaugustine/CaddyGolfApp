//
//  ClubTableViewCell.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 12/23/21.
//

import UIKit

class ClubTableViewCell: UITableViewCell {

    @IBOutlet weak var tfLabel: UILabel!
    @IBOutlet weak var fullLabel: UILabel!
    @IBOutlet weak var maxLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
    static let identifier = "BigClubCell"

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "BigClubCell", bundle: nil)
    
    }
}
