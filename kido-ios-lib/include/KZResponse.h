#import <Foundation/Foundation.h>
@class KZApplication;

@interface KZResponse : NSObject
{
};
-(id) initWithResponse:(id) response urlResponse:(NSHTTPURLResponse *) urlresponse andError:(NSError *) error;

@property (nonatomic, strong) id response;
@property (nonatomic, strong) NSHTTPURLResponse * urlResponse;
@property (nonatomic, strong) NSError * error;
@property (nonatomic, strong) KZApplication * application;
@property (nonatomic, strong) id source;

@end;
