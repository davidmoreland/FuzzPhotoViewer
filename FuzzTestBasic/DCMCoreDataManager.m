//
//  DCM Core Data Manager
//
//
//
// Function: Manages Core-Data Stack
//
//  Created by David Moreland on 8/29/13.
//  Copyright (c) 2013 David Moreland

#import "FTBAppDelegate.h"
#import "DCMCoreDataManager.h"
#import <CoreData/CoreData.h>

#import "FTBConstants.h"

// Do Not backup App Data Database

@interface DCMCoreDataManager()

@end

@implementation DCMCoreDataManager


// Not Used in Test App
/*
- (BOOL)addSkipBackupAttributeToItemAtURL:(NSURL *)URL
{
	
    assert([[NSFileManager defaultManager] fileExistsAtPath: [URL path]]);
	
    NSError *error = nil;
	
    BOOL success = [URL setResourceValue: @YES forKey: NSURLIsExcludedFromBackupKey error: &error];
	
	// if(!success){
	//
    // NSLog(@"Error excluding %@ from backup %@", [URL lastPathComponent], error);
    
	//  }
	
    return success;
	
}
***/

- (NSString *) copyFileInBundleToDocumentsFolder:(NSString *) fileName withExtension:(NSString *) ext {
    // NSLog(@" Entering %s" , __FUNCTION__);
    
    //---get the path of the Documents folder--
    // -- Database copy to Library DIR
    NSArray *paths = NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES);
    
	
	
	//NSString *documentsDirectory = paths[0] ;
	// Library Private DIR version 1.1.0
	NSString *dataDirectory = paths[0] ;
	
    dataDirectory = [dataDirectory stringByAppendingPathComponent:@"Data"];
    
    // NSLog(@"++++++++++++++++++++++++++++++++++++++++++");
    // NSLog(@"DATA DIR: copyFileInBundle %@",dataDirectory);
    // NSLog(@"++++++++++++++++++++++++++++++++++++++++++");
    
    //---get the path to the file you want to copy in the Documents folder--    was documentsDirectory
    NSString *filePath = [dataDirectory stringByAppendingPathComponent: [NSString stringWithString:fileName]] ;
	
	//	[DatabaseUpdater CheckNewOrUpdate:filePath];
	
	// Mark as Do NOT BACK UP  -- data storage guidelines
    
    //     filePath = [filePath stringByAppendingString: @”.”];
    
	// removed next two ' version 1.1.0 - moved DB to Library/Data
    filePath = [filePath stringByAppendingString:@"."];
    filePath = [filePath stringByAppendingString: ext] ;
    //---check if file is already in Documents folder,
    // if not, copy it from the bundle--
    NSFileManager *fileManager = [NSFileManager defaultManager] ;
	
	// create Directory
	// from stack overflow
	if(![fileManager fileExistsAtPath:dataDirectory]) //  ]isDirectory:&isDir])
		if(![fileManager createDirectoryAtPath:dataDirectory withIntermediateDirectories:YES attributes:nil error:NULL])
			// NSLog(@"Error: Create folder failed %@", dataDirectory);
	// end create Data DIR
    
    if (![fileManager fileExistsAtPath:filePath] ) {
        //---get the path of the file in the bundle--
        NSString *pathToFileInBundle = [[NSBundle mainBundle] pathForResource:fileName ofType:ext] ;
        //---copy the file in the bundle to the Documents folder--
        
        NSError *error = nil;
        bool success =  [fileManager copyItemAtPath:pathToFileInBundle toPath:filePath error: &error] ;
        
        if (success)
        {
            // NSLog(@"File: %@ Copied to LIBRARY DIR", fileName);
        }
        else {
            // NSLog(@"File: %@  NOT Copied: Error %@",fileName, [error localizedDescription]);
            
        }
        // // // NSLog(@"DB Exists - NOT COPIED");
    }
    return filePath;
}


