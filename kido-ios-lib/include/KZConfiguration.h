#import "KZService.h"

@interface KZConfiguration : KZService
-(void) save:(id)object completion:(void (^)(KZResponse *))block;
-(void) get:(void (^)(KZResponse *))block;

-(void) remove;
-(void) remove:(void (^)(KZResponse *))block;

-(void) all:(void (^)(KZResponse *))block;
@end
