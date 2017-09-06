//
//  HomeCell.swift
//  GitHubBySwift
//
//  Created by cuiyue on 2017/9/5.
//  Copyright © 2017年 cy. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var iconView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var desLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
