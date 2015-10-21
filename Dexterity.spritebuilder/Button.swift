//
//  Button.swift
//  Dexterity
//
//  Created by Iavor Dekov on 8/24/15.
//  Copyright (c) 2015 Apportable. All rights reserved.
//

import Foundation

class Button: CCSprite {
    
    weak var numberLabel: CCLabelTTF!
    
    var unlocked: Bool = false
    var wasPressed: Bool = false
    var canBeReleased: Bool = false
    var radius: CGFloat!
    
    var buttonNumber: Int = 0 {
        didSet {
            numberLabel.string = "\(buttonNumber)"
        }
    }
    
//    init(num: Int) {
//        buttonNumber = num
//        super.init()
//    }
    
    override func onEnter() {
        super.onEnter()
        userInteractionEnabled = true
    }
    
    func didLoadFromCCB() {
        scale = 0.5
        radius = contentSize.width / 4
    }
    
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        wasPressed = true
//        print("\(buttonNumber) was pressed")
        
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        wasPressed = false
//        print("\(buttonNumber) was released")
    }
    
}