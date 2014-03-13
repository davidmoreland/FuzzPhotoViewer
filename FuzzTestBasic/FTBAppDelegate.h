//
//  FTBAppDelegate.h
//  FuzzTestBasic
//
//  Created by Dave on 3/10/14.
//  Copyright (c) 2014 David Moreland. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FTBAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;


//Model
@property (readonly, strong, nonatomic) NSManagedObjectContext *appDataMOC;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong, nonatomic) NSArray *mainFuzzDataArray;
//@property (strong, nonatomic) NS
@property (strong, nonatomic) NSMutableArray *photoArray;

@end
