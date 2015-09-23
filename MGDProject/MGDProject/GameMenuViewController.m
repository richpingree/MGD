//
//  GameMenuViewController.m
//  MGDProject
//
//  Created by Richard Pingree on 8/25/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import "GameMenuViewController.h"

@interface GameMenuViewController ()

@end

@implementation GameMenuViewController

UIButton *InstructionBtn, *PlayBtn, *CreditsBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskLandscapeLeft;
    }
    else {
        return UIInterfaceOrientationMaskLandscape;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)InstructionBtn:(id)sender {
}

- (IBAction)PlayBtn:(id)sender {
   // NSLog(@"Button Pressed");
    
    //Completion Achievement
    NSString *currentUser = [[PFUser currentUser] objectForKey:@"username"];
    
    PFObject *newAchievement = [PFObject objectWithClassName:@"Achievements"];
    newAchievement[@"Name"] = @"Played First Game";
    newAchievement[@"User"] = currentUser;
    [newAchievement saveEventually:^(BOOL succeeded, NSError *error){
        if (succeeded) {
            //NSLog(@"Achievement Earned");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Achievement!" message:@"First Game Played." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];

        }
        else{
            //NSLog(@"Achievement Not Earned");
        }
    }];
}

- (IBAction)Credits:(id)sender {
}
@end
