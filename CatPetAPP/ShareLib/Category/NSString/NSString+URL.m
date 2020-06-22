//
//  NSString+URL.m
//  CatPetAPP
//
//  Created by weibo02 on 2018/3/21.
//  Copyright © 2018年 yaohr. All rights reserved.
//

#import "NSString+URL.h"
#import "YHAssertMacro.h"
#import "NSStringIsEmpty.h"
#import "NSArray+Safe.h"
#import "NSMutableDictionary+Safe.h"

@implementation NSString (URL)
- (NSString*)host4url
{
    NSString *strURl = self;
    
    if([strURl length] > 0)
    {
        //这里需要URl encode，以防有中文字符
        strURl = [strURl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        NSURL *url=[NSURL URLWithString:strURl];
        if(url)
        {
            NSString *hostName = [url host];
            hostName=[hostName stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
            return hostName;
        }
    }
    return nil;
}

- (NSMutableDictionary *)urlParams
{
    if (__isStrEmpty(self))     return nil;
    
    NSString *strFilter;
    if ([self rangeOfString:@"?"].location == NSNotFound) {
        return nil;
    }else{
        NSArray *pathArr=[self componentsSeparatedByString:@"?"];
        if ([pathArr count] <= 1)   return nil;
        strFilter = [pathArr lastObject];
    }
    
    if (__isStrEmpty(strFilter))  return nil;
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    for (NSString *param in [strFilter componentsSeparatedByString:@"&"])
    {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        
        NSString *key=[elts safe_objectAtIndex:0];
        NSMutableString *value = [NSMutableString stringWithString:[elts safe_objectAtIndex:1]];
        
        //避免参数的value中也存在`=`的情况
        if (2 < [elts count]) {
            for (int i = 2; i < elts.count; i++) {
                [value appendFormat:@"=%@",elts[i]];
            }
        }
        
        if (__isStrEmpty(key)||__isStrEmpty(value))  continue;
        
        [params safe_setObject:value forKey:key];
    }
    return params;
}

- (NSString*)removeUrlParam:(NSString*)param
{
    if (__isStrEmpty(self))     return nil;
    
    NSArray *pathArr=[self componentsSeparatedByString:@"?"];
    if ([pathArr count] <= 1)   return self;
    
    NSString *strPath = [pathArr firstObject];
    NSString *strFilter=[pathArr safe_objectAtIndex:1];
    if (__isStrEmpty(strFilter))  return self;
    
    if ([strFilter rangeOfString:param].location == NSNotFound) return self;
    
    NSString *finalStr = [NSString string];
    
    NSMutableString * mutStr = [NSMutableString stringWithString:strFilter];
    
    NSArray *strArray = [mutStr componentsSeparatedByString:@"&"];
    
    NSMutableArray *paraList = [NSMutableArray array];
    for (NSMutableString  *paramStr in strArray) {
        NSArray *keyValue = [paramStr componentsSeparatedByString:@"="];
        NSString *key=[keyValue safe_objectAtIndex:0];
        
        if ([key isEqualToString:param]) {
            continue;
        }
        [paraList addObject:paramStr];
    }
    
    if ([paraList count]==0) {
        finalStr = strPath;
    }else{
        NSString *newString = [paraList componentsJoinedByString:@"&"];
        finalStr = [NSString stringWithFormat:@"%@?%@",strPath,newString];
    }
    return finalStr;
}

- (NSString*)stringByAppendedURLParams:(NSDictionary*)params keyList:(NSArray *)keyList
{
    BOOL ret = YES;
    NSMutableString *final = nil;
    NSString *sep = nil;
    
    CPRA(params);
    CBRA([params count] > 0);
    CBR([self length] > 0);
    
    final = [NSMutableString stringWithString:self];
    
    sep = @"&";
    if ([self rangeOfString:@"?"].length == 0)
    {
        // no param exists, append a '?'
        sep = @"?";
    }
    
    if ([keyList count] == 0)
    {
        keyList = [params allKeys];
    }
    
    for (NSString *key in keyList)
    {
        NSString *val = [params objectForKey:key];
        VBR([val isKindOfClass:[NSString class]]);
        
        [final appendFormat:@"%@%@=%@", sep, key, val];
        
        // from the second param, sep is always '&'
        sep = @"&";
    }
    
ERROR:
    if (!ret)
    {
        final = nil;
        return self;
    }
    
    VPR(final);
    return final;
}
@end
