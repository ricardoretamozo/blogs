//
//  IAPManager.swift
//  blogs
//
//  Created by ricardo on 11/20/21.
//  Copyright © 2021 ricardo. All rights reserved.
//

import Foundation
import Purchases

final class IAPManager {
    
    static let shared = IAPManager ()
    
    private init() {}
    
    func isPremium() -> Bool {
         return UserDefaults.standard.bool(forKey: "premium")
    }
    
    public func getSubscriptionStatus(completion: ((Bool) -> Void)?) {
           Purchases.shared.purchaserInfo { info, error in
                guard let entitlements = info?.entitlements,
                    error == nil else {
                    return
            }
            
            if entitlements.all["Premium"]?.isActive == true {
                print("Got updated status of subscribed")
                UserDefaults.standard.set(true, forKey: "premium")
                completion?(true)
            } else {
                print("Got updated status of NOT subscribed")
                UserDefaults.standard.set(false, forKey: "premium")
                completion?(false)
            }
           }
    }
    
    public func fetchPackages(completion: @escaping (Purchases.Package?) -> Void) {
           Purchases.shared.offerings { offerings, error in
               guard let package = offerings?.offering(identifier: "default")?.availablePackages.first,
                     error == nil else {
                   completion(nil)
                   return
               }

               completion(package)
           }
       }
    
     public func subscribe(
           package: Purchases.Package,
           completion: @escaping (Bool) -> Void
       ) {
           guard !isPremium() else {
               print("User already subscribeed")
               completion(true)
               return
           }

        Purchases.shared.purchasePackage(package) { transaction, info, error, userCancelled in
            guard let transaction = transaction,
                  let entitlements = info?.entitlements,
                  error == nil,
                  !userCancelled else {
                return
            }

            switch transaction.transactionState {
            case .purchasing:
                print("purchasing")
            case .purchased:
                print("Purchase: \(entitlements)")
                
                UserDefaults.standard.set(true, forKey: "premium")
            case .failed:
                print("failed")
            case .restored:
                print("restore")
            case .deferred:
                print("defered")
            @unknown default:
                print("default case")
            }
        }
    }
    
    public func restorePurchases(completion: @escaping (Bool) -> Void) {
        Purchases.shared.restoreTransactions { info, error in
            guard let entitlements = info?.entitlements,
                  error == nil else {
                return
            }

            if entitlements.all["Premium"]?.isActive == true {
                print("Restored succss")
                UserDefaults.standard.set(true, forKey: "premium")
                completion(true)
            } else {
                print("Restored failure")
                UserDefaults.standard.set(false, forKey: "premium")
                completion(false)
            }
        }
    }
}
 
