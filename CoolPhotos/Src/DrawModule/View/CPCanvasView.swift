//
//  CPCanvasView.swift
//  CoolPhotos
//
//  Created by deng on 16/8/25.
//  Copyright © 2016年 DYH. All rights reserved.
//

import UIKit

class CPCanvasView: UIView, UIGestureRecognizerDelegate {
    
    private var scale: Float = 1.0

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.isMultipleTouchEnabled = true
        self.contentMode = .center
        self.contentScaleFactor = UIScreen.main.scale;
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.isExclusiveTouch = true
        self.isOpaque = true
        self.backgroundColor = UIColor.white
        
        configureGestures()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureGestures()  {
        // Create a long press recognizer to auto-activate the eyedropper tool
        let longPress = UILongPressGestureRecognizer.init(target: self, action: #selector(self.longPress(gestureRecognizer:)))
        longPress.minimumPressDuration = 0.5;
        longPress.delegate = self
        self.addGestureRecognizer(longPress)
        
        // Create a two finger tap double tap recognizer to auto-fit the doc
        let twoFingerToDoubleTap = UITapGestureRecognizer.init(target: self, action: #selector(self.twoFingerDoubleTap(gestureRecognizer:)))
        twoFingerToDoubleTap.numberOfTouchesRequired = 2;
        twoFingerToDoubleTap.delegate = self;
        self.addGestureRecognizer(twoFingerToDoubleTap)
        
        // Create a two finger tap recognizer to auto-hide the interface
        let twoFingerToTap = UITapGestureRecognizer.init(target: self, action: #selector(self.twoFingerTap(gestureRecognizer:)))
        twoFingerToTap.numberOfTouchesRequired = 2;
        twoFingerToTap.delegate = self;
        twoFingerToTap.require(toFail: twoFingerToDoubleTap)
        self.addGestureRecognizer(twoFingerToTap)
        
        // create a one finger tap to auto-hide or paint a dot
        let oneFingerToTap = UITapGestureRecognizer.init(target: self, action: #selector(self.oneFingerTap(gestureRecognizer:)))
        oneFingerToTap.numberOfTouchesRequired = 1;
        oneFingerToTap.delegate = self;
        self.addGestureRecognizer(oneFingerToTap)
        
        // Create a pinch recognizer to scale the canvas
        let pinchGesture = UIPinchGestureRecognizer.init(target: self, action: #selector(self.handlePinchGesture(gestureRecognizer:)))
        pinchGesture.delegate = self;
        self.addGestureRecognizer(pinchGesture)
       
    }
    
    func longPress(gestureRecognizer: UIGestureRecognizer)  {
        
    }
    
    func twoFingerDoubleTap(gestureRecognizer: UIGestureRecognizer)  {
        
    }
    
    func twoFingerTap(gestureRecognizer: UIGestureRecognizer)  {
        
    }
    
    func oneFingerTap(gestureRecognizer: UIGestureRecognizer)  {
        
    }
    
    func handlePinchGesture(gestureRecognizer: UIGestureRecognizer)  {
        
    }

}
