//
//  HomePageTableViewCell.swift
//  CaddyApp
//
//  Created by Vincent DeAugustine on 1/11/22.
//

import UIKit

class HomePageTableViewCell: UITableViewCell {

    
    var leftIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    var mainLabel: UILabel = {
        let label = UILabel()
        label.layer.backgroundColor = UIColor.clear.cgColor
        label.font = UIFont(name: "Helvetica-Bold", size: 20)
        label.adjustsFontSizeToFitWidth = true
        label.translatesAutoresizingMaskIntoConstraints = true
        
        return label
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
        self.contentView.addSubview(leftIcon)
        self.contentView.addSubview(mainLabel)
        
        self.leftIcon.frame =  CGRect(x: 5,
                                      y: 2,
                                      width: contentView.height - 4,
                                      height: contentView.height - 4)
        self.mainLabel.frame =  CGRect(x: leftIcon.right + 5,
                                       y: 2,
                                       width: self.contentView.width - self.leftIcon.right - 5,
                                       height: self.leftIcon.height)
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
