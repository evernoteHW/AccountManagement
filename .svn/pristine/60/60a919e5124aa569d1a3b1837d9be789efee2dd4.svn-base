//
//  DataServies.m
//  KuaiDian
//
//  Created by eddy on 14-3-10.
//  Copyright (c) 2014年 yintai. All rights reserved.
//

#import "DataServies.h"
#import "NetworkManager.h"

@implementation DataServies

- (void)dealloc
{
    _manager = nil;
}

+ (DataServies *)requestWithURL:(NSString *)url
                         params:(NSMutableDictionary *)params
                     httpMethod:(NSString *)httpMethod
                    finishBlock:(RequestFinishBlock)block
                      failBlock:(RequestFailBlock)failBlock
{
    DataServies *request = [[DataServies alloc] init];
    
    request.url = url;
    request.httpMethod = httpMethod;
    request.params = params;
    request.finishBlock = block;
    request.failBlock = failBlock;
    
    return request;
}

- (void)sendRequest
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    if ([_httpMethod caseInsensitiveCompare:@"GET"] == NSOrderedSame) {
        
        [manager GET:_url parameters:_params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
            NSString *jsonStr = [[operation.responseString stringByReplacingOccurrencesOfString:@"/r" withString:@""] stringByReplacingOccurrencesOfString:@"/n" withString:@""];
            NSRange range = [jsonStr rangeOfString:@"province"];
            NSRange range2 = [jsonStr rangeOfString:@"catName"];
            if (range.location != NSNotFound && range2.location != NSNotFound) {

                NSString *str = [jsonStr substringFromIndex:range.location + range.length + 2];
                NSRange range0 = [str rangeOfString:@"'"];
                str = [str substringToIndex:range0.location];
                
                
                NSString *str2 = [jsonStr substringFromIndex:range2.location + range2.length + 2];
                NSRange range2 = [str2 rangeOfString:@"'"];
                str2 = [str2 substringToIndex:range2.location];
                
                //block调用
                if (_finishBlock) {
                    _finishBlock(self, @{@"province":str,@"catName":str2});
                    _finishBlock = nil;
                }
                if (_failBlock) {
                    _failBlock = nil;
                }
                
                [_manager requestDidFinish:self];
            }

            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
        }];
        
    }else{
        
        [manager POST:_url parameters:_params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if (![responseObject isKindOfClass:[NSDictionary class]]) {
                
                return ;
            }else
            {
                //block调用
                if (_finishBlock) {
                    _finishBlock(self, (NSDictionary *)responseObject);
                    _finishBlock = nil;
                }
                if (_failBlock) {
                    _failBlock = nil;
                }
                
                [_manager requestDidFinish:self];
            }
            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"Error: %@", error);
            if (_failBlock) {
                _failBlock(self, error);
                _failBlock = nil;
            }
            if (_finishBlock) {
                _finishBlock = nil;
            }
            
            [_manager requestDidFinish:self];
        }];

    }
}
@end

