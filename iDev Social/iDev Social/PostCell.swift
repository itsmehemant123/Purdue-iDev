//
//  PostCell.swift
//  iDev Social
//
//  Created by Hemanth Devarapalli on 1/19/17.
//  Copyright © 2017 Hemanth Devarapalli. All rights reserved.
//

import UIKit

class PostCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var postLabel: UILabel!
}
