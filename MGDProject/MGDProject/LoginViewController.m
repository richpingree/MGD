//
//  LoginViewController.m
//  MGDProject
//
//  Created by Richard Pingree on 9/21/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)signUpAction:(id)sender {
    [_userNameField resignFirstResponder];
    [_passwordField resignFirstResponder];
    [_reEnterPasswordField resignFirstResponder];
    
    [self checkFieldComplete];
    _loginUsernameField.text = nil;
    _loginPasswordField.text = nil;
    _userNameField.text = nil;
    _passwordField.text = nil;
    _reEnterPasswordField.text =  nil;
    
}

-(void) checkFieldComplete{
    if ([_userNameField.text isEqualToString:@""] || [_passwordField.text isEqualToString:@""] || [_reEnterPasswordField.text isEqualToString:@""]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"All Fields are required." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        [self checkPasswordMatch];
    }
}

-(void) checkPasswordMatch{
    if (![_passwordField.text isEqualToString:_reEnterPasswordField.text]) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Passwords don't match." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    }
    else{
        [self signUpNewUser];
    }
}

-(void) signUpNewUser {
    PFUser *newUser = [PFUser user];
    newUser.username = _userNameField.text;
    newUser.password = _passwordField.text;
    
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        if (!error) {
            NSLog(@"Sign Up Success!");
            [self performSegueWithIdentifier:@"login" sender:self];
        }
        else{
            NSLog(@"Error on Sign Up.");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Username already exists." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}
- (IBAction)loginButton:(id)sender {
    
    [PFUser logInWithUsernameInBackground:_loginUsernameField.text password:_loginPasswordField.text block:^(PFUser *user, NSError *error){
        if (!error) {
            NSLog(@"Login Successful!");
            _loginUsernameField.text = nil;
            _loginPasswordField.text = nil;
            _userNameField.text = nil;
            _passwordField.text = nil;
            _reEnterPasswordField.text =  nil;
            [self performSegueWithIdentifier:@"login" sender:self];
            
        }
        if (error) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ooops!" message:@"Check Username or Password." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }];
}

- (IBAction)LogoutButton:(id)sender {
    [PFUser logOut];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"You have been Logged out!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];

}
@end
