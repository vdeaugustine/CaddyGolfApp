//
//  NoteTableViewCell.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/6/22.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    
    @IBOutlet var noteTitle: UILabel!
    @IBOutlet var noteContentPreview: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        noteContentPreview.dropShadow()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
