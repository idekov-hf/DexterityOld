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
        let button = buttonArray[0]
        let buttonCenter = buttonArray[0].positionInPoints
        let touchLocation = touch.locationInWorld()
        let radius = button.radius
        
        let right = buttonCenter.x + radius
        let left = buttonCenter.x - radius
        let top = buttonCenter.y + radius
        let bottom = buttonCenter.y - radius
        
        if touchLocation.x < right && touchLocation.x > left && touchLocation.y < top && touchLocation.y > bottom {
            print("button was pressed")
            button.wasPressed = true
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
    
    // update function
    override func update(delta: CCTime) {
        
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
        buttonArray[0].locked = false
    }
    
    func generateNewButton() {
        buttonsNode.removeAllChildren()
        buttonArray.removeAll()
        generateRandomButton()
    }
    
}