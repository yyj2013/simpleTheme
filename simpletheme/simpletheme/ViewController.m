//
//  ViewController.m
//  simpletheme
//
//  Created by csyyj on 16/8/11.
//  Copyright © 2016年 imudges. All rights reserved.
//

#import "ViewController.h"
#import "themeFramework.h"
#import "ThemeFrameworkInterface.h"
#import "GNDayNightManager.h"

#define RandomColorValue abs(rand()) % 256 / 256.0
#define RandomColor [UIColor colorWithRed:RandomColorValue green:RandomColorValue blue:RandomColorValue alpha:1]

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UIButton *themeButton;
@property (weak, nonatomic) IBOutlet UIView *themeView;
@property (weak, nonatomic) IBOutlet UILabel *themeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *themeImageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setDn_backgroundColorID:@"normalPageBackColor"];
    [self testTheme];
}

- (void)testTheme {
    [_themeLabel dn_setThemeChangeBlock:^(GNDayNightState state) {
        switch (state) {
            case GNDayNightDayState:
            {
                [_themeLabel setText:@"日间模式"];
                [_themeLabel sizeToFit];
            }
                break;
            case GNDayNightNightState:
            {
                [_themeLabel setText:@"夜间主题"];
                [_themeLabel sizeToFit];
            }
                break;
                
            default:
                break;
        }
    }];
    [_themeView dn_setThemeChangeBlock:^(GNDayNightState state) {
        [_themeView setBackgroundColor:RandomColor];
    }];
    [_themeButton dn_setThemeChangeBlock:^(GNDayNightState state) {
        switch (state) {
            case GNDayNightDayState:
            {
                [_themeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                [_themeButton setTitle:@"日间模式" forState:UIControlStateNormal];
            }
                break;
            case GNDayNightNightState:
            {
                [_themeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
                [_themeButton setTitle:@"夜间模式" forState:UIControlStateNormal];
            }
                break;
                
            default:
                break;
        }
    }];
    [_themeImageView dn_setImageId:@"video_tabbar"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)onThemeButtonClick:(id)sender {
    [GNDayNightManagerInstance switchState];
}

@end
