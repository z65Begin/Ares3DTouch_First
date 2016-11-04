//
//  AppDelegate.m
//  Ares3DTouch_First
//
//  Created by Admin on 16/11/4.
//  Copyright © 2016年 AresBegin. All rights reserved.
//

#import "AppDelegate.h"

#import <SafariServices/SafariServices.h>

#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 3D Touch 分为重压和轻压手势，分别称作POP（第一段重压）和PEEK（第二段重压），外面的图标只需要POP即可
    //POP手势图标初始化
    //使用系统自带图标
    UIApplicationShortcutIcon * icon = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeCloud];
    UIApplicationShortcutIcon * icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeAdd];
//    UIApplicationShortcutIcon * icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"自定义图片"];
    
    UIApplicationShortcutItem * item = [[UIApplicationShortcutItem alloc] initWithType:@"item1" localizedTitle:@"这是一个标题" localizedSubtitle:@"这是子标题" icon:icon userInfo:nil];
    UIApplicationShortcutItem * item1 = [[UIApplicationShortcutItem alloc] initWithType:@"item2" localizedTitle:@"你可以在这里分享些东西" localizedSubtitle:@"这是子标题1" icon:icon1 userInfo:nil];
    NSArray * itemArray = @[item,item1];
    
    [UIApplication sharedApplication].shortcutItems = itemArray;
    return YES;
}

#pragma mark -3DTouch触发的方法
- (void)application:(UIApplication *)application performActionForShortcutItem:(UIApplicationShortcutItem *)shortcutItem completionHandler:(void (^)(BOOL))completionHandler{
    if ([shortcutItem.type isEqualToString:@"item1"]) {
      //这里可以实现界面跳转的方法
        SFSafariViewController * sv = [[SFSafariViewController alloc] initWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
        _window.rootViewController = sv;
        NSLog(@"按压了第一个标题");
    }else if([shortcutItem.type isEqualToString:@"item2"]){
        ViewController * vc = [[ViewController alloc] init];
        _window.rootViewController = vc;
        NSLog(@"按压了第二个标题");
    
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Ares3DTouch_First"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                    */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
