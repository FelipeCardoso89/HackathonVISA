//
//  PurchaseViewController.swift
//  hackathonvisa
//
//  Created by Felipe Antonio Cardoso on 01/02/2018.
//  Copyright © 2018 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import VisaCheckoutSDK


enum PurchaseViewControllerSections {
    case products(products: [Product])
    case cart(products: [CartProduct])

    var title: String {
        switch self {
        case .products:
            return "Outros produtos"
        case .cart:
            return "Seu carrinho de compras"
        }
    }
}

class CartProduct {

    let product: Product
    var quantity: Int = 1

    init(product: Product) {
        self.product = product
        self.quantity = 1
    }

}

class PurchaseViewController: UIViewController {

    @IBOutlet weak var btnPay: VisaCheckoutButton!
    @IBOutlet weak var totalValueLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!

    var store: Store?

    var storeProducts = [Product]() {
        didSet { update() }
    }

    var cartProducts = [CartProduct](){
        didSet { update() }
    }

    var sum: Double {
        return cartProducts.map({ Double($0.quantity) * $0.product.price }).reduce(0, {  $0 + $1 })
    }

    var purchaseInfo: PurchaseInfo {
        let purchaseInfo = PurchaseInfo(total: CurrencyAmount(double: sum), currency: .brl)
        purchaseInfo.reviewAction = .pay
        purchaseInfo.id
        return purchaseInfo
    }

    private var sections = [PurchaseViewControllerSections]()

    override func viewDidLoad() {
        super.viewDidLoad()

        title = store?.title

        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44.0


        update()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

    }

    private func update() {
        sections = [.cart(products: cartProducts), .products(products: storeProducts)]
    }

    private func updateCart() {
        totalValueLabel.text = formatter.string(from: NSNumber(value: sum))

        btnPay.onCheckout(purchaseInfo: purchaseInfo) { [weak self] result in
            switch result.statusCode {
            case .success:
                print("Encrypted key: \(result.encryptedKey ?? "DEU RUIM")")
                print("Payment data: \(result.encryptedPaymentData ?? "DEU RUIM")")
                
                self?.performSegue(withIdentifier: "segueToConfirmation", sender: nil)
            case .userCancelled:
                print("Payment cancelled by the user")
            default:
                break
            }
        }
    }

}

extension PurchaseViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch  sections[section] {
        case let .cart(products):

            if products.count > 0 {
                return products.count
            } else {
                return 1
            }

        case let .products(products):
            return products.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: ProductTableViewCell.self)) as? ProductTableViewCell else {
            return UITableViewCell()
        }

        switch sections[indexPath.section] {
        case let .cart(products):

            guard products.count > 0 else {
                return UITableViewCell()
            }

            let product = products[indexPath.row]

            cell.delegate = self
            cell.showStepper()
            cell.counterLabel.text = "x\(product.quantity)"
            cell.stepper.tag = (1000 + indexPath.row)
            cell.stepper.value = Double(product.quantity)
            cell.iconImageView.image = product.product.image
            cell.titleLabel.text = product.product.title
            cell.decriptionLabel.text = product.product.description
            cell.priceLabel.text = formatter.string(from: NSNumber(value: product.product.price))

        case let .products(products):

            let product = products[indexPath.row]

            cell.hideStepper()
            cell.iconImageView.image = product.image
            cell.titleLabel.text = product.title
            cell.decriptionLabel.text = product.description
            cell.priceLabel.text = formatter.string(from: NSNumber(value: product.price))
        }
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        switch sections[indexPath.section] {
        case .products:
            cartProducts.append(CartProduct(product: storeProducts.remove(at: indexPath.row)))
            tableView.reloadData()
            updateCart()
        default:
            break
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {

        switch editingStyle {
        case .delete:
            storeProducts.append(cartProducts.remove(at:  indexPath.row).product)
            tableView.reloadData()
            updateCart()
        default:
            break
        }
    }
}

extension PurchaseViewController: ProductTableViewCellDelegate {

    func didSetStepper(at indexPath: IndexPath, to count: Int) {
        switch sections[indexPath.section] {
        case let .cart(products):
            if count <= 0 {
                storeProducts.append(cartProducts.remove(at:  indexPath.row).product)
                tableView.reloadData()
                updateCart()
            } else {
                products[indexPath.row].quantity = count
                updateCart()
            }

        default:
            break
        }
    }
}
