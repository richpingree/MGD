//
//  AchievementsViewController.h
//  MGDProject
//
//  Created by Richard Pingree on 9/22/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface AchievementsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *objectArray;
}
@property (weak, nonatomic) IBOutlet UITableView *achievementTableView;



@end
