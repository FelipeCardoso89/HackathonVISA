//
//  PurchaseViewController.swift
//  hackathonvisa
//
//  Created by Felipe Antonio Cardoso on 01/02/2018.
//  Copyright © 2018 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import VisaCheckoutSDK

class PurchaseViewController: UIViewController {

    @IBOutlet weak var btnPay: VisaCheckoutButton!
    @IBOutlet weak var tableView: UITableView!

    var store: Store?
    var storeProducts = [Product]()

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0

        let purchaseInfo = PurchaseInfo(total: 8.0, currency: .brl)
        purchaseInfo.reviewAction = .pay

        btnPay.onCheckout(purchaseInfo: purchaseInfo) { result in
            switch result.statusCode {
            case .success:
                print("Encrypted key: \(result.encryptedKey ?? "DEU RUIM")")
                print("Payment data: \(result.encryptedPaymentData ?? "DEU RUIM")")
            case .userCancelled:
                print("Payment cancelled by the user")
            default:
                break
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }


}

extension PurchaseViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductTableViewCell.self)) as? ProductTableViewCell {
            let product = products[indexPath.row]
            cell.titleLabel.text = product.title
            cell.decriptionLabel.text = product.description
            cell.priceLabel.text = "R$\(product.price)"
            return cell
        } else {
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }

}
