//
//  ViewControllerSignUp.h
//  Sit'n Stay
//
//  Created by Nathaniel PiSierra on 11/24/15.
//  Copyright © 2015 Nathaniel PiSierra. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewControllerSignUp : UIViewController <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textEmail;

@property (weak, nonatomic) IBOutlet UITextField *textPassword;

- (IBAction)showBackground:(id)sender;

- (IBAction)signUpClicked:(id)sender;


@end
