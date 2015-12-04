//
//  MainScene.swift
//  Dexterity
//
//  Created by Iavor Dekov on 12/3/15.
//  Copyright © 2015 Apportable. All rights reserved.
//

import Foundation

class MainScene: CCNode {
    
    // code connections
    weak var buttonsNode: CCNode!
    weak var scoreLabel: CCLabelTTF!
    
    // variables
    var screenWidth = CCDirector.sharedDirector().viewSize().width
    var screenHeight = CCDirector.sharedDirector().viewSize().height
    
    var buttonArray: [Button] = []
    
    var button1 = CCBReader.load("Button") as! Button
    var button2 = CCBReader.load("Button") as! Button
    var button3 = CCBReader.load("Button") as! Button
    
    var score: Int = 0 {
        didSet {
            scoreLabel.string = "\(score)"
        }
    }
    
    // called when MainScene is loaded
    func didLoadFromCCB() {
        userInteractionEnabled = true
        multipleTouchEnabled = true
        setupButtons()
    }
    
    func setupButtons() {
        button1.buttonNumber = 1
        button2.buttonNumber = 2
        button3.buttonNumber = 3
        button1.unlocked = true
        buttonArray.append(button1)
        buttonArray.append(button2)
        buttonArray.append(button3)
        for button in buttonArray {
            let randomWidth = CGFloat(arc4random_uniform(UInt32(screenWidth - button1.contentSize.width)) + UInt32(button1.contentSize.width))
            let randomHeight = CGFloat(arc4random_uniform(UInt32(screenHeight)))
            button.positionInPoints = CGPoint(x: randomWidth, y: randomHeight)
            buttonsNode.addChild(button)
        }
    }
    
    override func update(delta: CCTime) {
        if button1.wasPressed {
            button2.unlocked = true
        }
        else {
            button2.unlocked = false
        }
        if button2.unlocked && button2.wasPressed {
            button3.unlocked = true
        }
        else {
            button3.unlocked = false
        }
        if button3.unlocked && button3.wasPressed {
            button1.canBeReleased = true
//            print(delta)
        }
        
        if !button1.wasPressed && !button2.wasPressed && !button3.wasPressed {
            button1.canBeReleased = false
        }
        
        if button1.canBeReleased && !button1.wasPressed && button2.wasPressed && button3.wasPressed {
            button2.canBeReleased = true
        }
        if button2.canBeReleased && !button2.wasPressed && button3.wasPressed && !button1.wasPressed {
            button3.canBeReleased = true
        }
        if button3.canBeReleased && !button3.wasPressed {
            increaseScore()
            moveButtons()
            button1.canBeReleased = false
            button2.canBeReleased = false
            button3.canBeReleased = false
        }
    }
    
    func increaseScore() {
        score++
        animationManager.runAnimationsForSequenceNamed("score")
    }
    
    func moveButtons() {
        let lower : UInt32 = 0 // UInt32(button1.contentSizeInPoints.width / 2)
        let upper : UInt32 = UInt32(screenWidth) // UInt32(screenWidth - button1.contentSizeInPoints.width / 2)
        for button in buttonArray {
            let randomWidth = CGFloat(arc4random_uniform(upper - lower) + lower)
            let randomHeight = CGFloat(arc4random_uniform(UInt32(screenHeight)))
            button.positionInPoints = CGPoint(x: randomWidth, y: randomHeight)
        }
    }
    
}
