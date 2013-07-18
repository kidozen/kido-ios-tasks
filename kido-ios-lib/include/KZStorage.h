#import "KZService.h"

@interface KZStorage : KZService

-(void) create:(id)object completion:(void (^)(KZResponse *))block;
-(void) createPrivate:(id)object completion:(void (^)(KZResponse *))block;
-(void) getUsingId:(NSString *) objectId withBlock:(void (^)(KZResponse *))block;

-(void) updateUsingId:(NSString *) objectId object:(id)object completion:(void (^)(KZResponse *))block;
-(void) updateUsingId:(NSString *) objectId object:(id)object;

-(void) deleteUsingId:(NSString *) objectId;
-(void) deleteUsingId:(NSString *) objectId withBlock:(void (^)(KZResponse *))block;

-(void) drop;
-(void) drop:(void (^)(KZResponse *))block;


-(void) all:(void (^)(KZResponse *))block;
-(void) query:(NSString *) query withBlock:(void (^)(KZResponse *))block;
-(void) query:(NSString *) query withOptions:(NSString *) options withBlock:(void (^)(KZResponse *))block;

 @end
