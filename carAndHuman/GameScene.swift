//
//  GameScene.swift
//  play
//
//  Created by Ivan on 21.10.16.
//  Copyright © 2016 Ivan. All rights reserved.
//

import SpriteKit
import GameplayKit

let carCategory: UInt32 = 1 << 0
let groundCategory: UInt32 = 1 << 1
let pipeCategory: UInt32 = 1 << 2
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
    let Circle = SKShapeNode(circleOfRadius:20)
    
    var man = SKPhysicsJointFixed()
    var man1 = SKPhysicsJointFixed()
    var man2 = SKPhysicsJointFixed()
    var man3 = SKPhysicsJointFixed()
    var man4 = SKPhysicsJointFixed()
    var man5 = SKPhysicsJointSpring()
    
    init (pos: CGPoint) {
        super.init()
        Circle2.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        Circle2.physicsBody?.isDynamic = true
        Circle2.physicsBody?.categoryBitMask = circleCategory
        Circle2.physicsBody?.collisionBitMask =  groundCategory
        Circle2.physicsBody?.contactTestBitMask = groundCategory
        Circle2.fillColor = SKColor.red
        Circle2.position = CGPoint (x: pos.x - 30, y: pos.y)
        self.addChild(Circle2)
        
        leg1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 60, height: 20))
        leg1.physicsBody?.isDynamic = true
        leg1.physicsBody?.categoryBitMask = legCategory
        leg1.physicsBody?.collisionBitMask =  groundCategory
        leg1.physicsBody?.contactTestBitMask = groundCategory
        leg1.fillColor = SKColor.red
        leg1.position = CGPoint (x: pos.x - 80 , y: pos.y - 20)
        self.addChild(leg1)
        
        
        leg2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 20))
        leg2.physicsBody?.isDynamic = true
        leg2.physicsBody?.categoryBitMask = legCategory
        leg2.physicsBody?.collisionBitMask =  groundCategory
        leg2.physicsBody?.contactTestBitMask = groundCategory
        leg2.fillColor = SKColor.red
        leg2.position = CGPoint (x: pos.x - 80 , y: pos.y + 20)
        addChild(leg2)
        
        
        arm1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 20))
        arm1.physicsBody?.isDynamic = true
        arm1.physicsBody?.categoryBitMask = armCategory
        arm1.physicsBody?.collisionBitMask =  groundCategory
        arm1.physicsBody?.contactTestBitMask = groundCategory
        arm1.fillColor = SKColor.red
        arm1.position = CGPoint (x: pos.x + 40 , y: pos.y - 20)
        addChild(arm1)
        
        
        arm2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 90, height: 20))
        arm2.physicsBody?.isDynamic = true
        arm2.physicsBody?.categoryBitMask = armCategory
        arm2.physicsBody?.collisionBitMask =  groundCategory
        arm2.physicsBody?.contactTestBitMask = groundCategory
        arm2.fillColor = SKColor.red
        arm2.position = CGPoint (x: pos.x + 40 , y: pos.y + 20)
        addChild(arm2)
        
        Circle.physicsBody = SKPhysicsBody(circleOfRadius: 20)
        Circle.physicsBody?.isDynamic = true
        
        Circle.physicsBody?.categoryBitMask = headCategory
        Circle.physicsBody?.collisionBitMask =  groundCategory
        Circle.physicsBody?.contactTestBitMask = groundCategory
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
        Circle2.physicsBody?.applyImpulse(CGVector(dx: force * 100, dy: force * 100))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Car: SKNode{
    
    
    //let bodyCar = SKShapeNode(rect: CGRect(x: 0.0, y: 0.0, width: 120.0, height: 40.0))
    let bodyCar = SKShapeNode(rectOf: CGSize(width: 240.0, height: 80.0))
    let circle1 = SKShapeNode(circleOfRadius:40)
    let circle2 = SKShapeNode(circleOfRadius:40)
    var pinCircle1 = SKPhysicsJointPin()
    var pinCircle2 = SKPhysicsJointPin()
    var pinCircle1Fix = SKPhysicsJointFixed()
    var pinCircle2Fix = SKPhysicsJointFixed()
    
    
    override init() {
        super.init()
        
        
        bodyCar.physicsBody = SKPhysicsBody(rectangleOf: bodyCar.frame.size)
        bodyCar.physicsBody?.categoryBitMask = carCategory
        bodyCar.physicsBody?.collisionBitMask =  groundCategory
        bodyCar.physicsBody?.contactTestBitMask = pipeCategory
        bodyCar.physicsBody?.isDynamic = true
        bodyCar.fillColor = SKColor.yellow
        
        addChild(bodyCar)
        
        circle1.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        circle1.fillColor = SKColor.black
        circle1.physicsBody?.categoryBitMask = circleCategory
        circle1.physicsBody?.collisionBitMask =  groundCategory
        circle1.physicsBody?.contactTestBitMask = carCategory
        circle1.physicsBody?.isDynamic = true
        
        addChild(circle1)
        
        circle2.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        circle2.fillColor = SKColor.black
        circle2.physicsBody?.categoryBitMask = circleCategory
        circle2.physicsBody?.collisionBitMask =  groundCategory
        circle2.physicsBody?.contactTestBitMask = carCategory
        circle2.physicsBody?.isDynamic = true
        
        addChild(circle2)
        
        //pinCircle1 = SKPhysicsJointPin.joint(withBodyA: bodyCar.physicsBody!, bodyB: circle1.physicsBody!, anchor: CGPoint (x: bodyCar.position.x - 40, y: bodyCar.position.y-10))
        //pinCircle2 = SKPhysicsJointPin.joint(withBodyA: bodyCar.physicsBody!, bodyB: circle2.physicsBody!, anchor: CGPoint (x: bodyCar.position.x + 40, y: bodyCar.position.y-10))
        pinCircle1Fix = SKPhysicsJointFixed.joint(withBodyA: bodyCar.physicsBody!, bodyB: circle1.physicsBody!, anchor: CGPoint (x: bodyCar.position.x - 80, y: bodyCar.position.y-10))
        pinCircle2Fix = SKPhysicsJointFixed.joint(withBodyA: bodyCar.physicsBody!, bodyB: circle2.physicsBody!, anchor: CGPoint (x: bodyCar.position.x + 80, y: bodyCar.position.y-10))
        
        
        
        
    }
    
    func add(to scene: SKScene) {
        bodyCar.position = CGPoint(x:  -self.frame.size.width/2, y: 120)
        circle1.position = CGPoint(x: bodyCar.position.x - 80, y: bodyCar.position.y-20)
        circle2.position = CGPoint(x: bodyCar.position.x + 80, y: bodyCar.position.y-20)
        
        scene.addChild(self)
        //scene.physicsWorld.add(pinCircle1)
        //scene.physicsWorld.add(pinCircle2)
        scene.physicsWorld.add(pinCircle1Fix)
        scene.physicsWorld.add(pinCircle2Fix)
        
        
    }
    
    
    func run (speed: CGFloat){
        circle1.physicsBody?.velocity = CGVector(dx: speed, dy: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var myNewMan: Human!
    var myNewCar: Car!
    var cam: SKCameraNode!
    var ground1: SKShapeNode!
    var ground2: SKShapeNode!
    var moveGround1: SKAction!
    var moveGround2: SKAction!
    var pipe: SKShapeNode!
    
    var isTouch = false
    var spawn = false
    var notContact = true
    var camCar = true
    var speedCar: CGFloat = 0.0
    var distance = 0
    
    override func didMove(to view: SKView) {
        self.physicsWorld.gravity = CGVector(dx: 0.0, dy: -5.0)
        self.physicsWorld.contactDelegate = self
        
        self.backgroundColor = SKColor.blue
        
        ground1 = SKShapeNode(rectOf: CGSize(width: self.frame.width, height: 100))
        ground1.fillColor = SKColor.green
        ground1.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 100))
        ground1.physicsBody?.isDynamic = false
        ground1.physicsBody?.categoryBitMask = groundCategory
        ground1.position = CGPoint(x: 0, y: 0)
        addChild(ground1)
        
        ground2 = SKShapeNode(rectOf: CGSize(width: self.frame.width, height: 100))
        ground2.fillColor = SKColor.green
        ground2.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: self.frame.width, height: 100))
        ground2.physicsBody?.isDynamic = false
        ground2.physicsBody?.categoryBitMask = groundCategory
        ground2.position = CGPoint(x: -self.frame.width, y: 0)
        addChild(ground2)
        
        moveGround1 = SKAction.moveBy(x: ground1.position.x + self.frame.width * 2, y: 0, duration: 0)
        moveGround2 = SKAction.moveBy(x: ground2.position.x + self.frame.width * 2, y: 0, duration: 0)
        
        myNewCar = Car()
        myNewCar.add(to: self)
        
        cam = SKCameraNode()
        self.camera = cam
        //cam.xScale = 1.5
        //cam.yScale = 1.5
        addChild(cam)
        cam.position = myNewCar.bodyCar.position
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouch = true
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        isTouch = false
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        if camCar{
            cam.position = myNewCar.bodyCar.position
        }
        else{
            cam.position = myNewMan.arm1.position
        }
        if isTouch && notContact{
            speedCar = speedCar + 20
            myNewCar.run(speed: speedCar)
        }
        else{
            if speedCar > 0 && notContact{
                speedCar = speedCar - 20
            }
            myNewCar.run(speed: speedCar)
        }
        if camCar{
            if myNewCar.bodyCar.position.x > ground1.position.x && ground1.position.x > ground2.position.x{
                ground2.run(moveGround1)
                distance = distance + 1
                if distance == 6{
                    spawn = true
                }
            }
            if myNewCar.bodyCar.position.x > ground2.position.x && ground2.position.x > ground1.position.x{
                ground1.run(moveGround1)
                distance = distance + 1
                if distance == 6{
                    spawn = true
                }
            }
        }
        else{
            if myNewMan.arm1.position.x > ground1.position.x && ground1.position.x > ground2.position.x{
                ground2.run(moveGround1)
                distance = distance + 1
            }
            if myNewMan.arm1.position.x > ground2.position.x && ground2.position.x > ground1.position.x{
                ground1.run(moveGround1)
                distance = distance + 1
            }
            
        }
        if spawn{
            spawnPipe()
            spawn = false
        }
    }
    
    func spawnPipe(){
        pipe = SKShapeNode(rectOf: CGSize(width: 100, height: 100))
        pipe.fillColor = SKColor.red
        pipe.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: 100, height: 100))
        pipe.physicsBody?.isDynamic = false
        pipe.physicsBody?.categoryBitMask = pipeCategory
        pipe.position = CGPoint(x: myNewCar.bodyCar.position.x + self.frame.width, y: 100)
        addChild(pipe)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.categoryBitMask == pipeCategory || contact.bodyB.categoryBitMask == pipeCategory{
            let impulse = speedCar
            print(impulse)
            notContact = false
            speedCar = 0
            myNewCar.run(speed: speedCar)
            myNewCar.bodyCar.physicsBody?.applyImpulse(CGVector(dx: -impulse, dy: 100))
            
            camCar = false
            
            myNewMan = Human(pos: myNewCar.bodyCar.position)
            myNewMan.add(to: self)
            myNewMan.impulse(force: impulse/700)
        }
    }
}
