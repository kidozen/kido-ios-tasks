#import "KZService.h"

typedef enum  {
    LogLevelVerbose,
    LogLevelInfo,
    LogLevelWarning,
    LogLevelError, 
    LogLevelCritical
} LogLevel;


@interface KZLogging : KZService
-(void) write:(id)object withLevel:(LogLevel) level completion:(void (^)(KZResponse *))block;
-(void) all:(void (^)(KZResponse *))block;
-(void) clear:(void (^)(KZResponse *))block;
-(void) query:(NSString *)query withOptions:(NSString *)options andBlock:(void (^)(KZResponse *))block;
@end
