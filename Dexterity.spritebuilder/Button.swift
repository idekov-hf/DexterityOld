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
    var radius: CGFloat!
    
    var buttonNumber: Int = 0 {
        didSet {
            numberLabel.string = "\(buttonNumber)"
        }
    }
    
    func didLoadFromCCB() {
        scale = 0.5
        radius = contentSize.width / 4
    }
    
}