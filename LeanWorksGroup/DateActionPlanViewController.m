//
//  DateActionPlanViewController.m
//  LeanWorksGroup
//
//  Created by Jazmin Hernandez on 12/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "DateActionPlanViewController.h"

@interface DateActionPlanViewController ()

@end

@implementation DateActionPlanViewController

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)cambiaFecha:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/MM/yyyy hh:mm"];
    NSString *stringFromDate = [formatter stringFromDate:_date.date];
    [_buttonFecha setTitle:stringFromDate forState:UIControlStateNormal];
}

@end
