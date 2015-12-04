import Foundation

class MainScene: CCNode {
    
    // code connections
    weak var buttonsNode: CCNode!
    
    // variables
    var screenWidth = CCDirector.sharedDirector().viewSize().width
    var screenHeight = CCDirector.sharedDirector().viewSize().height
    
    var buttonArray: [Button] = []
    
    var button1 = CCBReader.load("Button") as! Button
    var button2 = CCBReader.load("Button") as! Button
    var button3 = CCBReader.load("Button") as! Button
    
    // called when MainScene is loaded
    func didLoadFromCCB() {
        userInteractionEnabled = true
        multipleTouchEnabled = true
//        generateRandomButton()
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
            let randomWidth = CGFloat(arc4random_uniform(UInt32(screenWidth)))
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
            print(delta)
        }
        
        if button1.canBeReleased && !button1.wasPressed && button2.wasPressed && button3.wasPressed {
            button2.canBeReleased = true
        }
        if button2.canBeReleased && !button2.wasPressed && button3.wasPressed && !button1.wasPressed {
            button3.canBeReleased = true
        }
        if button3.canBeReleased && !button3.wasPressed {
            moveButtons()
            button1.canBeReleased = false
            button2.canBeReleased = false
            button3.canBeReleased = false
        }
        
        
    }
    
    func moveButtons() {
        for button in buttonArray {
            let randomWidth = CGFloat(arc4random_uniform(UInt32(screenWidth)))
            let randomHeight = CGFloat(arc4random_uniform(UInt32(screenHeight)))
            button.positionInPoints = CGPoint(x: randomWidth, y: randomHeight)
        }
    }
    
    // touch functions
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        
    }
    
    func generateRandomButton() {
        for i in 1...3 {
            let newButton = CCBReader.load("Button") as! Button
            newButton.buttonNumber = i
            let randomWidth = CGFloat(arc4random_uniform(UInt32(screenWidth)))
            let randomHeight = CGFloat(arc4random_uniform(UInt32(screenHeight)))
            newButton.positionInPoints = CGPoint(x: randomWidth, y: randomHeight)
            buttonsNode.addChild(newButton)
            buttonArray.append(newButton)
        }
        buttonArray[0].unlocked = true
    }
    
    func generateNewButton() {
        buttonsNode.removeAllChildren()
        buttonArray.removeAll()
        generateRandomButton()
    }
    
}