- (NSString *) copyFileInBundleToAppDataFolder:(NSString *) fileName withExtension:(NSString *) ext {
    // NSLog(@" Entering %s" , __FUNCTION__);
    
	//---get the path of the Documents folder--
	// -- Database copy to Library DIR
	//   NSArray *paths = NSSearchPathForDirectoriesInDomains (NSDocumentDirectory, NSUserDomainMask, YES);
	NSArray *paths = NSSearchPathForDirectoriesInDomains (NSLibraryDirectory, NSUserDomainMask, YES);
    
	
	//NSString *documentsDirectory = paths[0] ;
	// Library Private DIR version 1.1.0
	NSString *dataDirectory = paths[0] ;
	
	dataDirectory = [dataDirectory stringByAppendingPathComponent:@"Data"];
    
	// NSLog(@"++++++++++++++++++++++++++++++++++++++++++");
	// NSLog(@"DATA DIR: copyFileInBundle %@",dataDirectory);
	// NSLog(@"++++++++++++++++++++++++++++++++++++++++++");
    
	//---get the path to the file you want to copy ito DATA folder--    was documentsDirectory
    NSString *filePath = [dataDirectory stringByAppendingPathComponent: [NSString stringWithString:fileName]] ;
	
	// Mark as Do NOT BACK UP  -- data storage guidelines
    //     filePath = [filePath stringByAppendingString: @”.”];
	
	// removed next two ' version 1.1.0 - moved DB to Library/Data
	filePath = [filePath stringByAppendingString:@"."];
	filePath = [filePath stringByAppendingString: ext] ;
	//---check if file is already in Documents folder,
	// if not, copy it from the bundle--
	
	// CHECK FOR NEW INSTAL
	//	************************
	//	BOOL *updateFlag = [DatabaseUpdater CheckNewOrUpdate:dataDirectory];
	
    //**************************
    
	
	NSFileManager *fileManager = [NSFileManager defaultManager] ;
	
	// create Directory
	// from stack overflow
	if(![fileManager fileExistsAtPath:dataDirectory])
		
		
        //  ]isDirectory:&isDir])
		if(![fileManager createDirectoryAtPath:dataDirectory withIntermediateDirectories:YES attributes:nil error:NULL])
			// NSLog(@"Error: Create folder failed %@", dataDirectory);
	// end create Data DIR
	
    
    if (![fileManager fileExistsAtPath:filePath] ) {
        //---get the path of the file in the bundle--
        NSString *pathToFileInBundle = [[NSBundle mainBundle] pathForResource:fileName ofType:ext] ;
        //---copy the file in the bundle to the Documents folder--
        
        NSError *error = nil;
        bool success =  [fileManager copyItemAtPath:pathToFileInBundle toPath:filePath error: &error] ;
        
        if (success)
        {
			// NSLog(@"File: %@ Copied to LIBRARY DIR", fileName);
            /****
             if(updateFlag == FALSE)
             {
             // Record Database Version #
             //	DatabaseUpdater *databaseUpdater = [[DatabaseUpdater alloc] init];
             
             //	[databaseUpdater setDataBaseVersion:managedObjectContext_];
             
             
             }
             ******/
        }
        else {
			// NSLog(@"File: %@  NOT Copied: Error %@",fileName, [error localizedDescription]);
			
        }
		
        // // // NSLog(@"DB Exists - NOT COPIED");
	}
    return filePath;
}



- (void) removeDataBase:(NSString *) DBPath
{
    // NSLog(@" Entering %s" , __FUNCTION__);
    // Create a new instance of the entity managed by the fetched results controller.
    
    // NSLog(@"++++++++++++++++++++++++++++++++++++++++++");
    // NSLog(@"DataBase Path %@:",DBPath);
    // NSLog(@"++++++++++++++++++++++++++++++++++++++++++");
    
    //---check if file is in Documents folder,
    
    NSFileManager *fileManager = [NSFileManager defaultManager] ;
    if ([fileManager fileExistsAtPath:DBPath] ) {
        
        // if YES, DELETE IT! --
    
		//     NSError *error = nil;
        bool success =  [[NSFileManager defaultManager] removeItemAtPath:DBPath error:nil];
        
        if (success)
        {
            // // NSLog(@"File: %@ Deleted From DOC DIR", DBPath);
        }
        else {
            // // NSLog(@"%@", [error localizedDescription]);
            
        }
    }
	//   exit(0);
}


