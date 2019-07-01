//
//  AppDelegate.swift
//  MyAverageUSA
//
//  Created by Jonathan  Wesfield on 2017-07-03.
//  Copyright © 2017 Jonathan Wesfield. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import  FirebaseDatabase
import AppsFlyerLib


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate , AppsFlyerTrackerDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        /* AppsFlyer */
        AppsFlyerTracker.shared().appsFlyerDevKey = "aSikdJAsaAJS123ad23"
        AppsFlyerTracker.shared().appleAppID = "123456789"
        AppsFlyerTracker.shared().delegate = self
        AppsFlyerTracker.shared().isDebug = true

        
        // LoadTestData()
        
        FIRApp.configure()
        //FirebaseApp.configure()
        
        ArrayOfSemestersFromDictionary()
        
        if let dic = UserDefaults.standard.dictionary(forKey: "GPADictionary"){
            print(dic)
            GPAWeights = GPAConversion.DictionaryToGPAConversions(i_GPADictionary: dic as! Dictionary<String, Float>)
        } else {
            GPAWeights = GPAConversion(standard: "standard")
        }
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        UserDefaults.standard.setValue(GPAWeights.GPAWeightsToDictionary(), forKeyPath: "GPADictionary")
          UserDefaults.standard.set(SemesterListToDictionary(), forKey: "SemesterDictionary")
        
        let DBBASE = FIRDatabase.database().reference()
        if let device_id = UIDevice.current.identifierForVendor?.uuidString{
            print("Device ID \(String(describing: device_id))")
            DBBASE.child(device_id).setValue(SemesterListToDictionary())
        }
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        /* AppsFlyer */
        AppsFlyerTracker.shared().trackAppLaunch()
    }

    func applicationWillTerminate(_ application: UIApplication) {
       
          UserDefaults.standard.setValue(GPAWeights.GPAWeightsToDictionary(), forKeyPath: "GPADictionary")
        
          UserDefaults.standard.set(SemesterListToDictionary(), forKey: "SemesterDictionary")
        
      
        let DBBASE = FIRDatabase.database().reference()
        if let device_id = UIDevice.current.identifierForVendor?.uuidString{
            print("Device ID \(String(describing: device_id))")
            DBBASE.child(device_id).setValue(SemesterListToDictionary())
        }
        
        
        self.saveContext()
    }
    
     /** AppsFlyer **/
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        AppsFlyerTracker.shared().handlePushNotification(userInfo)
    }
    
    
    // Reports app open from a Universal Link for iOS 9 or later
    func application(_ application: UIApplication, continue userActivity: NSUserActivity, restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        AppsFlyerTracker.shared().continue(userActivity, restorationHandler: restorationHandler)
        return true
    }
    
    // Reports app open from deep link from apps which do not support Universal Links (Twitter) and for iOS8 and below
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        AppsFlyerTracker.shared().handleOpen(url, sourceApplication: sourceApplication, withAnnotation: annotation)
        return true
    }
    
    // Reports app open from deep link for iOS 10 or later
    func application(_ app: UIApplication, open url: URL, options: [UIApplicationOpenURLOptionsKey : Any] = [:]) -> Bool {
        AppsFlyerTracker.shared().handleOpen(url, options: options)
        return true
    }
    
    func onConversionDataReceived(_ installData: [AnyHashable : Any]!) {
        if let data = installData{
            print("\(data)")
            if let status = data["af_status"] as? String{
                if(status == "Non-organic"){
                    if let sourceID = data["media_source"] , let campaign = data["campaign"]{
                        print("This is a Non-Organic install. Media source: \(sourceID)  Campaign: \(campaign)")
                    }
                } else {
                    print("This is an organic install.")
                }
            }
        }
    }
    
    func onConversionDataRequestFailure(_ error: Error!) {
        if let err = error{
            print(err)
        }
    }
    
    func onAppOpenAttribution(_ attributionData: [AnyHashable : Any]!) {
        if let data = attributionData{
            print("\(data)")
        }
    }
    
    func onAppOpenAttributionFailure(_ error: Error!) {
        if let err = error{
            print(err)
        }
    }
    
    /** AppsFlyer End **/

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "MyAverageUSA")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

