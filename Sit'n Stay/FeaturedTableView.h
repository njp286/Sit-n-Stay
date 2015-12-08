//
//  FeaturedTableView.h
//  Sit'n Stay
//
//  Created by Nathaniel PiSierra on 11/27/15.
//  Copyright © 2015 Nathaniel PiSierra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeaturedTableView : UITableView

@property (nonatomic, strong) NSArray *Images;
@property (nonatomic, strong) NSArray *Title;
@property (nonatomic, strong) NSArray *Location;
@property (nonatomic, strong) NSArray *Bedrooms;

@end
