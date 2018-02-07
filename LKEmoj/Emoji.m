//
//  Emoji.m
//  Emoji
//
//  Created by Aliksandr Andrashuk on 26.10.12.
//  Copyright (c) 2012 Aliksandr Andrashuk. All rights reserved.
//

#import "Emoji.h"
#import "EmojiEmoticons.h"
#import "EmojiMapSymbols.h"
#import "EmojiPictographs.h"
#import "EmojiTransport.h"

#import "emoj.h"

@implementation Emoji
+ (NSString *)emojiWithCode:(int)code {
    int sym = EMOJI_CODE_TO_SYMBOL(code);
    return [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
}
+ (NSArray *)allEmoji {
    NSMutableArray *array = [NSMutableArray new];
    
    int leng = sizeof(emoj_arr) / sizeof(int);
    for (int i = 0; i < leng; i++) {
      //  NSLog(@"index : %d", i);
        [array addObject:[Emoji emojiWithCode:emoj_arr[i]]];
    }
//    [array addObjectsFromArray:[EmojiEmoticons allEmoticons]];
//    [array addObjectsFromArray:[EmojiMapSymbols allMapSymbols]];
//    [array addObjectsFromArray:[EmojiPictographs allPictographs]];
//    [array addObjectsFromArray:[EmojiTransport allTransport]];
    
    return array;
}

+(NSString *)stringReplaceWithFace:(NSString *)str
{
    NSString *mutaStr = str;
    
    for (int i=0x1F600; i<=0x1F64F; i++) {
        if (i < 0x1F641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emoT = [[NSString alloc] initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            
            mutaStr = [mutaStr stringByReplacingOccurrencesOfString:emoT withString:[NSString stringWithFormat:@"%d",sym]];
        }
    }
    
    return mutaStr;
}


@end
