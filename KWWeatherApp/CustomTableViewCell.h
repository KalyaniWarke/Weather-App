//
//  CustomTableViewCell.h
//  KWWeatherApp
//
//  Created by Kalyani on 19/10/16.
//  Copyright © 2016 kalyani Warke. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labelDays;

@property (weak, nonatomic) IBOutlet UILabel *labelMaxTemperature;
@property (weak, nonatomic) IBOutlet UILabel *labelMinTemperature;

@end
