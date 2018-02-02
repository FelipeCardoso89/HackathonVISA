//
//  NearStoreTableViewCell.swift
//  hackathonvisa
//
//  Created by Felipe Antonio Cardoso on 01/02/2018.
//  Copyright © 2018 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit

class NearStoreTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
