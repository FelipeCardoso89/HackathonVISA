//
//  ProductTableViewCell.swift
//  hackathonvisa
//
//  Created by Felipe Antonio Cardoso on 01/02/2018.
//  Copyright © 2018 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit

protocol ProductTableViewCellDelegate: class {
    func didSetStepper(at indexPath: IndexPath, to count: Int)
}

class ProductTableViewCell: UITableViewCell {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var stepper: UIStepper!
    @IBOutlet weak var counterLabel: UILabel!

    weak var delegate: ProductTableViewCellDelegate?

    override func layoutSubviews() {
        super.layoutSubviews()
        iconImageView.clipsToBounds = true
        iconImageView.layer.cornerRadius = 4.0
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func showStepper() {
        stepper.isHidden = false
        counterLabel.isHidden = false
    }

    func hideStepper() {
        stepper.isHidden = true
        counterLabel.isHidden = true
    }

    @IBAction func changeStepper(_ sender: Any) {
        if let stepper = sender as? UIStepper {
            counterLabel.text = "x\(Int(stepper.value))"
            delegate?.didSetStepper(at: IndexPath(row: (stepper.tag - 1000), section: 0), to: Int(stepper.value))
        }
    }
}
