#import "KZService.h"
#import "KZNotification.h"
#import "KZQueue.h"
#import "KZStorage.h"
#import "KZConfiguration.h"
#import "KZMail.h"
#import "KZSMSSender.h"
#import "KZLogging.h"

#if TARGET_OS_IPHONE
#import "KZPubSubChannel.h"
#endif
#import "KZAuthentication.h"
#import "KZWRAPv09IdentityProvider.h"
#import "KZFileManager.h"
#import "KZHTTPRequest.h"


typedef void (^AuthCompletionBlock)(id);
typedef void (^TokenExpiresBlock)(id);


@interface KZApplication : KZService <KZAuthentication>
{
    id<KZIdentityProvider>  ip ;
    NSString *_tennantMarketPlace;
    NSString *_applicationName;
    NSString *_notificationUrl;

    NSMutableDictionary * _queues;
    NSMutableDictionary * _configurations;
    NSMutableDictionary * _storages;
    NSMutableDictionary * _smssenders;
    NSMutableDictionary * _channels;
    NSMutableDictionary * _files;
    
    __block NSTimer* tokenExpirationTimer ;
}

-(id) initWithTennantMarketPlace:(NSString *) tennantMarketPlace applicationName:(NSString *) applicationName andCallback:(void (^)(KZResponse *))callback;

@property (nonatomic, strong) NSDictionary * configuration ;
@property (nonatomic, strong) NSDictionary * securityConfiguration ;

@property (nonatomic, strong) NSString * lastProviderKey;
@property (nonatomic, strong) NSString * lastUserName;
@property (nonatomic, strong) NSString * lastPassword;

@property (nonatomic, copy) AuthCompletionBlock authCompletionBlock;
@property (nonatomic, copy) TokenExpiresBlock tokenExpiresBlock;
@property (copy, nonatomic) void (^onInitializationComplete) (KZResponse *) ;

@property (strong, nonatomic) KZNotification * pushNotifications;
@property (strong, nonatomic) KZMail * mail;
@property (strong, nonatomic) KZLogging * log;
@property (strong, nonatomic) KZHTTPClient * defaultClient;

-(KZQueue *) QueueWithName:(NSString *) name;
-(KZStorage *) StorageWithName:(NSString *) name;
-(KZConfiguration *) ConfigurationWithName:(NSString *) name;
-(KZSMSSender *) SMSSenderWithNumber:(NSString *) number;

#if TARGET_OS_IPHONE
-(KZPubSubChannel *) PubSubChannelWithName:(NSString *) name;
#endif
-(void) sendMailTo:(NSString *)to from:(NSString *) from withSubject:(NSString *) subject andHtmlBody:(NSString *) htmlBody andTextBody:(NSString *)textBody  completion:(void (^)(KZResponse *))block;
-(void) writeLog:(id) message withLevel:(LogLevel) level completion:(void (^)(KZResponse *))block;

-(void) sendByServiceBus:(NSMutableURLRequest *) request completion:(void (^)(KZResponse *))block;


@end
