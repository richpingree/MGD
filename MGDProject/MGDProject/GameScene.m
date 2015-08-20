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
static const uint32_t heartCategory = 0x1 << 4;

@implementation GameScene
{
    SKSpriteNode *heart, *dude, *zombie, *cabinet;

}


//add main character
-(void) addDude:(CGSize)size{
    dude = [SKSpriteNode spriteNodeWithImageNamed:@"dude"];
    dude.xScale = 0.5;
    dude.yScale = 0.5;
    dude.position = CGPointMake(size.width/2, size.height/2);
    dude.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:dude.size];
    dude.physicsBody.dynamic = YES;
    dude.physicsBody.affectedByGravity = NO;
    dude.physicsBody.friction = 1;
    dude.physicsBody.linearDamping = 0;
    dude.physicsBody.restitution = 0;
    dude.physicsBody.allowsRotation = NO;
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
    zombie.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:zombie.size];
    zombie.physicsBody.dynamic = YES;
    zombie.physicsBody.affectedByGravity = NO;
    zombie.physicsBody.friction = 1;
    zombie.physicsBody.linearDamping = 1;
    zombie.physicsBody.restitution = 1;
    zombie.physicsBody.allowsRotation = NO;
    zombie.physicsBody.categoryBitMask = zombieCategory;
    zombie.physicsBody.collisionBitMask = mainCategory | zombieCategory | cabinetCategory | heartCategory;
    zombie.physicsBody.contactTestBitMask = mainCategory | zombieCategory | cabinetCategory | heartCategory;
    
    [self addChild:zombie];
}

//add cabinet
-(void) addCabinet:(CGSize)size{
    cabinet = [SKSpriteNode spriteNodeWithImageNamed:@"cabinet"];
    cabinet.xScale = 1.5;
    cabinet.yScale = 1.5;
    cabinet.position = CGPointMake(size.width/1.5, 360);
    cabinet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:cabinet.size];
    cabinet.physicsBody.dynamic = YES;
    cabinet.physicsBody.affectedByGravity = NO;
    cabinet.physicsBody.friction = 1;
    cabinet.physicsBody.linearDamping = 0;
    cabinet.physicsBody.restitution = 0;
    cabinet.physicsBody.categoryBitMask = cabinetCategory;
    //cabinet.physicsBody.collisionBitMask = mainCategory | zombieCategory | cabinetCategory;
    //cabinet.physicsBody.contactTestBitMask = mainCategory | zombieCategory | cabinetCategory;

    [self addChild:cabinet];
    
}

//add heart
-(void) addHeart:(CGSize)size{
    heart = [SKSpriteNode spriteNodeWithImageNamed:@"heart6"];
    heart.xScale = 1.5;
    heart.yScale = 1.5;
    heart.position = CGPointMake(size.width/4, (size.height/4)*3);
    heart.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:heart.size];
    heart.physicsBody.dynamic = YES;
    heart.physicsBody.affectedByGravity = NO;
    heart.physicsBody.allowsRotation = NO;
    heart.physicsBody.categoryBitMask = heartCategory;
    heart.physicsBody.collisionBitMask = mainCategory | heartCategory;
    heart.physicsBody.contactTestBitMask = mainCategory | heartCategory;
    
    [self addChild:heart];
}
//inits all nodes and background
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        //preload texture atlas
        //SKTextureAtlas *heart = [SKTextureAtlas atlasNamed:@"heart6.png"];
        SKTextureAtlas *dudeAtlas = [SKTextureAtlas atlasNamed:@"dude"];
        
        //background image
        SKSpriteNode *bgImage =[SKSpriteNode spriteNodeWithImageNamed:@"background1.png"];
        bgImage.xScale = 1.75;
        bgImage.yScale = 1.75;
        bgImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:bgImage];
        
        //world physics
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = edgeCategory;
        self.physicsWorld.contactDelegate = self;
        
        //add nodes
        [self addDude:size];
        
        [self addZombie:size];
        
        [self addCabinet:size];
        
        [self addHeart:size];
        

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
    //collision with zombie plays sound effect
    if (firstBody.categoryBitMask == zombieCategory) {
        SKAction *playZombieSound = [SKAction playSoundFileNamed:@"zombiesound.wav" waitForCompletion:NO];
        [dude runAction:playZombieSound];
    }
    
    if (firstBody.categoryBitMask == heartCategory) {
        SKAction *playHeartSound = [SKAction playSoundFileNamed:@"heartbeat.wav" waitForCompletion:NO];
        [dude runAction:playHeartSound];
        [heart removeFromParent];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        //moves main character to clicked location
        SKAction *actionMove = [SKAction moveTo:location duration:2.0];
        [dude runAction:actionMove];
        
        //plays footsteps sound while main character is moving
        SKAction *playFootsteps = [SKAction playSoundFileNamed:@"footsteps.wav" waitForCompletion:YES];
        [dude runAction: [SKAction repeatAction:playFootsteps count:actionMove.duration]];
        
        
        //NSLog(@"position: %@", NSStringFromCGPoint(location));
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
