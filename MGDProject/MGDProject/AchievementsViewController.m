//
//  AchievementsViewController.m
//  MGDProject
//
//  Created by Richard Pingree on 9/22/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import "AchievementsViewController.h"

#import <Parse/Parse.h>

@interface AchievementsViewController ()

@end

@implementation AchievementsViewController

@synthesize achievementTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    objectArray = [NSMutableArray new];
    
    [self performSelector:@selector(retrieveFromParse)];

}

-(void) retrieveFromParse{
    PFQuery *retrieveObjects = [PFQuery queryWithClassName:@"Achievements"];
    //[retrieveObjects orderByDescending:@"Score"];
    
    [retrieveObjects findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error){
        if (!error) {
            objectArray = [[NSMutableArray alloc] initWithArray:objects];
            
            [achievementTableView reloadData];
        }
    }];
}

-(void) tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [objectArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"myCell"];
    
    if (cell != nil) {
        PFObject *tempObject = [objectArray objectAtIndex:indexPath.row];
        
        cell.textLabel.text = [tempObject objectForKey:@"Name"];
        //cell.detailTextLabel.text = [NSString stringWithFormat:@"%@",[tempObject objectForKey:@"Score"]];
    }
    return cell;
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

@end
