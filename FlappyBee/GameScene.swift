//
//  GameScene.swift
//  FlappyBee
//
//  Created by Nathan McGuire on 10/12/2015.
//  Copyright (c) 2015 Nathan McGuire. All rights reserved.
//

import SpriteKit

struct PhysicsCatagory {
    static let Bee : UInt32 = 0x1 << 1
    static let Ground : UInt32 = 0x1 << 2
    static let Wall : UInt32 = 0x1 << 3
}

class GameScene: SKScene {
    
    var Ground = SKSpriteNode()
    var Bee = SKSpriteNode()
    
    override func didMoveToView(view: SKView) {

        Ground = SKSpriteNode(imageNamed: "Floor")
        Ground.setScale(0.5)
        Ground.position = CGPoint(x: self.frame.width / 2, y: 0 + Ground.frame.height / 2)
        
        Ground.physicsBody = SKPhysicsBody(rectangleOfSize: Ground.size)
        Ground.physicsBody?.categoryBitMask = PhysicsCatagory.Ground
        Ground.physicsBody?.collisionBitMask = PhysicsCatagory.Bee
        Ground.physicsBody?.contactTestBitMask = PhysicsCatagory.Bee
        Ground.physicsBody?.affectedByGravity = false
        Ground.physicsBody?.dynamic = false
        
        Ground.zPosition = 3
        
        self.addChild(Ground)
        
        Bee = SKSpriteNode(imageNamed: "Bee")
        Bee.size = CGSize(width: 60, height: 70)
        Bee.position = CGPoint(x: self.frame.width / 2 - Bee.frame.width, y: self.frame.height / 2)
        
        Bee.physicsBody = SKPhysicsBody(circleOfRadius: Bee.frame.height / 2)
        Bee.physicsBody?.categoryBitMask = PhysicsCatagory.Bee
        Bee.physicsBody?.collisionBitMask = PhysicsCatagory.Ground | PhysicsCatagory.Wall
        Bee.physicsBody?.contactTestBitMask = PhysicsCatagory.Ground | PhysicsCatagory.Wall
        Bee.physicsBody?.affectedByGravity = true
        Bee.physicsBody?.dynamic = true
        
        Bee.zPosition = 2
        
        self.addChild(Bee)
        
        createWalls()
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
     
        Bee.physicsBody?.velocity = CGVectorMake(0, 0)
        Bee.physicsBody?.applyImpulse(CGVectorMake(0, 80))
    }
    
    func createWalls() {
        
        let wallPair = SKNode()
        
        let topWall = SKSpriteNode(imageNamed: "TopWall")
        let btmWall = SKSpriteNode(imageNamed: "BtmWall")
        
        topWall.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 + 350)
        btmWall.position = CGPoint(x: self.frame.width, y: self.frame.height / 2 - 350)

        topWall.setScale(0.5)
        btmWall.setScale(0.5)
        
        topWall.physicsBody = SKPhysicsBody(rectangleOfSize: topWall.size)
        topWall.physicsBody?.categoryBitMask = PhysicsCatagory.Wall
        topWall.physicsBody?.collisionBitMask = PhysicsCatagory.Bee
        topWall.physicsBody?.contactTestBitMask = PhysicsCatagory.Bee
        topWall.physicsBody?.affectedByGravity = false
        topWall.physicsBody?.dynamic = false
        
        btmWall.physicsBody = SKPhysicsBody(rectangleOfSize: btmWall.size)
        btmWall.physicsBody?.categoryBitMask = PhysicsCatagory.Wall
        btmWall.physicsBody?.collisionBitMask = PhysicsCatagory.Bee
        btmWall.physicsBody?.contactTestBitMask = PhysicsCatagory.Bee
        btmWall.physicsBody?.affectedByGravity = false
        btmWall.physicsBody?.dynamic = false
        
        wallPair.addChild(topWall)
        wallPair.addChild(btmWall)
        
        wallPair.zPosition = 1
        
        self.addChild(wallPair)
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
