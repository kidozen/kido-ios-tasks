#import <Foundation/Foundation.h>
#import "NSString+Utilities.h"

@interface KZUser : NSObject
{
    NSString * _kzToken;
}
-(id) initWithToken:(NSString *) token;
-(BOOL*) isInRole:(NSString *) role;

@property (nonatomic, strong) NSMutableDictionary * claims;
@property (nonatomic, strong) NSArray * roles;
@property (nonatomic) int expiresOn;

@property (nonatomic, strong) NSString * user;
@property (nonatomic, strong) NSString * pass;


@end