- (void)saveAppDataContext {
    // // // NSLog(@" Entering %s" , __FUNCTION__);
    
    NSError *error = nil;
//	NSManagedObjectContext *managedObjectContext = _appDataMOC;
    if (_appDataMOC != nil) {
        if ([_appDataMOC hasChanges] && ![_appDataMOC save:&error]) {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate.
			 You should not use this function in a shipping application, although it may be useful during development.
			 If it is not possible to recover from the error, display an alert panel that instructs the user to quit
			 the application by pressing the Home button.
             */
            // // // NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}


#pragma mark -
#pragma mark Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)appDataMOC {
    // NSLog(@" Entering %s" , __FUNCTION__);
    
    if (_appDataMOC != nil) {
        return _appDataMOC;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _appDataMOC = [[NSManagedObjectContext alloc] init];
        [_appDataMOC setPersistentStoreCoordinator:coordinator];
    }
    
    //DEBUG
    // NSLog(@"CDM: appDataM)C: %@", _appDataMOC);
    
    return _appDataMOC;
}

// Second Context USER
- (NSManagedObjectContext *)userMOC {
	// NSLog(@" Entering %s" , __FUNCTION__);
	
    if (_userDataMOC != nil) {
        return _userDataMOC;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _userDataMOC = [[NSManagedObjectContext alloc] init];
        [_userDataMOC setPersistentStoreCoordinator:coordinator];
    }
    //DEBUG
    // NSLog(@"CDM: userDataMOC: %@", _userDataMOC);
    
    return _userDataMOC;
}


/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel {
    // NSLog(@" Entering %s" , __FUNCTION__);
    
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSString *modelPath = [[NSBundle mainBundle] pathForResource:@"FuzzTestBasic" ofType:@"momd"];
    NSURL *modelURL = [NSURL fileURLWithPath:modelPath];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
    
     //DEBUG
    // NSLog(@"++++++++++++++++++++++++++++++++++++++++++++");
    // NSLog(@"DataBase Path: %@", modelPath);
    // NSLog(@"++++++++++++++++++++++++++++++++++++++++++++");
    // NSLog(@"CDM: Managed Object Model: %@", _managedObjectModel);

    return _managedObjectModel;
    
}


/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // NSLog(@" Entering %s" , __FUNCTION__);
	
    NSURL *appStoreURL;
    NSURL *userStoreURL;
    
    if (_persistentStoreCordinator != nil) {
        return _persistentStoreCordinator;
    }
	else
	{
        NSString *appDataBaseName;
        appDataBaseName = [kAppDataBaseName stringByAppendingString:@"."];
        appDataBaseName = [appDataBaseName stringByAppendingString: @"sqlite"] ;
        
        // 2nd DB
        //Not Used in Test App
        /****
        NSString *userDataBaseName;
        userDataBaseName = [kUserDataBaseName stringByAppendingString:@"."];
        userDataBaseName = [userDataBaseName stringByAppendingString: @"sqlite"] ;
        ***/
        
        appStoreURL = [[self applicationDataDirectory ] URLByAppendingPathComponent:appDataBaseName];
    
                //DEBUG
        // NSLog(@"userStoreURL: %@",userStoreURL);
        
		
         // Database Build COMMENT OUT
		
        //BOOL backUpFlag = [self addSkipBackupAttributeToItemAtURL:appStoreURL];
        
        // NSLog(@"***************************");
		//	// NSLog(@"BackUp Flag: %d", backUpFlag);
        // NSLog(@"***************************");
        
        NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"SGModel" withExtension:@"momd"];
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        
        NSError *error = nil;
    
        _persistentStoreCordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
        
      // DEBUG
        // NSLog(@"CDM: Persistent Store Coordinator: %@", _persistentStoreCordinator);
     //   // NSLog(@" USER Persistent Store Coordinator: %@",userStoreCoordinator);
        
        NSDictionary *optionsDictionary = @{NSMigratePersistentStoresAutomaticallyOption: @YES, NSInferMappingModelAutomaticallyOption: @YES};
        
      // NSLog(@"Create APP DB");
       // 	NSPersistentStore *appDataStore =
     //   [_persistentStoreCordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:appStoreURL options:nil error:&error];
        
 // 11.22 Unused      	NSPersistentStore *appDataStore =
        [_persistentStoreCordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:@"Data" URL:appStoreURL options:optionsDictionary error:&error];
        
       // NSLog(@"Create USER DB");
    // 11.22 Unused NSPersistentStore *userDataStore =
        [_persistentStoreCordinator addPersistentStoreWithType:NSSQLiteStoreType configuration: @"User" URL:userStoreURL options:optionsDictionary error:&error];
		//// NSLog(@" UpDATE - Create User DB in DOCUMENTS DIR");
        
        [_appDataMOC setPersistentStoreCoordinator:_persistentStoreCordinator];        }
    
        
        //NOTE: options WAS optionDictionary for migration model
        
        // options:options was options:nil
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
		 If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path.
		 Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        ///////////////
        
        
        
        
        
        
        /////////////////////
		
        //       // NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		// Simply deleting the existing store:
		//   [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil];
		//    abort();
    
        return _persistentStoreCordinator;
    }
    



