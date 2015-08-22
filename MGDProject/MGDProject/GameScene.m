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
    SKSpriteNode *heart, *dude, *zombie, *cabinet, *pauseBtn;
    SKLabelNode *pauseLabel;
    
    SKTexture *temp;
    NSArray *dudeWalkFrames, *changeToZombie;

}


//add main character
-(void) addDude:(CGSize)size{
    //dude = [SKSpriteNode spriteNodeWithImageNamed:@"dude"];
    SKTexture *dudeTemp = dudeWalkFrames[0];
    dude =[SKSpriteNode spriteNodeWithTexture:dudeTemp];
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
//-(void) addCabinet:(CGSize)size{
//    cabinet = [SKSpriteNode spriteNodeWithImageNamed:@"cabinet"];
//    cabinet.xScale = 1.5;
//    cabinet.yScale = 1.5;
//    cabinet.position = CGPointMake(size.width/1.5, 360);
//    cabinet.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:cabinet.size];
//    cabinet.physicsBody.dynamic = YES;
//    cabinet.physicsBody.affectedByGravity = NO;
//    cabinet.physicsBody.friction = 1;
//    cabinet.physicsBody.linearDamping = 0;
//    cabinet.physicsBody.restitution = 0;
//    cabinet.physicsBody.categoryBitMask = cabinetCategory;
//    //cabinet.physicsBody.collisionBitMask = mainCategory | zombieCategory | cabinetCategory;
//    //cabinet.physicsBody.contactTestBitMask = mainCategory | zombieCategory | cabinetCategory;
//
//    [self addChild:cabinet];
//    
//}

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

//add pause button
-(void) addPauseBtn:(CGSize)size{
    pauseBtn = [SKSpriteNode spriteNodeWithImageNamed:@"pause"];
    pauseBtn.name = @"pause";
    pauseBtn.xScale = .25;
    pauseBtn.yScale = .25;
    pauseBtn.position = CGPointMake(25, 25);
    pauseBtn.zPosition = 1;
    
    [self addChild:pauseBtn];
}

-(void) addPauseLabel:(CGSize)size{
    pauseLabel = [SKLabelNode labelNodeWithText:@"Game Paused!"];
    pauseLabel.fontSize = 30;
    pauseLabel.position = CGPointMake(size.height/2, size.width/2);
    pauseLabel.zPosition = 3.0;
    
    [self addChild:pauseLabel];
    
}

-(void)buttonPressed:(SKSpriteNode *)sender{
    if (_isPaused) {
        self.scene.view.paused = NO;
        self.isPaused = NO;
        
    } else{
        self.scene.view.paused = YES;
        self.isPaused = YES;
        
    }
}

//inits all nodes and background
-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        
        //Array for animation
        NSMutableArray *walkFrames = [NSMutableArray array];
        NSMutableArray *changeFrames = [NSMutableArray array];
        
        //preload texture atlas
        SKTextureAtlas *dudeAtlas = [SKTextureAtlas atlasNamed:@"dude"];
        SKTextureAtlas *changeAtlas = [SKTextureAtlas atlasNamed:@"changing"];
        
        //gather dude images for walking animation
        NSInteger numImages = dudeAtlas.textureNames.count;
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"dude%d", i];
            temp = [dudeAtlas textureNamed:textureName];
            [walkFrames addObject:temp];
            dudeWalkFrames = walkFrames;
        }
        
        //gather changing images for turning into Zombie
        NSInteger numChangeImages = changeAtlas.textureNames.count;
        for (int i=1; i <= numChangeImages; i++) {
            NSString *changingTextureName = [NSString stringWithFormat:@"change%d", i];
            temp = [changeAtlas textureNamed:changingTextureName];
            [changeFrames addObject:temp];
            changeToZombie = changeFrames;
        }
        
        //background image
        SKSpriteNode *bgImage =[SKSpriteNode spriteNodeWithImageNamed:@"background.png"];
        bgImage.xScale = .5;
        bgImage.yScale = .5;
        bgImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:bgImage];
        
        //world physics
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        self.physicsBody.categoryBitMask = edgeCategory;
        self.physicsWorld.contactDelegate = self;
        
        //add nodes
        [self addDude:size];
        
        [self addZombie:size];
        
        //[self addCabinet:size];
        
        [self addHeart:size];
        
        [self addPauseBtn:size];
        
        

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
        SKAction *change = [SKAction animateWithTextures:changeToZombie timePerFrame:0.05f];
        [dude runAction:change];
        
        SKLabelNode *lostGame = [SKLabelNode labelNodeWithText:@"Game Over!"];
        lostGame.fontSize = 100;
        lostGame.zPosition = 3.0;
        lostGame.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:lostGame];
        //self.scene.view.paused = YES;
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
        
        //animation for main character
        SKAction *walking = [SKAction animateWithTextures:dudeWalkFrames timePerFrame:0.1f];
        [dude runAction: [SKAction repeatAction:walking count:2]];
        //[self walking];
        
        //plays footsteps sound while main character is moving
        SKAction *playFootsteps = [SKAction playSoundFileNamed:@"footsteps.wav" waitForCompletion:YES];
        [dude runAction: [SKAction repeatAction:playFootsteps count:actionMove.duration]];
        
        //pause
        SKNode *node = [self nodeAtPoint:location];
        if ([node.name isEqualToString:@"pause"]) {
            if (self.scene.view.paused == true) {
                [self addPauseLabel:self.size];
            } else if(self.scene.view.paused == false){
                [pauseLabel removeFromParent];
            }

            [self buttonPressed:pauseBtn];
            [dude removeAllActions];
            
        }

        //NSLog(@"position: %@", NSStringFromCGPoint(location));
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
