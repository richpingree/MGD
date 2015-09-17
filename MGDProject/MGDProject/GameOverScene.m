//
//  GameOverScene.m
//  MGDProject
//
//  Created by Richard Pingree on 9/10/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import "GameOverScene.h"
#import "GameScene.h"
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>


@implementation GameOverScene
{
    SKLabelNode *lostGame, *finalScore;
}


-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]){
        
        //background image
        SKSpriteNode *bgImage =[SKSpriteNode spriteNodeWithImageNamed:@"background.png"];
        bgImage.xScale = .5;
        bgImage.yScale = .25;
        bgImage.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
        
        [self addChild:bgImage];
        
        //GameOver label node
        lostGame = [SKLabelNode labelNodeWithText:@"Game Over!"];
        lostGame.fontSize = 100;
        lostGame.zPosition = 3.0;
        lostGame.position = CGPointMake(self.size.width/2, self.size.height/2 + 70);
        [self addChild:lostGame];
        
        
        
        NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
        NSInteger score = [prefs integerForKey:@"score"];
        
        NSString *scoreText = [NSString stringWithFormat:@"Score:%ld", (long)score];
        
        finalScore = [SKLabelNode labelNodeWithText:scoreText];
        finalScore.fontSize = 50;
        finalScore.zPosition = 3.0;
        finalScore.position = CGPointMake(lostGame.position.x , lostGame.position.y - 150);
        [self addChild:finalScore];
        
        SKLabelNode *restartNode = [SKLabelNode labelNodeWithText:@"Restart"];
        restartNode.name = @"restartNode";
        restartNode.fontSize = 30;
        restartNode.zPosition = 3.0;
        restartNode.position = CGPointMake(lostGame.position.x, finalScore.position.y - 40);
        [self addChild:restartNode];
        
        
    }
    return self;
}

-(void)didMoveToView:(SKView *)view{
    UITextField *playerNameField = [[UITextField alloc]initWithFrame:CGRectMake(lostGame.position.x, lostGame.position.y - 100, 250, 60)];
    playerNameField.center = self.view.center;
    playerNameField.borderStyle = UITextBorderStyleRoundedRect;
    playerNameField.textColor = [UIColor blackColor];
    playerNameField.font = [UIFont systemFontOfSize:30.0];
    playerNameField.placeholder = @"Enter Name";
    playerNameField.backgroundColor = [UIColor whiteColor];
    playerNameField.autocorrectionType = UITextAutocorrectionTypeYes;
    playerNameField.keyboardType = UIKeyboardTypeDefault;
    playerNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    playerNameField.delegate = self;
    
    [self.view addSubview:playerNameField];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKNode *node = [self nodeAtPoint:location];
        if ([node.name isEqualToString:@"restartNode"]) {
            
            SKScene *restartGame = [[GameScene alloc] initWithSize:self.size];
            SKTransition *transition = [SKTransition flipVerticalWithDuration:0.5];
            
            [self.view presentScene:restartGame transition:transition];
            
        }
        
        //NSLog(@"position: %@", NSStringFromCGPoint(location));
    }
}



@end
