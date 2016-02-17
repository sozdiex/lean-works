//
//  MenuViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 18/02/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "MenuViewController.h"
#import "ECSlidingViewController.h"

@interface MenuViewController ()

@property (strong, nonatomic) NSArray *subMenu1;
@property (strong, nonatomic) NSArray *subMenu2;

@end

@implementation MenuViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.subMenu1 = [NSArray arrayWithObjects:@"Inicio", nil];
    self.subMenu2 = [NSArray arrayWithObjects:@"Histórico", @"Flujos Pendientes" ,nil];
    [self.slidingViewController setAnchorRightRevealAmount:350.0f];
    self.slidingViewController.underLeftWidthLayout = ECFullWidth;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    int numRows = 0;
    if (section == 0) {
        numRows = (int)[self.subMenu1 count];
    } else if (section == 1) {
        numRows = (int)[self.subMenu2 count];
    }
    return numRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MenuCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.subMenu1 objectAtIndex:indexPath.row]];
        }
        return cell;
    }
    else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.subMenu2 objectAtIndex:indexPath.row]];
        }
        else if (indexPath.row == 1) {
            cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.subMenu2 objectAtIndex:indexPath.row]];
            
        }
        return cell;
    }
    return cell;
}

#pragma - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identificador;
    
    if(indexPath.section == 0) {
        if (indexPath.row == 0) {
            identificador = @"CompanySectorView";
        }
    } else if(indexPath.section == 1) {
        if (indexPath.row == 0) {
            identificador = @"HistoricalView";
        }
        if(indexPath.row ==1){
            identificador = @"FlujoPendienteView";
        }
    }
    
    NSString *indentifier = [NSString stringWithFormat:@"%@", identificador];
    UIViewController *newTopViewController = [self.storyboard instantiateViewControllerWithIdentifier:indentifier];
    [self.slidingViewController anchorTopViewOffScreenTo:ECRight animations:nil onComplete:^{
        CGRect frame = self.slidingViewController.topViewController.view.frame;
        self.slidingViewController.topViewController = newTopViewController;
        self.slidingViewController.topViewController.view.frame = frame;
        [self.slidingViewController resetTopView];
    }];
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Set the text color of our header/footer text.
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor whiteColor]];
    [header.textLabel setFont:[UIFont boldSystemFontOfSize:15.0]];
    
    // Set the background color of our header/footer.
UIColor * color = [UIColor colorWithRed:62/255.0f green:151/255.0f blue:54/255.0f alpha:1.0f];
    header.contentView.backgroundColor = color;//[UIColor darkGrayColor];
    
    // You can also do this to set the background color of our header/footer,
    //    but the gradients/other effects will be retained.
    // view.tintColor = [UIColor blackColor];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *tituloSeccion;
    if (section == 0) {
        tituloSeccion = @"inicio";
    } else if (section == 1) {
        tituloSeccion = @"Historial";
    }
    return tituloSeccion;
}
@end