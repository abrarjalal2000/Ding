//
//  SnackUserTableViewCell.swift
//  Ding1
//
//  Created by adnan jalal on 5/16/21.
//

import UIKit
import SDWebImage

class DingUserTableViewCell: UITableViewCell {
    @IBOutlet weak var userImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var dingUser: DingUser! {
        didSet {
            nameLabel.text = dingUser.displayName
            // round corneres of image view
            userImageView.layer.cornerRadius = self.userImageView.frame.size.width / 2
            userImageView.clipsToBounds = true
            
            guard let url = URL(string: dingUser.photoURL) else {
                userImageView.image = UIImage(systemName: "person.crop.circle")
                return
            }
            userImageView.sd_imageTransition = .fade
            userImageView.sd_imageTransition?.duration = 0.1
            userImageView.sd_setImage(with: url, placeholderImage: UIImage(systemName: "person.crop.circle"))
        }
    }
}
