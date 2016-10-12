//
//  CPBaseViewController.swift
//  CoolPhotos
//
//  Created by 邓永豪 on 16/8/1.
//  Copyright © 2016年 DYH. All rights reserved.
//

import UIKit

class CPBaseViewController: UIViewController, CPThemeListenerProtocol {

    override func viewDidLoad() {
        super.viewDidLoad()
        //默认背景
        let backgroungView = UIImageView.init(frame: self.view.frame)
        self.view.addSubview(backgroungView)
//        CPThemeManager.shareInstance.CPThemeImage("com_bg_journal01_1242x2208", completionHandler: { (image) in
//            backgroungView.image = image
//        })
        //添加皮肤监听
        CPThemeManager.shareInstance.addThemeListener(object: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    deinit {
        CPThemeManager.shareInstance.removeThemeListener(object: self)
    }
    
    // MARK: - 监听皮肤切换
    func CPThemeDidNeedUpdateStyle() -> Void {
    
    }

}
