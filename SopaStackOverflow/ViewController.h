//
//  ViewController.h
//  SopaStackOverflow
//
//  Created by spice on 17/06/15.
//  Copyright (c) 2015 SpiceDigital. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TBXML.h"

@interface ViewController : UIViewController
@property(retain,nonatomic)NSString *xmlString;

@property(nonatomic,retain)NSMutableData *webResponseData;

@end
