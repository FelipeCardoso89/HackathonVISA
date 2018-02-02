//
//  AppDelegate.swift
//  hackathonvisa
//
//  Created by Felipe Antonio Cardoso on 01/02/2018.
//  Copyright © 2018 Felipe Antonio Cardoso. All rights reserved.
//

import UIKit
import Firebase
import VisaCheckoutSDK
import SVProgressHUD

let formatter = NumberFormatter()

//NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
//NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"pt_BR"];
//[formatter setLocale:locale];
//NSString *formattedOutput = [formatter stringFromNumber:<<MEU NUMERO (NSNumber)>>];

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let profile = Profile(environment: .sandbox, apiKey: "V9EVGBLW5HHL2BZLDGC121cgH_UFhb6SPZ6FJ3fjxHAk4pCp8")
        profile.datalevel = .summary
        VisaCheckoutSDK.configure(profile: profile)

        FirebaseApp.configure()

        SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.clear)
        SVProgressHUD.setDefaultStyle(.dark)

        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "pt_BR")
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
}

let product0 = Product(title: "Lanche Natural", description: "Ingrediente: salada, tomate, maionese e pão integral.", image: UIImage(named: "lanche_natural")!, price: 10.00)
let product1 = Product(title: "Pão Frances", description: "Pão frances quente", image: UIImage(named: "pao-frances")!, price: 0.30)
let product2 = Product(title: "Ovo Caipira", description: "Ovos caipiras direto de minas", image: UIImage(named: "egg")!, price: 4.50)
let product3 = Product(title: "Gatorage - Frutas vermelhas", description: "Gatorage frutas vermelhas - 350ml", image: UIImage(named: "Gatorage")!, price: 8.50)
let product4 = Product(title: "Açucar", description: "Açucar União", image: UIImage(named: "458542")!, price: 3.50)
let product5 = Product(title: "Leite Batavo", description: "Leite integral batavo", image: UIImage(named: "leite_batavo")!, price: 1.99)
let product6 = Product(title: "Mortadela MANA", description: "Mortadela de qualidade", image: UIImage(named: "mortadela")!, price: 2.50)

let products = [product0, product1, product2, product3, product4, product5, product6]

let store1 = Store(title:"Panificadora Alpha", description: "Pão Quentinho a toda hora! Chega mantega derrete!", image: UIImage(named: "panificadora_alfa")!)
let store2 = Store(title:"Já pão", description: "Padaria Já pão tudo bom para o seu café!", image: UIImage(named: "ja_pao")!)
let store3 = Store(title:"Panhoca", description: "Panhaca padaria!", image: UIImage(named: "panhoca")!)
let store4 = Store(title:"Pão center", description: "Padaria que é o centro do pão", image: UIImage(named: "pao_center")!)
let store5 = Store(title:"Rios Delicatassem", description: "Lojas rios, o lugar!", image: UIImage(named: "rios_delicatessen")!)

let stores: [Store] = [store1, store2, store3, store4]

let purchase1 = Purchase(store: store1, products: products, date: Date(), totalValue: 45.0)
let purchase2 = Purchase(store: store2, products: products, date: Date(), totalValue: 17.80)
let purchase3 = Purchase(store: store1, products: products, date: Date(), totalValue: 23.40)

let purchases: [Purchase] = [purchase1, purchase2, purchase3]
