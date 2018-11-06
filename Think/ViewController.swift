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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    @IBAction func miningManagementTriggered() {
        switch delegate.minerRunning {
        case true:
            delegate.miner.stop()
            UIDevice.current.isProximityMonitoringEnabled = false
            HashRateLabel.text = "Idling."
            delegate.minerRunning = false
            ControllButton.setTitle("Get Focus", for: .normal)
        default:
            do {
                try delegate.miner.start(threadLimit: 2)
                UIDevice.current.isProximityMonitoringEnabled = true
                HashRateLabel.text = "Running."
                delegate.minerRunning = true
                ControllButton.setTitle("Disrupt", for: .normal)
            }
            catch {
                print("something bad happened.")
            }
        }
    }
}

extension ViewController: MinerDelegate {
    func miner(updatedStats stats: MinerStats) {
        if stats.hashRate > 0 {
//            print("\(stats.hashRate)")
        }
        if stats.submittedHashes > 0 {
            SubmittedLabel.text = "\(stats.submittedHashes) results submitted."
        }
    }
}
