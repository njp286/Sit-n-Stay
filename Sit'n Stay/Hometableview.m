//
//  HomeTableView.m
//  Sit'n Stay
//
//  Created by Nathaniel PiSierra on 11/27/15.
//  Copyright © 2015 Nathaniel PiSierra. All rights reserved.
//

#import "HomeTableView.h"
#import "HomeTableCell.h"


@interface HomeTableView ()

@end

@implementation HomeTableView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;



}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"HomeTableCell";
    HomeTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];

    NSInteger row = [indexPath row];
    
    
    @try{
        NSString *urlString = @"http://localhost/FeaturedHome.php";
        NSURL *url = [NSURL URLWithString:urlString];
        
        // rather than using `dataWithContentsOfURL`, let's use NSURLConnection to do an asynchronous request,
        // so that the request doesn't block the main queue
        
        // first, make the NSURLRequest
        
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        
        // now, let's send that request asynchronously
        
        [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
            
            // first, check to see if there was an error with sendAsynchronousRequest
            
            if (connectionError) {
                NSLog(@"%s: sendAsynchronousRequest error: %@", __FUNCTION__, connectionError);
                return;
            }
            
            // you generally don't do this conversion of the data to a string,
            // but it's useful to use this technique if you are diagnosing problems with your JSON
            //
            //NSString *jsonString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            //NSLog(@"%s: raw JSON = %@", __FUNCTION__, jsonString);
            
            // now, let's parse the JSON
            
            NSError *parseError = nil;
            
            NSData *jasonData = [NSData dataWithContentsOfURL:url];
            NSDictionary *results = nil;
            NSError *e = nil;
            NSArray *arrayResults = [NSJSONSerialization JSONObjectWithData:jasonData options:NSJSONReadingMutableContainers error: &e];
        
            
            //need to find a way to make it so you can look at the index of the array and select the correct dictionary and then get the value for key
            
            NSMutableArray* imgUrlArray = [[NSMutableArray alloc] init];
            NSMutableArray* TitleArray = [[NSMutableArray alloc] init];
            NSMutableArray* BedroomsArray = [[NSMutableArray alloc] init];
            NSMutableArray* LocationArray = [[NSMutableArray alloc] init];
            
            for (int x = 0; x < arrayResults.count; x++) {
                NSDictionary *userName = [arrayResults objectAtIndex:x];
                
                NSString *imgUrl = [userName valueForKey:@"imgUrl"];
                
                
                NSString *location = [userName valueForKey:@"location"];
                NSString *title = [userName valueForKey:@"title"];
                NSString *bedrooms = [userName valueForKey:@"bedrooms"];
                
                if (parseError) {
                    NSLog(@"%s: JSONObjectWithData error: %@", __FUNCTION__, parseError);
                    return;
                }
                
                NSNumber *status   = results[@"status"];
                NSLog(@"%s: status = %@; imgUrl = %@", __FUNCTION__, status, imgUrl);
                
                NSURL *url = [NSURL URLWithString:imgUrl];
                NSData *data1 = [[NSData alloc] initWithContentsOfURL:url];
                UIImage *image = [UIImage imageWithData:data1];
                [imgUrlArray addObject:image];
                [TitleArray addObject:title];
                [BedroomsArray addObject:bedrooms];
                [LocationArray addObject:location];
            }
            
           
                cell.TitleLabel.text = TitleArray[row];//bedrooms;
                cell.BedroomLabel.text = BedroomsArray[row];//bathrooms;
                cell.LocationLabel.text = LocationArray[row];//location;
                cell.ThumbnailImg.image = imgUrlArray[row];//[UIImage imageNamed:_Images[row]];
                

            
            
            
        }];
    }@catch (NSException * e) {
        NSLog(@"Exception: %@", e);
    }
    
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
