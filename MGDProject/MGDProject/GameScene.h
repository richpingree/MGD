//
//  GameScene.h
//  MGDProject
//

//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface GameScene : SKScene <SKPhysicsContactDelegate>
{
    
}

@property (readwrite) BOOL isPaused;
@property (nonatomic) NSTimeInterval lastSpawnTimeInterval;
@property (nonatomic) NSTimeInterval lastUpdateTimeInterval;
@end
