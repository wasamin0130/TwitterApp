//
//  TimelineViewController.m
//  TwitterApp
//
//  Created by sei on 2012/09/27.
//  Copyright (c) 2012年 sei. All rights reserved.
//

#import "TimelineViewController.h"
#import <Twitter/Twitter.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface TimelineViewController ()

@end

@implementation TimelineViewController

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
    
    ACAccountStore *accountStore = [[ACAccountStore alloc] init];
    ACAccountType *twitterAccountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    [accountStore requestAccessToAccountsWithType:twitterAccountType withCompletionHandler:^(BOOL granted, NSError *error)
     {
         if (!granted) {
             NSLog(@"ユーザーががアクセスを拒否しました。");
         } else {
             NSLog(@"ユーザーがアクセスを許可しました。");
             NSArray *twitterAccounts = [accountStore accountsWithAccountType:twitterAccountType];
             NSLog(@"twitterAccounts = %@", twitterAccounts);
             if ([twitterAccounts count] > 0) {
                 ACAccount *account = [twitterAccounts objectAtIndex:0];
                 NSLog(@"account = %@", account);
                 
                 NSURL *url = [NSURL URLWithString:@"http://api.twitter.com/1/statuses/home_timeline.json"];
                 TWRequest *request = [[TWRequest alloc] initWithURL:url
                                                          parameters:nil
                                                       requestMethod:TWRequestMethodGET];
                 
                 [request setAccount:account];
                 [request performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error)
                  {
                      if (!responseData) {
                          NSLog(@"%@", error);
                      } else {
                          NSLog(@"responseDat = %@", responseData);
                          
                          NSError *error;
                          NSArray *statuses = [NSJSONSerialization JSONObjectWithData:responseData
                                                                              options:NSJSONReadingMutableLeaves
                                                                                error:&error];
                          if (statuses) {
                              NSLog(@"%@", statuses);
                          } else {
                              NSLog(@"%@", error);
                          }
                      }
                  }];
             }
         }
     }];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

/*
 - (IBAction)pressComposeButton:(id)sender {
 if([TWTweetComposeViewController canSendTweet]){            // ツイートできるかどうかをチェックする
 TWTweetComposeViewController *composeViewController     //
 = [[TWTweetComposeViewController alloc] init];          // TWTweetComposeViewControllerオブジェクトを作成する
 [self presentModalViewController:composeViewController  //
 animated:YES];                  // TWTweetComposeViewControllerオブジェクトを表示する
 }                                                           //
 }
*/

- (IBAction)pressComposeButton:(id)sender {
    /*
    // ツイートできるかどうかをチェックする
    if ([TWTweetComposeViewController canSendTweet]) {
        // TWTweetComposeViewControllerオブジェクトを作成する
        TWTweetComposeViewController *composeViewController = [[TWTweetComposeViewController alloc] init];
        // TWTweetComposeViewControllerオブジェクトを表示する
        [self presentModalViewController:composeViewController animated:YES];
    }
    */
    
    SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeTwitter];
    [self presentViewController:controller animated:YES completion:nil];
}
@end
