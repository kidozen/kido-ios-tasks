#import "KZService.h"

@interface KZSMSSender : KZService
-(void) send:(NSString *)message completion:(void (^)(KZResponse *))block;
-(void) getStatus:(NSString *)messageId completion:(void (^)(KZResponse *))block;
@end
