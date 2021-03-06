//
//  ViewController.swift
//  hackathonvisa
//
//  Created by Felipe Antonio Cardoso on 01/02/2018.
//  Copyright © 2018 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import VisaCheckoutSDK

class ViewController: UIViewController {

    @IBOutlet weak var checkoutButton: VisaCheckoutButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        let purchaseInfo = PurchaseInfo(total: 8.0, currency: .brl)
        purchaseInfo.reviewAction = .pay

        checkoutButton.onCheckout(purchaseInfo: purchaseInfo) { [weak self] result in
            switch result.statusCode {
            case .success:
                self?.performSegue(withIdentifier: "segueToConfirmation", sender: nil)
            case .userCancelled:
                print("Payment cancelled by the user")
            default:
                break
            }
        }
    }
}

