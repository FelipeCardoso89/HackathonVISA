//
//  NearStoresTableViewController.swift
//  hackathonvisa
//
//  Created by Felipe Antonio Cardoso on 01/02/2018.
//  Copyright © 2018 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit

class NearStoresTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    private func setupCells() {
        tableView.register(NearStoreTableViewCell.self, forCellReuseIdentifier: String(describing: NearStoreTableViewCell.self))
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return stores.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: NearStoreTableViewCell.self)) as? NearStoreTableViewCell {
            let store = stores[indexPath.row]
            cell.titleLabel.text = store.title
            cell.descriptionLabel.text = store.description
            cell.iconImageView.image = store.image
            return cell
        } else {
            return UITableViewCell()
        }

    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let store = stores[indexPath.row]
        performSegue(withIdentifier: "segueToProducts", sender: store)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if let viewController = segue.destination as? PurchaseViewController {
            viewController.store = sender as? Store
            viewController.storeProducts = products
        }

    }

    @IBAction func dismiss(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}
