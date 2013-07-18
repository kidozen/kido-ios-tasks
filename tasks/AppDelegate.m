#import "AppDelegate.h"

#define TENANT  @"http://tenant"
#define APP     @"tasks"
#define USER    @"your user @kidozen.com"
#define PASS    @"your secret"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.kidozenApplication = [[KZApplication alloc] initWithTennantMarketPlace:TENANT applicationName:APP andCallback:^(KZResponse * kr) {
        NSAssert(!kr.error, @"error must be null");
        [kr.application authenticateUser:USER withProvider:@"Kidozen" andPassword:PASS completion:^(id kr) {
            NSAssert(![kr  isKindOfClass:[NSError class]], @"error must be null");
        }];
    }];

    return YES;
}
@end
