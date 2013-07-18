#import "KZIdentityProvider.h"
#import "KZHTTPClient.h"

@interface KZWRAPv09IdentityProvider : NSObject <KZIdentityProvider>
{
    NSString * _wrapName, *_wrapPassword, *_wrapScope;
}
@property (nonatomic, strong) NSString * token;
@end
