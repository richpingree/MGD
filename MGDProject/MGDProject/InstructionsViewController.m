//
//  InstructionsViewController.m
//  MGDProject
//
//  Created by Richard Pingree on 8/25/15.
//  Copyright (c) 2015 Richard Pingree. All rights reserved.
//

#import "InstructionsViewController.h"

@interface InstructionsViewController ()

@end

@implementation InstructionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImage *howToPlayImage = [UIImage imageNamed:@"Instructions.png"];
    
    UIImageView *imageView = [[UIImageView alloc]initWithImage:howToPlayImage];
    imageView.frame =[[UIScreen mainScreen] bounds];
    
    [self.view addSubview:imageView];
    
    back = [[UIButton alloc] initWithFrame:CGRectMake(10.0f, 10.0f, 50.0f, 30.0f)];
    [back setTitle:@"Back" forState:UIControlStateNormal];
    
    [imageView addSubview:back];
    
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


- (IBAction)back:(id)sender {
}
@end
