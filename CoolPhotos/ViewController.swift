//
//  ViewController.swift
//  CoolPhotos
//
//  Created by 邓永豪 on 16/7/29.
//  Copyright © 2016年 DYH. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        CPThemeManager.shareInstance.setThemeStyle(.CPThemeType_BT_BLACK)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

