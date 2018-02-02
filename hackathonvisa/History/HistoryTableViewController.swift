//
//  HistoryTableViewController.swift
//  hackathonvisa
//
//  Created by Felipe Antonio Cardoso on 01/02/2018.
//  Copyright © 2018 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import SVProgressHUD

class HistoryTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        emulateBluetooth()
    }

    private func setupCells() {
        tableView.register(HistoryTableViewCell.self, forCellReuseIdentifier: String(describing: HistoryTableViewCell.self))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return purchases.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: HistoryTableViewCell.self)) as? HistoryTableViewCell {
            let purchase = purchases[indexPath.row]
            cell.titleLabel.text = purchase.store.title
            cell.descriptionLabel.text = "Você comprou \(purchase.products.count) items nesta loja."
            cell.valueLabel.text = "Total da compra: \(formatter.string(from: NSNumber(value: purchase.totalValue))!)"
            return cell
        } else {
            return UITableViewCell()
        }
    }

    private func emulateBluetooth() {

        SVProgressHUD.show(withStatus: "Preparando lojas próximas...")

        let when = DispatchTime.now() + 2 // change 2 to desired number of seconds
        DispatchQueue.main.asyncAfter(deadline: when) {
            SVProgressHUD.showSuccess(withStatus: "Encontramos 4 vendedores próximos")
            SVProgressHUD.dismiss(withDelay: 1.5, completion: { [weak self] in
                self?.performSegue(withIdentifier: "segueToPurchase", sender: nil)
            })
        }
    }
}
