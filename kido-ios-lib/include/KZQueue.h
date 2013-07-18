#import <Foundation/Foundation.h>
#import "KZService.h"

@interface KZQueue : KZService

-(void) enqueue:(id)object;
-(void) enqueue:(id)object completion:(void (^)(KZResponse *))block;
-(void) dequeue:(void (^)(KZResponse *))block;

@end
