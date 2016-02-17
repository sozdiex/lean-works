//
//  HistoricalViewController.m
//  LeanWorksGroup
//
//  Created by Jesús Ruiz on 12/03/14.
//  Copyright (c) 2014 Roket. All rights reserved.
//

#import "HistoricalViewController.h"
#import "ECSlidingViewController.h"
#import "MenuViewController.h"
#import "RoketFetcher.h"
#import "CompanySectorViewController.h"
#import <MessageUI/MessageUI.h>
#import "CustomAlertViewController.h"

@interface HistoricalViewController (){
    NSMutableDictionary *dicPareto;
    NSMutableDictionary *dicIshikawa;
    RoketFetcher *roket;
}

@property (strong, nonatomic) NSMutableArray *problemsArray;

@end

@implementation HistoricalViewController

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
    [self.problemButton setTitle:NSLocalizedString(@"ver problema", nil) forState:UIControlStateNormal];
    self.problemButton.layer.borderWidth = 1.0f;
    self.problemButton.layer.cornerRadius = 7.0f;
    self.problemButton.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];

    [self.btnSendEmail setTitle:NSLocalizedString(@"Enviar por correo", nil) forState:UIControlStateNormal];
    self.btnSendEmail.layer.borderWidth = 1.0f;
    self.btnSendEmail.layer.cornerRadius = 7.0f;
    self.btnSendEmail.layer.borderColor = [[UIColor colorWithRed:(73.0/255.0) green:(155.0/255.0) blue:(58.0/255.0) alpha:1.0] CGColor];
    
    self.lblTitle.text = NSLocalizedString(@"Historico", nil);
    
    if (![self.slidingViewController.underLeftViewController isKindOfClass:[MenuViewController class]]) {
        self.slidingViewController.underLeftViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuView"];
    }
    
    [self.view addGestureRecognizer:self.slidingViewController.panGesture];
    roket = [[RoketFetcher alloc]init];
    self.problemsArray = [roket leerProblemas];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - IBAction

- (IBAction)showMenu:(id)sender {
    [self.slidingViewController anchorTopViewTo:ECRight];
}

- (IBAction)showProblem:(id)sender {
    if(dicPareto){
        CompanySectorViewController *csvc = [self.storyboard instantiateViewControllerWithIdentifier:@"CompanySectorView"];
        csvc.dicPareto = dicPareto;
        csvc.historico = YES;
        self.slidingViewController.topViewController = csvc;
    }
}

- (IBAction)sendEmail:(id)sender {
    //Create pdf
    if([dicIshikawa count] > 0){
        NSString *pdfPath = [roket makePdf:[dicIshikawa objectForKey:@"actionArray"]];
    
        NSString *emailTitle = NSLocalizedString(@"Jade lean - Analisis de fallas",nil);
        NSString *messageBody = NSLocalizedString(@"se adjunta un pdf con el Analisis de fallas",nil);
       //NSArray *toRecipents = [NSArray arrayWithObject:@"armandotr13@gmail.com"];

        if([MFMailComposeViewController canSendMail]){
            MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
            mc.mailComposeDelegate = (id<MFMailComposeViewControllerDelegate>)self;
            [mc setSubject:emailTitle];
            [mc setMessageBody:messageBody isHTML:NO];
            //[mc setToRecipients:toRecipents];
            
            NSData *fileData = [NSData dataWithContentsOfFile:pdfPath];
            
            // Add attachment
            [mc addAttachmentData:fileData mimeType:@"application/pdf" fileName:@"jade lean"];
            

            [self presentViewController:mc animated:YES completion:NULL];
        }else{
            CustomAlertViewController* vc = [CustomAlertViewController new];
            vc.text = NSLocalizedString(@"Configure una cuenta en Mail para enviar correo electrónico.",nil);
            [self presentViewController:vc animated:YES completion:nil];

            return;
        }

    }
}

#pragma mark - delegate Send Mail
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail sent failure: %@", [error localizedDescription]);
            break;
        default:
            break;
    }
    // Close the Mail Interface
    [self dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.problemsArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProblemCell" forIndexPath:indexPath];
    NSMutableDictionary *data = [self.problemsArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [data objectForKey:@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    NSMutableDictionary *data = [self.problemsArray objectAtIndex:indexPath.row];
    dicPareto = [roket leerPareto:[[data objectForKey:@"id_problema"] integerValue]];
    dicIshikawa = [roket leerIshikawa:[[data objectForKey:@"id_problema"] integerValue]];
    
    if([dicIshikawa count] > 0)
        [dicPareto setObject:dicIshikawa forKey:@"dicIshikawa"];
    else
        [dicPareto setObject:[NSNumber numberWithBool:NO] forKey:@"TypeUsser"];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return NSLocalizedString(@"problemas", nil);
}

@end
