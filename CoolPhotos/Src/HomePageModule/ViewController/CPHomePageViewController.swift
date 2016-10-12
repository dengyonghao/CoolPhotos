//
//  CPHomePageViewController.swift
//  CoolPhotos
//
//  Created by 邓永豪 on 16/8/3.
//  Copyright © 2016年 DYH. All rights reserved.
//

import UIKit

class CPHomePageViewController: CPBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let themeManager = CPThemeManager.shareInstance
        self.navigationController?.isNavigationBarHidden = true
        let rectStatus = UIApplication.shared.statusBarFrame
        print(rectStatus)
        self.view.backgroundColor = themeManager.CPThemeColor(colorKey: "cp_press_c")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
