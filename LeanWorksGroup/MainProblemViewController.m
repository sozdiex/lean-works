//
//  MainProblemViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 17/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "MainProblemViewController.h"
#import "ParetoViewController.h"
#import "RoketFetcher.h"
#import "CustomAlertViewController.h"

@interface MainProblemViewController ()

@end

@implementation MainProblemViewController

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
    self.buttonNext.layer.borderWidth = 1.0f;
    self.buttonNext.layer.cornerRadius = 7.0f;
    self.buttonNext.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    if([self.dicPareto objectForKey:@"mainProblem"])
        self.textProblemName.text = [self.dicPareto objectForKey:@"mainProblem"];
    
    if(self.historico){
        self.textProblemName.enabled = NO;
    }else{
        self.textProblemName.enabled = YES;
    }
    //[self hardcode];
    //Traduccion
    self.textProblemName.placeholder = NSLocalizedString(@"txtField", nil);
    self.lblQuestion.text = NSLocalizedString(@"lblQuestion", nil);
    [self.buttonNext setTitle:NSLocalizedString(@"btnSiguiente", nil) forState:UIControlStateNormal];
    [self.buttonBack setTitle:NSLocalizedString(@"btnBack", nil)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Hardcode

- (void)hardcode {
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Servicios"]) {
        self.textProblemName.text = @"Flujo de efectivo";
    }
    else if ([[ud objectForKey:@"seleccion"] isEqualToString:@"Manufactura"]) {
        self.textProblemName.text = @"Calidad en los productos";
    }
}

#pragma mark - IBAction

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextStep:(id)sender {
    if(self.textProblemName.text.length !=0){
        ParetoViewController *pvc = [self.storyboard instantiateViewControllerWithIdentifier:@"ParetoView"];
        //pvc.mainProblem = self.textProblemName.text;
        [self.dicPareto setObject:self.textProblemName.text forKey:@"mainProblem"];
        
        if(!self.historico){
            RoketFetcher *roket = [[RoketFetcher alloc]init];
            self.dicPareto = [roket nameJSON:self.dicPareto];
            [RoketFetcher createJson:self.dicPareto :Nil :@"ParetoView"];
        }
        
        pvc.dicPareto = self.dicPareto;
        pvc.historico = self.historico;
        [self presentViewController:pvc animated:YES completion:nil];
    }
    else{
        CustomAlertViewController* vc = [CustomAlertViewController new];
        vc.text = NSLocalizedString(@"Ingrese la descripción de su problema",nil);
        [self presentViewController:vc animated:YES completion:nil];
    }
}

/*#pragma mark - TableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = self.questionCell;
            break;
        }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}*/

#pragma mark - UIStyle

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
