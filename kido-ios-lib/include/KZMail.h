#import "KZService.h"

@interface KZMail : KZService
-(void) send:(id)email completion:(void (^)(KZResponse *))block;
@end
