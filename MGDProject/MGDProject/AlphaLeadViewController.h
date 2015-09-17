//
//  AlphaLeadViewController.h
//  MGDProject
//
//  Created by Richard Pingree on 9/17/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AlphaLeadViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray *objectArray;
}
@property (weak, nonatomic) IBOutlet UITableView *leaderTableView;


@end
