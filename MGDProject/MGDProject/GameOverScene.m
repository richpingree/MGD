//
//  GameOverScene.m
//  MGDProject
//
//  Created by Richard Pingree on 9/10/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"


@implementation GameOverScene
@synthesize score;

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]){
        
        //background image
        SKSpriteNode *bgImage =[SKSpriteNode spriteNodeWithImageNamed:@"background.png"];
        bgImage.xScale = .5;
        bgImage.yScale = .25;
        bgImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:bgImage];
        
        //GameOver label node
        SKLabelNode *lostGame = [SKLabelNode labelNodeWithText:@"Game Over!"];
        lostGame.fontSize = 100;
        lostGame.zPosition = 3.0;
        lostGame.position = CGPointMake(self.size.width/2, self.size.height/2);
        [self addChild:lostGame];
        
        //NSLog(@"Score:%@", [GameScene finalScore]);
    }
    return self;
}
@end
