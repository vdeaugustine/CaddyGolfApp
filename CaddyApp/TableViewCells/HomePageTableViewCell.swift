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
        
//        self.leftIcon.frame =  CGRect(x: 5,
//                                      y: contentView.centerY - (leftIcon.height / 2),
//                                      width: contentView.height - 4,
//                                      height: contentView.height - 4)
//        print(leftIcon.center)
//        print(contentView.centerY)
//        self.mainLabel.frame =  CGRect(x: leftIcon.right + 15,
//                                       y: 2,
//                                       width: self.contentView.width - self.leftIcon.right - 5,
//                                       height: self.leftIcon.height)
        leftIcon.translatesAutoresizingMaskIntoConstraints = false
        mainLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            leftIcon.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 5),
            leftIcon.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            leftIcon.heightAnchor.constraint(equalToConstant: contentView.height - 4),
            leftIcon.widthAnchor.constraint(equalToConstant: contentView.height - 4),
            
            mainLabel.centerYAnchor.constraint(equalTo: leftIcon.centerYAnchor),
            mainLabel.leftAnchor.constraint(equalTo: leftIcon.rightAnchor, constant: 15),
            mainLabel.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: 5)
        
        
        ])
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
