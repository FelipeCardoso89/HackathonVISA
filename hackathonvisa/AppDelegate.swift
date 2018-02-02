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


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

        let profile = Profile(environment: .sandbox, apiKey: "V9EVGBLW5HHL2BZLDGC121cgH_UFhb6SPZ6FJ3fjxHAk4pCp8")
        profile.datalevel = .summary
        VisaCheckoutSDK.configure(profile: profile)

        FirebaseApp.configure()

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

let product1 = Product(title: "Product1", description: "Product description 1", price: 7.80)
let product2 = Product(title: "Product1", description: "Product description 1", price: 3.30)
let product3 = Product(title: "Product1", description: "Product description 1", price: 5.00)
let product4 = Product(title: "Product1", description: "Product description 1", price: 1.99)
let product5 = Product(title: "Product1", description: "Product description 1", price: 2.00)

let products = [product1, product2, product3, product4, product5]

let store1 = Store(title:"Loja 1", description: "Descrição da loja 2")
let store2 = Store(title:"Loja 1", description: "Descrição da loja 2")
let store3 = Store(title:"Loja 1", description: "Descrição da loja 2")
let store4 = Store(title:"Loja 1", description: "Descrição da loja 2")

let stores: [Store] = [store1, store2, store3, store4]

let purchase1 = Purchase(store: store1, products: products, date: Date(), totalValue: 50.00)
let purchase2 = Purchase(store: store1, products: products, date: Date(), totalValue: 50.00)
let purchase3 = Purchase(store: store1, products: products, date: Date(), totalValue: 50.00)
let purchase4 = Purchase(store: store1, products: products, date: Date(), totalValue: 50.00)

let purchases: [Purchase] = [purchase1, purchase2, purchase3, purchase4]
