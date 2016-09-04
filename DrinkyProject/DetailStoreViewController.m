//
//  DetailStoreViewController.m
//  DrinkyProject
//
//  Created by Thanh Tran Van on 11/20/15.
//  Copyright © 2015 ThanhTV. All rights reserved.
//

#import "DetailStoreViewController.h"
#import "LocalizableDefine.h"
#import "Define.h"

@interface DetailStoreViewController () {
    double latitude;
    double longtitude;
}

@end

@implementation DetailStoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:DetailStoreTitle];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1800, 1800);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    // Add an annotation
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = userLocation.coordinate;
    point.title = @"Where am I?";
    point.subtitle = @"I'm here!!!";
    
    [self.mapView addAnnotation:point];
}

@end
