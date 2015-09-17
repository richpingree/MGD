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
    NSInteger score;
    //UITextField *playerNameField;
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
        score = [prefs integerForKey:@"score"];
        
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
    _playerNameField = [[UITextField alloc]initWithFrame:CGRectMake(lostGame.position.x, lostGame.position.y - 100, 250, 60)];
    _playerNameField.center = self.view.center;
    _playerNameField.borderStyle = UITextBorderStyleRoundedRect;
    _playerNameField.textColor = [UIColor blackColor];
    _playerNameField.font = [UIFont systemFontOfSize:30.0];
    _playerNameField.placeholder = @"Enter Name";
    _playerNameField.backgroundColor = [UIColor whiteColor];
    _playerNameField.autocorrectionType = UITextAutocorrectionTypeYes;
    _playerNameField.keyboardType = UIKeyboardTypeDefault;
    _playerNameField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _playerNameField.delegate = self;
    
    [self.view addSubview:_playerNameField];

}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        SKNode *node = [self nodeAtPoint:location];
        if ([node.name isEqualToString:@"restartNode"]) {
            PFObject *newScore = [PFObject objectWithClassName:@"Leaderboard"];
            NSNumber *parseScore = [NSNumber numberWithInteger:score];
            newScore[@"Name"] = _playerNameField.text;
            newScore[@"Score"] = parseScore;
            [newScore saveEventually:^(BOOL succeeded, NSError *error){
                if (succeeded){
                    SKScene *restartGame = [[GameScene alloc] initWithSize:self.size];
                    SKTransition *transition = [SKTransition flipVerticalWithDuration:0.5];
                    
                    [self.view presentScene:restartGame transition:transition];
                    [_playerNameField removeFromSuperview];
                    
                } else{
                    //There was a problem, check error.description
                    NSLog(@"Error sending Score");
                    
                }
            }];
            
//            SKScene *restartGame = [[GameScene alloc] initWithSize:self.size];
//            SKTransition *transition = [SKTransition flipVerticalWithDuration:0.5];
//            
//            [self.view presentScene:restartGame transition:transition];
            
        }
        
        //NSLog(@"position: %@", NSStringFromCGPoint(location));
    }
}



@end
