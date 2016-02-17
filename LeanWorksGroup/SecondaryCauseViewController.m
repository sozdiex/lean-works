//
//  SecondaryCauseViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 21/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "SecondaryCauseViewController.h"

@interface SecondaryCauseViewController ()

@end

@implementation SecondaryCauseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    NSString *title = [[NSString alloc] initWithFormat:@"Agregar causas terciarias a: %@", self.secondaryCause];
    self.labelTitle.text = title;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
