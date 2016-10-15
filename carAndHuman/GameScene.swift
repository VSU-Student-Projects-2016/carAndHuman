//
//  GameScene.swift
//  carAndHuman
//
//  Created by xcode on 08.10.16.
//  Copyright © 2016 VSU. All rights reserved.
//



import SpriteKit
import GameplayKit


let carCategory: UInt32 = 1 << 0
let worldCategory: UInt32 = 1 << 1
let pipeCategory: UInt32 = 1 << 2
let scoreCategory: UInt32 = 1 << 3
let circleCategory: UInt32 = 1 << 4
let armCategory: UInt32 = 1 << 5
let legCategory: UInt32 = 1 << 6
let headCategory: UInt32 = 1 << 7


class Human: SKNode {
    let Circle2 = SKShapeNode(circleOfRadius:30)
    let leg1 = SKShapeNode(ellipseOf: CGSize(width: 70, height: 25))
    let leg2 = SKShapeNode(ellipseOf: CGSize(width: 70, height: 25))
    let arm1 = SKShapeNode(ellipseOf: CGSize(width: 70, height: 25))
    let arm2 = SKShapeNode(ellipseOf: CGSize(width: 70, height: 25))
    let  Circle = SKShapeNode(circleOfRadius:20)

    var man = SKPhysicsJointFixed()
    var man1 = SKPhysicsJointFixed()
    var man2 = SKPhysicsJointFixed()
    var man3 = SKPhysicsJointFixed()
    var man4 = SKPhysicsJointFixed()
    var man5 = SKPhysicsJointSpring()
    
