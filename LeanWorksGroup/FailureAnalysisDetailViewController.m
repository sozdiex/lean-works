//
//  FailureAnalysisDetailViewController.m
//  LeanWorksGroup
//
//  Created by Jazmin Hernandez on 06/05/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "FailureAnalysisDetailViewController.h"
#import "FailureAnalysisViewController.h"

@interface FailureAnalysisDetailViewController ()
    
@end

@implementation FailureAnalysisDetailViewController

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
    self.buttonSave.layer.borderWidth = 1.0f;
    self.buttonSave.layer.cornerRadius = 7.0f;
    self.buttonSave.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    NSMutableDictionary *data = [self.failuresArray objectAtIndex:self.index];
    self.why1.text = [data objectForKey:@"why1"];
    self.why2.text = [data objectForKey:@"why2"];
    self.why3.text = [data objectForKey:@"why3"];
    self.why4.text = [data objectForKey:@"why4"];
    self.why5.text = [data objectForKey:@"why5"];
    
    self.why1.delegate = self;
    self.why2.delegate = self;
    self.why3.delegate = self;
    self.why4.delegate = self;
    self.why5.delegate = self;
    
    //Traduccion
    [self.buttonCancel setTitle:NSLocalizedString(@"Cancelar", nil)];
    [self.buttonSave setTitle:NSLocalizedString(@"Guardar", nil) forState:UIControlStateNormal];

}

- (void)viewDidAppear:(BOOL)animated {
    [self loadView];
    NSMutableDictionary *data = [self.failuresArray objectAtIndex:self.index];
    self.why1.text = [data objectForKey:@"why1"];
    self.why2.text = [data objectForKey:@"why2"];
    self.why3.text = [data objectForKey:@"why3"];
    self.why4.text = [data objectForKey:@"why4"];
    self.why5.text = [data objectForKey:@"why5"];

    //Traduccion
    [self.buttonCancel setTitle:NSLocalizedString(@"Cancelar", nil)];
    [self.buttonSave setTitle:NSLocalizedString(@"Guardar", nil) forState:UIControlStateNormal];
    [self.lblCausa setText:[NSString stringWithFormat:NSLocalizedString(@"Causa Raíz: %@",nil), self.causeName]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - TextField

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [textField selectAll:self];
}

#pragma mark - IBAction

- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)saveDetail:(id)sender {
    
    NSMutableDictionary *data = [[NSMutableDictionary alloc] init];
    
    [data setValue:self.causeName forKey:@"name"];
    [data setValue:self.why1.text forKey:@"why1"];
    [data setValue:self.why2.text forKey:@"why2"];
    [data setValue:self.why3.text forKey:@"why3"];
    [data setValue:self.why4.text forKey:@"why4"];
    [data setValue:self.why5.text forKey:@"why5"];
    [self.failuresArray replaceObjectAtIndex:self.index withObject:data];
    FailureAnalysisViewController *favc = [[FailureAnalysisViewController alloc] init];
    favc.failuresArray = self.failuresArray;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

/*#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64.0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:NSLocalizedString(@"Causa Raíz: %@",nil), self.causeName];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell;
    switch (indexPath.row) {
        case 0:
            cell = self.why1Cell;
            break;
        case 1:
            cell = self.why2Cell;
            break;
        case 2:
            cell = self.why3Cell;
            break;
        case 3:
            cell = self.why4Cell;
            break;
        case 4:
            cell = self.why5Cell;
            break;
    }
    return cell;
}*/

#pragma mark - UI Style

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end



