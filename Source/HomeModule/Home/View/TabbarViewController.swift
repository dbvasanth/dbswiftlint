//
//  TabbarViewController.swift
//  Manipal
//
//  Created by DB-MM-034 on 22/09/22.
//

import UIKit

class TabbarViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.selectedIndex = 0
        UITabBar.appearance().tintColor = .clear
        UITabBar.appearance().barTintColor = UIColor.white
    }
    

}
