//
//  TipTypeTableViewCell.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/29/22.
//

import UIKit

class TipTypeTableViewCell: UITableViewCell {
    @IBOutlet weak var tipTypeImage: UIImageView!
    
    @IBOutlet weak var tipTypeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
