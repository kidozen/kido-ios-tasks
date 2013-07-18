#import "KZService.h"

@interface KZNotification : KZService
{
    NSString * deviceMacAddress;
}
-(void) subscribeDeviceWithToken:(NSString *)deviceToken toChannel:(NSString *) channel completion:(void (^)(KZResponse *))block;
-(void) getSubscriptions:(void (^)(KZResponse *))block;
-(void) unSubscribeDeviceUsingToken:(NSString *)deviceToken fromChannel:(NSString *) channel completion:(void (^)(KZResponse *))block;
-(void) pushNotification:(NSDictionary *) notification InChannel:(NSString *) channel completion:(void (^)(KZResponse *))block;

@end
