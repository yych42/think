//
//  OfflineViewController.swift
//  Think
//
//  Created by Runkai Zhang on 12/22/18.
//  Copyright © 2018 Yaoyu Chen. All rights reserved.
//

import UIKit
class OfflineViewController: UIViewController {
    
    let network = NetworkManager.sharedInstance
    override func viewDidLoad() {
        super.viewDidLoad()
        // If the network is reachable show the main controller
        network.reachability.whenReachable = { _ in
            self.showMainController()
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    private func showMainController() {
        DispatchQueue.main.async {
            self.performSegue(withIdentifier: "MainController", sender: self)
        }
    }
}