    init(pos: CGPoint) {
        super.init()
        Circle2.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        Circle2.physicsBody?.isDynamic = true
        Circle2.physicsBody?.categoryBitMask = circleCategory
        Circle2.physicsBody?.collisionBitMask =  worldCategory
        Circle2.physicsBody?.contactTestBitMask = worldCategory
        Circle2.fillColor = SKColor.red
        Circle2.position = CGPoint (x: pos.x - 30, y: pos.y)
        addChild(Circle2)
        
        leg1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 60, height: 20))
        leg1.physicsBody?.isDynamic = true
        leg1.physicsBody?.categoryBitMask = legCategory
        leg1.physicsBody?.collisionBitMask =  worldCategory
        leg1.physicsBody?.contactTestBitMask = worldCategory
        leg1.fillColor = SKColor.red
        leg1.position = CGPoint (x: pos.x - 80 , y: pos.y - 20)
        addChild(leg1)
        
        
        leg2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 20))
        leg2.physicsBody?.isDynamic = true
        leg2.physicsBody?.categoryBitMask = legCategory
        leg2.physicsBody?.collisionBitMask =  worldCategory
        leg2.physicsBody?.contactTestBitMask = worldCategory
        leg2.fillColor = SKColor.red
        leg2.position = CGPoint (x: pos.x - 80 , y: pos.y + 20)
        addChild(leg2)
        
        
        arm1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 20))
        arm1.physicsBody?.isDynamic = true
        arm1.physicsBody?.categoryBitMask = armCategory
        arm1.physicsBody?.collisionBitMask =  worldCategory
        arm1.physicsBody?.contactTestBitMask = worldCategory
        arm1.fillColor = SKColor.red
        arm1.position = CGPoint (x: pos.x + 40 , y: pos.y - 20)
        addChild(arm1)
        
        
        arm2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 20))
        arm2.physicsBody?.isDynamic = true
        arm2.physicsBody?.categoryBitMask = armCategory
        arm2.physicsBody?.collisionBitMask =  worldCategory
        arm2.physicsBody?.contactTestBitMask = worldCategory
        arm2.fillColor = SKColor.red
        arm2.position = CGPoint (x: pos.x + 40 , y: pos.y + 20)
        addChild(arm2)
        
        Circle.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        Circle.physicsBody?.isDynamic = true
        
        Circle.physicsBody?.categoryBitMask = headCategory
        Circle.physicsBody?.collisionBitMask =  worldCategory
        Circle.physicsBody?.contactTestBitMask = worldCategory
        Circle.fillColor = SKColor.red
        Circle.position = pos
        addChild(Circle)
        
        man = SKPhysicsJointFixed.joint(withBodyA: Circle.physicsBody!, bodyB: Circle2.physicsBody!, anchor: CGPoint (x: pos.x - 20, y: pos.y))
        man1 = SKPhysicsJointFixed.joint(withBodyA: Circle2.physicsBody!, bodyB: leg1.physicsBody!, anchor: CGPoint(x: pos.x - 45, y: pos.y + 20))
        man2 = SKPhysicsJointFixed.joint(withBodyA: Circle2.physicsBody!, bodyB: leg2.physicsBody!, anchor: CGPoint(x: pos.x - 45, y: pos.y + 20))
        //let man3 = SKPhysicsJointFixed.joint(withBodyA: Circle2.physicsBody!, bodyB: arm1.physicsBody!, anchor: CGPoint(x: bird.position.x - 45, y: bird.position.y + 20))
        man4 = SKPhysicsJointFixed.joint(withBodyA: Circle2.physicsBody!, bodyB: arm2.physicsBody!, anchor: CGPoint(x: pos.x - 45, y: pos.y + 20))
        man5 = SKPhysicsJointSpring.joint(withBodyA: Circle2.physicsBody!, bodyB: arm1.physicsBody!, anchorA: CGPoint(x: pos.x - 5 , y: pos.y + 5), anchorB: CGPoint(x: pos.x  , y: pos.y ))
    }
    
    func add(to scene: SKScene) {
        scene.addChild(self)
        scene.physicsWorld.add(man)
        scene.physicsWorld.add(man1)
        scene.physicsWorld.add(man2)
        scene.physicsWorld.add(man4)
        scene.physicsWorld.add(man5)
    }
    
    func impulse(force: CGFloat){
        Circle2.physicsBody?.applyImpulse(CGVector(dx: force * 25,dy: force * 25))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Car: SKNode{
    

    //let bodyCar = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: 120.0, height: 40.0))
    let bodyCar = SKShapeNode(rectOf: CGSize(width: 120.0, height: 40.0))
    let circle1 = SKShapeNode(circleOfRadius:20)
    let circle2 = SKShapeNode(circleOfRadius:20)
    var pinCircle1 = SKPhysicsJointPin()
    var pinCircle2 = SKPhysicsJointPin()
    var pinCircle1Fix = SKPhysicsJointFixed()
    var pinCircle2Fix = SKPhysicsJointFixed()

    
     override init() {
        super.init()


        bodyCar.physicsBody = SKPhysicsBody(rectangleOf: bodyCar.frame.size)
        bodyCar.physicsBody?.categoryBitMask = carCategory
        bodyCar.physicsBody?.collisionBitMask =  worldCategory
        bodyCar.physicsBody?.contactTestBitMask = worldCategory
        bodyCar.physicsBody?.isDynamic = true
        bodyCar.fillColor = SKColor.yellow
        
        addChild(bodyCar)
        
        circle1.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        circle1.fillColor = SKColor.black
        circle1.physicsBody?.categoryBitMask = circleCategory
        circle1.physicsBody?.collisionBitMask =  worldCategory
        circle1.physicsBody?.contactTestBitMask = worldCategory | carCategory
        circle1.physicsBody?.isDynamic = true
        
        addChild(circle1)
        
        circle2.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        circle2.fillColor = SKColor.black
        circle2.physicsBody?.categoryBitMask = circleCategory
        circle2.physicsBody?.collisionBitMask =  worldCategory
        circle2.physicsBody?.contactTestBitMask = worldCategory | carCategory
        circle2.physicsBody?.isDynamic = true
        
        addChild(circle2)
        
        //pinCircle1 = SKPhysicsJointPin.joint(withBodyA: bodyCar.physicsBody!, bodyB: circle1.physicsBody!, anchor: CGPoint (x: bodyCar.position.x - 40, y: bodyCar.position.y-10))
        //pinCircle2 = SKPhysicsJointPin.joint(withBodyA: bodyCar.physicsBody!, bodyB: circle2.physicsBody!, anchor: CGPoint (x: bodyCar.position.x + 40, y: bodyCar.position.y-10))
        pinCircle1Fix = SKPhysicsJointFixed.joint(withBodyA: bodyCar.physicsBody!, bodyB: circle1.physicsBody!, anchor: CGPoint (x: bodyCar.position.x - 40, y: bodyCar.position.y-10))
        pinCircle2Fix = SKPhysicsJointFixed.joint(withBodyA: bodyCar.physicsBody!, bodyB: circle2.physicsBody!, anchor: CGPoint (x: bodyCar.position.x + 40, y: bodyCar.position.y-10))
        
      
        

    }
    
    func add(to scene: SKScene) {
        bodyCar.position = CGPoint(x: scene.frame.width * 0.55, y: scene.frame.height * 0.6)
        circle1.position = CGPoint(x: bodyCar.position.x - 40, y: bodyCar.position.y-10)
        circle2.position = CGPoint(x: bodyCar.position.x + 40, y: bodyCar.position.y-10)
        
        scene.addChild(self)
        //scene.physicsWorld.add(pinCircle1)
        //scene.physicsWorld.add(pinCircle2)
        scene.physicsWorld.add(pinCircle1Fix)
        scene.physicsWorld.add(pinCircle2Fix)
        
        
    }
    
    
    func run (speed: CGFloat){
        circle1.physicsBody?.applyTorque(speed)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    let verticalPipeGap = 150.0
    
    var cam:SKCameraNode!
    var car:SKSpriteNode!
    var skyColor:SKColor!
    var pipeTextureUp:SKTexture!
    var pipes:SKNode!
    var moving:SKNode!
    var canRestart = Bool()
    var movePipesAndRemove:SKAction!
    var pipeTextureDown:SKTexture!
 
    var isTouch = false
    let myNewCar = Car()

    
    override func didMove(to view: SKView) {
        
        canRestart = false
        
        // setup physics
        self.physicsWorld.gravity = CGVector( dx: 0.0, dy: -5.0 )
        self.physicsWorld.contactDelegate = self
        
        // setup background color
        skyColor = SKColor(red: 81.0/255.0, green: 192.0/255.0, blue: 201.0/255.0, alpha: 1.0)
        self.backgroundColor = skyColor
        
        moving = SKNode()
        self.addChild(moving)
        pipes = SKNode()
        moving.addChild(pipes)
        moving.speed = 0.0;
        
        
        
        
        // ground
        let groundTexture = SKTexture(imageNamed: "land")
        groundTexture.filteringMode = .nearest // shorter form for SKTextureFilteringMode.Nearest
        
        let moveGroundSprite = SKAction.moveBy(x: -groundTexture.size().width * 2.0, y: 0, duration: TimeInterval(0.02 * groundTexture.size().width * 2.0))
        let resetGroundSprite = SKAction.moveBy(x: groundTexture.size().width * 2.0, y: 0, duration: 0.0)
        let moveGroundSpritesForever = SKAction.repeatForever(SKAction.sequence([moveGroundSprite,resetGroundSprite]))
        
        for i:CGFloat in stride(from: 0.0, through: 2.0 + self.frame.size.width / ( groundTexture.size().width * 2.0 ),by:1.0) {
            let sprite = SKSpriteNode(texture: groundTexture)
            sprite.setScale(2.0)
            sprite.position = CGPoint(x: i * sprite.size.width, y: sprite.size.height / 2.0)
            sprite.run(moveGroundSpritesForever)
            moving.addChild(sprite)
        }
        
        // skyline
        let skyTexture = SKTexture(imageNamed: "sky")
        skyTexture.filteringMode = .nearest
        
        let moveSkySprite = SKAction.moveBy(x: -skyTexture.size().width * 2.0, y: 0, duration: TimeInterval(0.1 * skyTexture.size().width * 2.0))
        let resetSkySprite = SKAction.moveBy(x: skyTexture.size().width * 2.0, y: 0, duration: 0.0)
        let moveSkySpritesForever = SKAction.repeatForever(SKAction.sequence([moveSkySprite,resetSkySprite]))
        
        for i:CGFloat in stride(from:0.0, through: 2.0 + self.frame.size.width / ( skyTexture.size().width * 2.0 ),by:1.0) {
            let sprite = SKSpriteNode(texture: skyTexture)
            sprite.setScale(2.0)
            sprite.zPosition = -20
            sprite.position = CGPoint(x: i * sprite.size.width, y: sprite.size.height / 2.0 + groundTexture.size().height * 2.0)
            sprite.run(moveSkySpritesForever)
            moving.addChild(sprite)
        }
        
        // create the pipes textures
        pipeTextureUp = SKTexture(imageNamed: "PipeUp")
        pipeTextureUp.filteringMode = .nearest
        pipeTextureDown = SKTexture(imageNamed: "PipeDown")
        pipeTextureDown.filteringMode = .nearest
        
        // create the pipes movement actions
        let distanceToMove = CGFloat(self.frame.size.width + 2.0 * pipeTextureUp.size().width)
        let movePipes = SKAction.moveBy(x: -distanceToMove, y:0.0, duration:TimeInterval(0.01 * distanceToMove))
        let removePipes = SKAction.removeFromParent()
        movePipesAndRemove = SKAction.sequence([movePipes, removePipes])
        
        // spawn the pipes
        let spawn = SKAction.run({() in self.spawnPipes()})
        let delay = SKAction.wait(forDuration: TimeInterval(2.0))
        let spawnThenDelay = SKAction.sequence([spawn, delay])
        let spawnThenDelayForever = SKAction.repeatForever(spawnThenDelay)
        self.run(spawnThenDelayForever)
        
       // setup our bird
        let carTexture1 = SKTexture(imageNamed: "bird-01")
        carTexture1.filteringMode = .nearest
        car = SKSpriteNode(texture: carTexture1)
        car.setScale(2.0)
        car.position = CGPoint(x: self.frame.size.width * 0.35, y:self.frame.size.height * 0.6)
        //car.run(flap)
        
        
        car.physicsBody = SKPhysicsBody(circleOfRadius: car.size.height / 2.0)
        car.physicsBody?.isDynamic = true
        car.physicsBody?.allowsRotation = false
        
        car.physicsBody?.categoryBitMask = carCategory
        car.physicsBody?.collisionBitMask = worldCategory //| pipeCategory
        car.physicsBody?.contactTestBitMask = pipeCategory
        self.addChild(car)
        
        // create the ground
        let ground = SKNode()
        ground.position = CGPoint(x: 0, y: groundTexture.size().height)
        ground.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.size.width + 1000, height: groundTexture.size().height * 2.0))
        ground.physicsBody?.isDynamic = false
        ground.physicsBody?.categoryBitMask = worldCategory
        self.addChild(ground)

        //create camera
        cam = SKCameraNode()
        //cam.setScale(CGFloat())//the scale sets the zoom level of the camera on the given position
        self.camera = cam //set the scene's camera to reference cam
        self.addChild(cam) //make the cam a childElement of the scene itself.
        //position the camera on the gamescene.
        cam.position = car.position
        
        
        
        


        //create myCar
        
        myNewCar.add(to: self)

    }
    
    func spawnPipes() {
        let pipePair = SKNode()
        pipePair.position = CGPoint( x: self.frame.size.width + pipeTextureUp.size().width * 2, y: 0 )
        pipePair.zPosition = -10
        
        let height = UInt32( self.frame.size.height / 4)
        let y = Double(arc4random_uniform(height) + height);
        
        let pipeDown = SKSpriteNode(texture: pipeTextureDown)
        pipeDown.setScale(2.0)
        pipeDown.position = CGPoint(x: 0.0, y: y + Double(pipeDown.size.height) + verticalPipeGap)
        
        
        pipeDown.physicsBody = SKPhysicsBody(rectangleOf: pipeDown.size)
        pipeDown.physicsBody?.isDynamic = false
        pipeDown.physicsBody?.categoryBitMask = pipeCategory
        pipeDown.physicsBody?.contactTestBitMask = carCategory
        pipePair.addChild(pipeDown)
        
        let pipeUp = SKSpriteNode(texture: pipeTextureUp)
        pipeUp.setScale(2.0)
        pipeUp.position = CGPoint(x: 0.0, y: y)
        
        pipeUp.physicsBody = SKPhysicsBody(rectangleOf: pipeUp.size)
        pipeUp.physicsBody?.isDynamic = false
        pipeUp.physicsBody?.categoryBitMask = pipeCategory
        pipeUp.physicsBody?.contactTestBitMask = carCategory
        pipePair.addChild(pipeUp)
        
        let contactNode = SKNode()
        contactNode.position = CGPoint( x: pipeDown.size.width + car.size.width / 2, y: self.frame.midY )
        contactNode.physicsBody = SKPhysicsBody(rectangleOf: CGSize( width: pipeUp.size.width, height: self.frame.size.height ))
        contactNode.physicsBody?.isDynamic = false
        contactNode.physicsBody?.categoryBitMask = pipeCategory
        contactNode.physicsBody?.contactTestBitMask = carCategory
        pipePair.addChild(contactNode)
        
        pipePair.run(movePipesAndRemove)
        pipes.addChild(pipePair)

        
    }
    
    func resetScene (){
        // Move bird to original position and reset velocity
        car.position = CGPoint(x: self.frame.size.width / 2.5, y: self.frame.midY)
        car.physicsBody?.velocity = CGVector( dx: 0, dy: 0 )
        car.physicsBody?.collisionBitMask = worldCategory | pipeCategory
        car.speed = 1.0
        car.zRotation = 0.0
        
        // Remove all existing pipes
        pipes.removeAllChildren()
        
        // Reset _canRestart
        canRestart = false
        
        
        // Restart animation
        moving.speed = 0;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */
        car.speed = 0
        isTouch = true
        
        
        myNewCar.run(speed: 5)
        //if moving.speed > 0  {
        /*for touch: AnyObject in touches {
         let location = touch.location(in: self)
         moving.speed = 1.0
         bird.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
         bird.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 0))
         
         }*/
        
        //} else if canRestart {
        //self.resetScene()
        //}
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouch = false
    }
    // TODO: Move to utilities somewhere. There's no reason this should be a member function
    func clamp(_ min: CGFloat, max: CGFloat, value: CGFloat) -> CGFloat {
        if( value > max ) {
            return max
        } else if( value < min ) {
            return min
        } else {
            return value
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        /* Called before each frame is rendered */
        car.zRotation = self.clamp( -1, max: 0.5, value: car.physicsBody!.velocity.dy * ( car.physicsBody!.velocity.dy < 0 ? 0.003 : 0.001 ) )
        if (isTouch){
            moving.speed += 0.1
        }
        else{
            if (moving.speed > 0){
                moving.speed -= 0.1
            }
        }
        
        
    }

    
    func didBegin(_ contact: SKPhysicsContact) {
        
        isTouch = false
        if ((contact.bodyA.categoryBitMask == pipeCategory)){
         
            car.physicsBody?.applyImpulse(CGVector(dx: -moving.speed * 2, dy: 0))
            
            
            
            
            
            let man = Human(pos: car.position)
            man.add(to: self)
            man.impulse(force: moving.speed)
            
            moving.speed = 0.0
        }
        
        /*if (contact.bodyA.categoryBitMask & contact.bodyB.categoryBitMask) != 0 {
         
         }*/
        
        let amask = contact.bodyA.categoryBitMask
        let bmask = contact.bodyB.categoryBitMask
        
        if amask == worldCategory && bmask == armCategory ||  bmask == worldCategory && amask == armCategory {
            print("It was arm!!! %.6f", contact.collisionImpulse)
        }
        if amask == worldCategory && bmask == legCategory ||  bmask == worldCategory && amask == legCategory {
            print("It was leg!!! %.6f", contact.collisionImpulse)
        }
        if amask == worldCategory && bmask == headCategory ||  bmask == worldCategory && amask == headCategory {
           print("It was head!!! %.6f", contact.collisionImpulse)
        
        }
        
        
        
        
        
        
        
            
        
    }

    
}
