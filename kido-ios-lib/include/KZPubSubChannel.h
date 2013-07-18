#import "KZService.h"
#import "SRWebSocket.h"

typedef void (^WebSocketEventBlock)(id);

@interface KZPubSubChannel : KZService <SRWebSocketDelegate>
{
    SRWebSocket *_webSocket;
}
@property (nonatomic, copy) WebSocketEventBlock webSocketCompletionEventBlock;
@property (retain, nonatomic) NSString * wsEndpoint;
@property (retain, nonatomic) NSString * channelName;

-(id)initWithEndpoint:(NSString *)endpoint wsEndpoint:(NSString *) wsEndpoint andName:(NSString *)name ;
-(void) publish:(id)object completion:(void (^)(KZResponse *))block;
-(void) subscribe:(WebSocketEventBlock) completionEventBlock;
-(void) unsubscribe:(WebSocketEventBlock) completionEventBlock;
@end
