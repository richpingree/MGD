//
//  GameScene.m
//  MGDProject
//
//  Created by Richard Pingree on 8/5/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import "GameScene.h"

static const uint32_t mainCategory = 0x1 << 0;
static const uint32_t zombieCategory = 0x1 << 1;
static const uint32_t cabinetCategory = 0x1 << 2;
static const uint32_t edgeCategory = 0x1 << 3;

@implementation GameScene
{
    SKSpriteNode *sprite, *dude, *zombie, *cabinet;

}

//-(void)didMoveToView:(SKView *)view {
//    /* Setup your scene here */
////    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
////    
////    myLabel.text = @"Hello, World!";
////    myLabel.fontSize = 65;
////    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),
////                                   CGRectGetMidY(self.frame));
////    
////    [self addChild:myLabel];
//    
//    SKSpriteNode *bgImage =[SKSpriteNode spriteNodeWithImageNamed:@"background.png"];
//    bgImage.xScale = 0.5;
//    bgImage.yScale = 0.5;
//    bgImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
//    
//    [self addChild:bgImage];
//    
//    //add nodes
//    
//    
//}

//add main character
-(void) addDude:(CGSize)size{
    dude = [SKSpriteNode spriteNodeWithImageNamed:@"dude"];
    dude.xScale = 0.5;
    dude.yScale = 0.5;
    dude.position = CGPointMake(size.width/2, size.height/2);
    //dude.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:dude.frame.size.width/2];
    dude.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:dude.size];
    dude.physicsBody.dynamic = YES;
    dude.physicsBody.affectedByGravity = NO;
    dude.physicsBody.friction = 1;
    dude.physicsBody.linearDamping = 0;
    dude.physicsBody.restitution = 0;
    dude.physicsBody.categoryBitMask = mainCategory;
    dude.physicsBody.collisionBitMask = mainCategory | zombieCategory | cabinetCategory;
    dude.physicsBody.contactTestBitMask = mainCategory | zombieCategory | cabinetCategory;
    
    [self addChild:dude];
}

//add zombie
-(void) addZombie:(CGSize)size{
    zombie = [SKSpriteNode spriteNodeWithImageNamed:@"zombie"];
    zombie.xScale = 0.5;
    zombie.yScale = 0.5;
    zombie.position = CGPointMake(size.width*.25, size.height*.25);
    //zombie.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:zombie.frame.size.width/2];
    zombie.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:zombie.size];
    zombie.physicsBody.dynamic = YES;
    zombie.physicsBody.affectedByGravity = NO;
    zombie.physicsBody.friction = 1;
    zombie.physicsBody.linearDamping = 0;
    zombie.physicsBody.restitution = 0;
    zombie.physicsBody.categoryBitMask = zombieCategory;
    zombie.physicsBody.collisionBitMask = mainCategory | zombieCategory | cabinetCategory;
    zombie.physicsBody.contactTestBitMask = mainCategory | zombieCategory | cabinetCategory;
    
    [self addChild:zombie];
}

//add cabinet
-(void) addCabinet:(CGSize)size{
    cabinet = [SKSpriteNode spriteNodeWithImageNamed:@"cabinet"];
    cabinet.xScale = 1.5;
    cabinet.yScale = 1.5;
    cabinet.position = CGPointMake(size.width/2, 323);
    cabinet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:cabinet.size];
    cabinet.physicsBody.dynamic = YES;
    cabinet.physicsBody.affectedByGravity = NO;
    cabinet.physicsBody.friction = 1;
    cabinet.physicsBody.linearDamping = 0;
    cabinet.physicsBody.restitution = 0;
    cabinet.physicsBody.categoryBitMask = cabinetCategory;
    cabinet.physicsBody.collisionBitMask = mainCategory | zombieCategory | cabinetCategory;
    cabinet.physicsBody.contactTestBitMask = mainCategory | zombieCategory | cabinetCategory;

    
    
    [self addChild:cabinet];
    
}
//inits all nodes and background
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        //background image
        SKSpriteNode *bgImage =[SKSpriteNode spriteNodeWithImageNamed:@"background1.png"];
        bgImage.xScale = 1.75;
        bgImage.yScale = 1.75;
        bgImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:bgImage];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = edgeCategory;
        self.physicsWorld.contactDelegate = self;
        
        //add nodes
        [self addDude:size];
        
        [self addZombie:size];
        
        [self addCabinet:size];
        

    }
    return self;
    
}

//collision phsyics
-(void)didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody *firstBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyB;
    }else{
        firstBody = contact.bodyA;
    }
    
    if (firstBody.categoryBitMask == zombieCategory) {
        SKAction *playZombieSound = [SKAction playSoundFileNamed:@"zombiesound.wav" waitForCompletion:NO];
        [dude runAction:playZombieSound];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKAction *actionMove = [SKAction moveTo:location duration:2.0];
        [dude runAction:actionMove];
        
//        sprite = [SKSpriteNode spriteNodeWithImageNamed:@"dude"];
//        
//        sprite.xScale = 0.5;
//        sprite.yScale = 0.5;
//        sprite.position = location;
//        sprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:dude.size];
//        sprite.physicsBody.dynamic = YES;
//        sprite.physicsBody.affectedByGravity = NO;
//        sprite.physicsBody.friction = 1;
//        sprite.physicsBody.linearDamping = 0;
//        sprite.physicsBody.restitution = 0;
//        sprite.physicsBody.categoryBitMask = mainCategory;
//        sprite.physicsBody.collisionBitMask = mainCategory | zombieCategory | cabinetCategory | edgeCategory;
//        sprite.physicsBody.contactTestBitMask = mainCategory | zombieCategory | cabinetCategory | edgeCategory;
//        
//        SKAction *action = [SKAction rotateByAngle:M_PI duration:1];
//        
//        [sprite runAction:[SKAction repeatActionForever:action]];
//        
//        [self addChild:sprite];
        
        NSLog(@"position: %@", NSStringFromCGPoint(location));
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
