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
    let network: NetworkManager = NetworkManager.sharedInstance
    @IBOutlet weak var HashRateLabel: UILabel!
    @IBOutlet weak var SubmittedLabel: UILabel!
    @IBOutlet weak var NoticeView: UIView!
    @IBOutlet weak var StartStopButton: UIButton!
    @IBOutlet weak var noticeMain: UILabel!
    @IBOutlet weak var NoticeHeader: UILabel!
    @IBOutlet weak var credit: UILabel!
    
    var timerObject = Timer()
    var timeLeft = Int()
    var minerPaused = false
    var isDefaultNoticeView = true
    
    var countdownTimer: Timer!
    // MARK: - Change this value to set the time for the countdown
    var totalTime = 1800
    // MARK: -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkManager.isUnreachable { _ in
            self.showOfflinePage()
        }
        
        credit.text = ""
        
        if delegate.minerRunning {
            pauseMinerWithTimer()
        }
        
        let noticeViewTapped = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        NoticeView.addGestureRecognizer(noticeViewTapped)
        NoticeView.isUserInteractionEnabled = true
        
        view.frame = CGRect(x: 0, y: 0, width: 267, height: 66)
        view.backgroundColor = .white
        self.view = view
        
        noticeMain.textColor = UIColor(red: 0.2, green: 0.23, blue: 0.26, alpha: 1)
        noticeMain.font = UIFont(name: "GillSans-SemiBold", size: 15)
        noticeMain.numberOfLines = 0
        noticeMain.lineBreakMode = .byWordWrapping
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 4
        noticeMain.attributedText = NSMutableAttributedString(string: NSLocalizedString("MindfulTip", comment: ""), attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        
        network.reachability.whenUnreachable = { reachability in
            self.showOfflinePage()
        }
    }
    
    // MARK: - Show the offline view controller
    private func showOfflinePage()
    {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "NetworkUnavailable", sender: self)
        }
    }
    
    // MARK: - Handle a series of actions after the notice board is tapped
    @objc func handleTap(_ sender: UITapGestureRecognizer) {
        if isDefaultNoticeView {
            isDefaultNoticeView = false
            
            if delegate.apiSuccess {
                let quote = delegate.quoteMessage["quote"] as? String
                let author = delegate.quoteMessage["author"] as? String
                let message = quote! + " - " + author!
                noticeMain.text = message
                NoticeHeader.text = delegate.quoteMessage["title"] as? String
                credit.text = NSLocalizedString("QuoteCredit", comment: "")
                UIView.transition(with: NoticeView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
            } else {
                NoticeHeader.text = NSLocalizedString("ApiErrorTitle", comment: "")
                noticeMain.text = NSLocalizedString("ApiErrorDescription", comment: "")
            }
        } else {
            isDefaultNoticeView = true
            credit.text = ""
            noticeMain.text = NSLocalizedString("MindfulTip", comment: "")
            NoticeHeader.text = NSLocalizedString("slogan", comment: "")
            UIView.transition(with: NoticeView, duration: 0.5, options: .transitionFlipFromLeft, animations: nil, completion: nil)
        }
    }
    
    // MARK: - Call these function whenever you want to start or stop a focus session.
    func startMinerWithTimer() {
        if minerPaused {
            startMiner()
            timerObject = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        } else {
            startMiner()
            totalTime = 1800
            timerObject = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
        }
    }
    
    func pauseMinerWithTimer() {
        minerPaused = true
        stopMiner()
        timerObject.invalidate()
    }
    
    // MARK: - Update the time
    @objc func updateTime() {
        if totalTime != 0 {
            if minerPaused != true {
                totalTime -= 1
                SubmittedLabel.text = timeFormatted(totalTime) + NSLocalizedString("TimeRemaining", comment: "")
                timeLeft = totalTime
            }
        } else {
            stopMiner()
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    // MARK: - Start or stop the timer as the user click on the focus button
    @IBAction func miningTriggered(_ sender: Any) {
        switch delegate.minerRunning {
        case true:
            // If the miner is running, stop it
            pauseMinerWithTimer()
        default:
            // If the miner is idling, boot it
            startMinerWithTimer()
        }
    }
    
    // MARK: - Original Start and Stop functions, do NOT call without timer
    
    func stopMiner() {
        delegate.miner.stop()
        UIDevice.current.isProximityMonitoringEnabled = false
        delegate.minerRunning = false
        if minerPaused {
            HashRateLabel.text = NSLocalizedString("pause", comment: "")
            StartStopButton.setTitle(NSLocalizedString("resume", comment: ""), for: .normal)
        }
        //print("Miner paused")
    }
    
    func startMiner() {
        do {
            minerPaused = false
            try delegate.miner.start(threadLimit: 2)
            UIDevice.current.isProximityMonitoringEnabled = true
            HashRateLabel.text = NSLocalizedString("running", comment: "")
            delegate.minerRunning = true
            StartStopButton.setTitle(NSLocalizedString("disrupt", comment: ""), for: .normal)
            //print("Miner started")
        }
        catch {
            // Troubleshoot
            //print("The miner failed to start!")
            //print(error.localizedDescription)
        }
    }
}

extension ViewController: MinerDelegate {
    func miner(updatedStats stats: MinerStats) {
        if stats.hashRate > 0 {
        }
        if totalTime == 0 {
            HashRateLabel.text = NSLocalizedString("awesome", comment: "")
            SubmittedLabel.text = "\(stats.submittedHashes)" + NSLocalizedString("results", comment: "")
        }
    }
}
