//
//  AIRViewController.h
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIROpenWeatherMapConnector.h"

@interface AIRViewController : UIViewController <AIROpenWeatherMapConnectorDelegate>

- (void) openWeatherMapConnectionDidReceiveDataWithDictionary:(NSDictionary *)weatherDataDictionary;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImage;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *highTempLabel;
@property (weak, nonatomic) IBOutlet UILabel *lowTempLabel;

@end
