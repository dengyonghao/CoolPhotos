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
        CPThemeManager.shareInstance
        self.navigationController?.navigationBarHidden = true
        let rectStatus = UIApplication.sharedApplication().statusBarFrame
        print(rectStatus)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
