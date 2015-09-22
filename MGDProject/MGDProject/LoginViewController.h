//
//  LoginViewController.h
//  MGDProject
//
//  Created by Richard Pingree on 9/21/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface LoginViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userNameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UITextField *reEnterPasswordField;
- (IBAction)signUpAction:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *loginUsernameField;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordField;
- (IBAction)loginButton:(id)sender;


@end
