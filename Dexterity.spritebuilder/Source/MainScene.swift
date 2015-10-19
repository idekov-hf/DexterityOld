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
    
    override func update(delta: CCTime) {
        if button1.wasPressed {
            button2.unlocked = true
            if button2.wasPressed {
                button3.unlocked = true
                if button3.wasPressed {
                    button1.canBeReleased = true
                }
            }
        }
        else {
            button2.unlocked = false
        }
        
        if button1.canBeReleased && !button1.wasPressed {
            button2.canBeReleased = true
            if button2.canBeReleased && !button2.wasPressed {
                button3.canBeReleased = true
                if button3.canBeReleased && !button3.wasPressed {
                    moveButtons()
                    button1.canBeReleased = false
                }
            }
        }
        
        
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
    
    func moveButtons() {
        for button in buttonArray {
            let randomWidth = CGFloat(arc4random_uniform(UInt32(screenWidth)))
            let randomHeight = CGFloat(arc4random_uniform(UInt32(screenHeight)))
            button.positionInPoints = CGPoint(x: randomWidth, y: randomHeight)
        }
    }
    
    // touch functions
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
//        if  buttonWasPressed(buttonArray[0], t: touch) {
//            print("button1 was pressed")
//            buttonArray[0].wasPressed = true
//            buttonArray[1].unlocked = true
//        }
//        else if buttonWasPressed(buttonArray[1], t: touch) && buttonArray[0].wasPressed {
//            buttonArray[1].wasPressed = true
//            buttonArray[2].unlocked = true
//        }
//        else if buttonWasPressed(buttonArray[2], t: touch) && buttonArray[1].wasPressed {
//            buttonArray[2].wasPressed = true
//            buttonArray[0].canBeReleased = true
//        }
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
//        if buttonWasPressed(buttonArray[0], t: touch) && buttonArray[0].canBeReleased {
//            buttonArray[1].canBeReleased = true
//        }
//        else if buttonWasPressed(buttonArray[1], t: touch) && buttonArray[1].canBeReleased {
//            buttonArray[2].canBeReleased = true
//        }
//        else if buttonWasPressed(buttonArray[2], t: touch) && buttonArray[2].canBeReleased {
//            generateNewButton()
//        }
        
//        let button = buttonArray[0]
//        let buttonCenter = buttonArray[0].positionInPoints
//        let touchLocation = touch.locationInWorld()
//        let radius = button.radius

//        let right = buttonCenter.x + radius
//        let left = buttonCenter.x - radius
//        let top = buttonCenter.y + radius
//        let bottom = buttonCenter.y - radius

//        if touchLocation.x < right && touchLocation.x > left && touchLocation.y < top && touchLocation.y > bottom && button.wasPressed {
//            generateNewButton()
//        }
    }
    
    // take Button and touch objects and returns
    // true: if button is pressed
    // false: if button is not pressed
    func buttonWasPressed(button: Button, t: CCTouch!) -> Bool {
        let buttonCenter = button.positionInPoints
        let touchLocation = t.locationInWorld()
        let radius = button.radius
        
        let right = buttonCenter.x + radius
        let left = buttonCenter.x - radius
        let top = buttonCenter.y + radius
        let bottom = buttonCenter.y - radius

        if touchLocation.x < right && touchLocation.x > left && touchLocation.y < top && touchLocation.y > bottom {
            return true
        }
        
        return false
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