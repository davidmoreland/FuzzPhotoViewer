//
//  DCM Core Data Manager
//
//
// Function: Manages Core-Data Stack
//
//  Created by David Moreland on 8/29/13.
//  Copyright (c) David Moreland 8/29/13


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface DCMCoreDataManager : NSObject
@property (nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCordinator;
@property (nonatomic, strong) NSManagedObjectContext *appDataMOC;
@property (nonatomic, strong) NSManagedObjectContext *userDataMOC;
@property (nonatomic, strong) NSManagedObject *managedObject;
@property (nonatomic, strong) NSPersistentStore *userDataDBStore;
@property (nonatomic, strong) NSPersistentStore *appDataStore;

- (NSURL *)applicationDocumentsDirectory;

-(BOOL)createAppDataBase;
//- (void)saveContext;
- (NSString *) copyFileInBundleToDocumentsFolder:(NSString *) fileName withExtension:(NSString *) ext;
- (NSString *) copyFileInBundleToAppDataFolder:(NSString *) fileName withExtension:(NSString *) ext;

- (void) removeDataBase:(NSString *) DBPath;

+(NSManagedObjectContext *)getUserContext;
+(BOOL)save2DB:(NSManagedObjectContext *)context;

- (NSManagedObjectContext *)userMOC;
- (NSManagedObjectModel *)managedObjectModel;
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator;

@end
