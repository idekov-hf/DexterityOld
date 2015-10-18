import Foundation

class MainScene: CCNode {
    
    // code connections
    weak var buttonsNode: CCNode!
    
    // variables
    var screenWidth = CCDirector.sharedDirector().viewSize().width
    var screenHeight = CCDirector.sharedDirector().viewSize().height
    
    var buttonArray: [Button] = []
    
    // called when MainScene is loaded
    func didLoadFromCCB() {
        userInteractionEnabled = true
//        multipleTouchEnabled = true
        generateRandomButton()
    }
    
    // touch functions
    override func touchBegan(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        if  buttonWasPressed(buttonArray[0], t: touch) {
            print("button was pressed")
            buttonArray[0].wasPressed = true
            buttonArray[1].unlocked = true
        }
    }
    
    override func touchEnded(touch: CCTouch!, withEvent event: CCTouchEvent!) {
        let button = buttonArray[0]
        let buttonCenter = buttonArray[0].positionInPoints
        let touchLocation = touch.locationInWorld()
        let radius = button.radius
        
        let right = buttonCenter.x + radius
        let left = buttonCenter.x - radius
        let top = buttonCenter.y + radius
        let bottom = buttonCenter.y - radius
        
        if touchLocation.x < right && touchLocation.x > left && touchLocation.y < top && touchLocation.y > bottom && button.wasPressed {
            generateNewButton()
        }
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
        for i in 1...2 {
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