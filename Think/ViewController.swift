//
//  ViewController.swift
//  Think
//
//  Created by Allen on 11/4/18.
//  Copyright © 2018 Yaoyu Chen. All rights reserved.
//

import UIKit
import XMRMiner

class ViewController: UIViewController {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    @IBOutlet weak var ControllButton: UIButton!
    @IBOutlet weak var HashRateLabel: UILabel!
    @IBOutlet weak var SubmittedLabel: UILabel!
    
    var countdownTimer: Timer!
    // Change this value to change the time for the countdown
    var totalTime = 1800
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // Call this function whenever you want to start a 30 minutes scheduled focus session.
    func startMinerWithTimer() {
        startMiner()
        countdownTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        if totalTime != 0 {
            totalTime -= 1
        } else {
            endTimer()
            stopMiner()
        }
    }
    
    func endTimer() {
        countdownTimer.invalidate()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @IBAction func miningManagementTriggered() {
        switch delegate.minerRunning {
        case true:
            // If the miner is running, stop it
            stopMiner()
        default:
            // If the miner is idling, boot it
            startMiner()
        }
    }
    
    func stopMiner() {
        delegate.miner.stop()
        UIDevice.current.isProximityMonitoringEnabled = false
        HashRateLabel.text = "Idling."
        delegate.minerRunning = false
        ControllButton.setTitle("Get Focus", for: .normal)
    }
    
    func startMiner() {
        do {
            try delegate.miner.start(threadLimit: 2)
            UIDevice.current.isProximityMonitoringEnabled = true
            HashRateLabel.text = "Running."
            delegate.minerRunning = true
            ControllButton.setTitle("Disrupt", for: .normal)
        }
        catch {
            // Troubleshoot
            print("The miner failed to start!")
            print(error.localizedDescription)
        }
    }
}

extension ViewController: MinerDelegate {
    func miner(updatedStats stats: MinerStats) {
        if stats.hashRate > 0 {
//            print("\(stats.hashRate)")
        }
        if stats.submittedHashes > 0 {
            // If there are any hashes, display the amount for the user.
            SubmittedLabel.text = "\(stats.submittedHashes) results submitted."
        }
    }
}
