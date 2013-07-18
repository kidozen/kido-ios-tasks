#import <Foundation/Foundation.h>

typedef void (^RequestTokenCompletionBlock)(NSString * token, NSError * error);


@protocol KZIdentityProvider <NSObject>

-(void) configure:(id) configuration;
-(void) initializeWithUserName:(NSString *)user password:(NSString *) andPassword andScope:(NSString *) scope;
-(void) beforeRequestToken:(NSDictionary *) params;
-(void) requestToken:(NSString *) identityProviderUrl completion:(RequestTokenCompletionBlock)block;
-(void) afterRequestToken:(NSDictionary *) params;

@end
