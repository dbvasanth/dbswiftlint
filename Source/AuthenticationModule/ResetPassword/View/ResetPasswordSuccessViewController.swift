//
//  ResetPasswordSuccessViewController.swift
//  Manipal
//
//  Created by DB-MM-034 on 21/09/22.
//

import UIKit

class ResetPasswordSuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnLoginTapped(_ sender: UIButton) {
        if #available(iOS 13.0, *) {
            Constants.sceneDelegate?.navigationToScreen(identifier: Screen.LOGINVIEWCONTROLLER, storyboard: Storyboard.main)
        } else {
            // Fallback on earlier versions
            Constants.appDelegate?.navigationToScreen(identifier: Screen.LOGINVIEWCONTROLLER, storyboard: Storyboard.main)
        }
    }
}
