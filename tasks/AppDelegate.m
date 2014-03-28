#import "AppDelegate.h"

#define TENANT  @"https://marketplace.kidocloud.com"
#define APP     @"tasks"
#define USER    @"your user @kidozen.com"
#define PASS    @"your secret"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    self.kidozenApplication = [[KZApplication alloc] initWithTennantMarketPlace:TENANT applicationName:APP bypassSSLValidation:YES andCallback:^(KZResponse * kr) {
        NSAssert(!kr.error, @"error must be null");
        [kr.application authenticateUser:USER withProvider:@"Kidozen" andPassword:PASS completion:^(id kr) {
            NSAssert(![kr  isKindOfClass:[NSError class]], @"error must be null");
            dispatch_semaphore_signal(semaphore);
        }];
    }];
    while (dispatch_semaphore_wait(semaphore, DISPATCH_TIME_NOW))
        [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10000]];

    return YES;
}
@end
