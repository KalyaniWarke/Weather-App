//
//  ViewController.h
//  KWWeatherApp
//
//  Created by Kalyani on 17/10/16.
//  Copyright © 2016 kalyani Warke. All rights reserved.
//

#define kWeatherAPIKey @"de2dfb7b93221901e921d3e0f0b8a71f"
#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import <CoreLocation/CoreLocation.h>
@interface ViewController : UIViewController<CLLocationManagerDelegate,UITableViewDelegate,UITableViewDataSource>

{
    NSMutableArray *forcast;
//    NSArray *array7days;
    NSString *kLatitude;
    NSString *kLongitude;
    CLLocationManager *locationManager;
    NSString *maxTemperature;
    NSMutableArray *myArray;
    NSDictionary *maxTemp;
}
@property (weak, nonatomic) IBOutlet UILabel *labelCity;

@property (weak, nonatomic) IBOutlet UILabel *labelTemperature;

@property (weak, nonatomic) IBOutlet UILabel *labelCondition;

- (IBAction)getWeatherAction:(id)sender;

@property (weak, nonatomic) IBOutlet UITableView *myTableView;




@end

