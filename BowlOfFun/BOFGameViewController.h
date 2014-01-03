//
//  BOFGameViewController.h
//  BowlOfFun
//
//  Created by Devon on 1/2/14.
//  Copyright (c) 2014 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>
@class BOFItem, BOFItemSubmitViewController, BOFGame;

@interface BOFGameViewController : UIViewController
{
    
    __weak IBOutlet UILabel *playerNumberLabel;
    
}

@property (nonatomic, weak) BOFGame * game;

- (id) initWithGame:(BOFGame *)theGame;

- (IBAction)playerSliderValueChanged:(id)sender;

- (IBAction)playButtonPressed:(id)sender;

@end