#pragma mark -
#pragma mark Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory {
    // NSLog(@" Entering %s" , __FUNCTION__);
    
    //DEBUG
    // NSLog(@"Applications Doc DIR: %@",   [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject]);

    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    
}

- (NSURL *)applicationDataDirectory {
    // NSLog(@" Entering %s" , __FUNCTION__);
	
	NSURL *applicationDataBaseURL = [[[NSFileManager defaultManager] URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask]lastObject];
// Moved DB to DATA DiR
    applicationDataBaseURL = [applicationDataBaseURL URLByAppendingPathComponent:@"Data"];
    
	//DEBUG
    // NSLog(@"Applications DATA DIR: %@",  applicationDataBaseURL);
    
	return  applicationDataBaseURL;
}

// User Content NOT USED in Fuzz Test App
/***
+(NSManagedObjectContext *)getUserContext
{
    // set ManagedObject to App Delegate
	FTBAppDelegate *appDelegate = (FTBAppDelegate *) [[UIApplication sharedApplication] delegate];
	
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = appDelegate.userDataMOC;
    
    //DEBUG
    // NSLog(@"App Delegate: App USER Context:  %@",context);

    return context;
    
}
 ****/

+(NSManagedObjectContext *)getAppContext
{
    // set ManagedObject to App Delegate
	FTBAppDelegate *appDelegate = (FTBAppDelegate *) [[UIApplication sharedApplication] delegate];
	
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = appDelegate.appDataMOC;
    //DEBUG
    // NSLog(@"APP Delegate: App DATA Context:  %@",context);
    
    return context;
    
    //  return _managedObjectContext;
}

+(BOOL)save2DB
{
    NSManagedObjectContext *context = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    //   [context setPersistentStoreCoordinator:[selfpersistentStoreCoordinator]];
    
    //ToDo:  Add error Checking
    // Persistent Store - later
    [context save:nil];
    
    return YES;
    
}

+(BOOL)save2DB:(NSManagedObjectContext *)context
{
    NSError *error;
    if([context save:&error]) return YES;
       return NO;
}
@end


