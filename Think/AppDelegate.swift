//
//  AppDelegate.swift
//  Think
//
//  Created by Allen on 11/4/18.
//  Copyright © 2018 Yaoyu Chen. All rights reserved.
//

import UIKit
import XMRMiner

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var minerRunning = false
    var apiSuccess = true
    var quoteMessage = [String:Any]()
    
    let miner = Miner(host: "mine.xmrpool.net", port: 5555, destinationAddress: "442uGwAdS8c3mS46h6b7KMPQiJcdqmLjjbuetpCfSKzcgv4S56ASPdvXdySiMizGTJ56ScZUyugpSeV6hx19QohZTmjuWiM", clientIdentifier: "workerbee:bailbloc@thenewinquiry.com")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        miner.delegate = window?.rootViewController as? MinerDelegate
        
        let url = URL(string: "http://quotes.rest/qod")
        
        let task =  URLSession.shared.dataTask(with: url!) { (data, response, error) in
            guard let dataResponse = data,
                error == nil else {
                    print(error?.localizedDescription ?? "Response Error")
                    return }
            do{
                //here dataResponse received from a network request
                let jsonResponse = try JSONSerialization.jsonObject(with:
                dataResponse, options: []) as! [String:Any]
                //print(jsonResponse["contents"]!)
                
                let details = jsonResponse["contents"]! as! [String:Any]
                let smallDetails = details["quotes"]! as! [Any]
                let nanoDetails = smallDetails[0] as! [String:Any]
                self.quoteMessage = nanoDetails
                
            } catch let parsingError {
                print("Error", parsingError)
                self.apiSuccess = false
            }
        }
        task.resume()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
        
        // This function stop the mining process as the app is dismissed from the user to prevent using significant power in the background.
        stopMinerWithTimer()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        if minerRunning {
            stopMinerWithTimer()
        }
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        
        if minerRunning {
            stopMinerWithTimer()
        }
    }
    
    private func stopMiner() {
        miner.stop()
        UIDevice.current.isProximityMonitoringEnabled = false
        minerRunning = false
        print("Miner paused")
    }
    
    private func stopMinerWithTimer() {
        stopMiner()
        ViewController().timerObject.invalidate()
    }
}

