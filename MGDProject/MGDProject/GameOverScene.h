//
//  GameOverScene.h
//  MGDProject
//
//  Created by Richard Pingree on 9/10/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface GameOverScene : SKScene <UITextFieldDelegate>
{
    
}
@property (nonatomic) IBOutlet UITextField *playerNameField;
@end
