#import "AppDelegate.h"
#import <KZApplication.h>

#define TENANT  @"https://marketplace.kidocloud.com"
#define APP     @"tasks"
#define USER    @"your user @kidozen.com"
#define PASS    @"your secret"
#define APPLICATION_KEY @"You application key"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
    __weak AppDelegate *safeMe = self;
    
    
    self.kidozenApplication = [[KZApplication alloc] initWithTenantMarketPlace:TENANT
                                                               applicationName:APP
                                                                applicationKey:APPLICATION_KEY
                                                                     strictSSL:NO
                                                                   andCallback:^(KZResponse *response)
    {
        
        NSAssert(!response.error, @"error must be null");
        [safeMe.kidozenApplication authenticateUser:USER
                                       withProvider:@"Kidozen"
                                        andPassword:PASS
                                         completion:^(id kr)
        {
            NSAssert(![kr  isKindOfClass:[NSError class]], @"error must be null");
            dispatch_semaphore_signal(semaphore);
            
            [safeMe.kidozenApplication enableAnalytics];
            [safeMe.kidozenApplication.analytics setSessionSecondsTimeOut:2];
            [safeMe.kidozenApplication.analytics setUploadMaxSecondsThreshold:10];
            
        }];

    }];
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10000]];

    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application
{
    NSLog(@"Application will resign active");
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    NSLog(@"applicationDidEnterBackground");
}


@end
