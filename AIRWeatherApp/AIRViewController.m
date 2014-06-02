//
//  AIRViewController.m
//  AIRWeatherApp
//
//  Created by Jonathan Fisher on 5/28/14.
//  Copyright (c) 2014 AirWatch. All rights reserved.
//

#import "AIRViewController.h"
#import "AIRTemperatureConverter.h"

static NSString * const kImageFetchURL = @"http://openweathermap.org/img/w/%@.png";
static NSString * const kPlaceName = @"Atlanta,GA";

@interface AIRViewController ()

@property (nonatomic, strong) AIROpenWeatherMapConnector *openWeatherMapConnector;
@property (nonatomic, strong) NSDictionary *mainDictionary;

@end

@implementation AIRViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.openWeatherMapConnector = [AIROpenWeatherMapConnector new];
    self.openWeatherMapConnector.delegate = self;
    [self.openWeatherMapConnector openNewConnectionWithPlaceString:kPlaceName];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) openWeatherMapConnectionDidReceiveData
{
    //Don't need dict
    self.currentTempLabel.text = [NSString stringWithFormat:@"%.0f",self.openWeatherMapConnector.currentTemp];
    self.highTempLabel.text = [NSString stringWithFormat:@"%.0f",self.openWeatherMapConnector.maxTemp];
    self.lowTempLabel.text = [NSString stringWithFormat:@"%.0f",self.openWeatherMapConnector.minTemp];
    
    NSData *imageData = [NSData dataWithContentsOfURL:self.openWeatherMapConnector.weatherIconURL];
    
    UIImage *image = [[UIImage alloc] initWithData:imageData];
    
    self.weatherImage.image = image;
}

@end
