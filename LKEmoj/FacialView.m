//
//  FacialView.m
//  KeyBoardTest
//
//  Created by wangqiulei on 11-8-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FacialView.h"

#define kWidth [[UIScreen mainScreen] bounds].size.width
#define kHeight [[UIScreen mainScreen] bounds].size.height



@implementation FacialView
@synthesize delegate;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
//        faces=[EmojiEmoticons allEmoticons];
//        faces=[Emoji allEmoji];
//        faces=[EmojiPictographs allPictographs];
    }
    return self;
}

-(void)loadFacialView:(int)page size:(CGSize)size
{
#define MAX_PER_ROW     5
#define MAX_PER_COLOMN  4
    CGFloat xInterval = (kWidth-size.width*MAX_PER_ROW)/(MAX_PER_ROW+1);
    CGFloat yInterval = (self.frame.size.height-size.height*MAX_PER_COLOMN)/(MAX_PER_COLOMN+1);
    for (int i=0; i<MAX_PER_ROW*MAX_PER_COLOMN; i++){
        int row = i/MAX_PER_ROW;
        int colomn = i % MAX_PER_ROW;
        if (i+(page*19)>=_faces.count && (row!=3 || colomn!=4)) {
            continue;
        }
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundColor:[UIColor clearColor]];
        button.frame = CGRectMake(xInterval+colomn*(xInterval+size.width), yInterval+row*(yInterval+size.height), size.width, size.height);
    
        [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        
        if (row==3 && colomn==4) {
             button.tag = 10000;
            [button setImage:[UIImage imageNamed:@"comment_deleteIcon"] forState:UIControlStateNormal];
        }
        else
        {
            button.tag = i+(page*19);
            [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0*kWidth/375]];
            [button setTitle: _faces[i+(page*19)] forState:UIControlStateNormal];
        }
    }
//    //row number
//    for (int i=0; i<4; i++) {
//        //column numer
//        for (int y=0; y<5; y++) {
//
//            if (i*5+y+(page*19) >= _faces.count) {
//                break;
//            }
//            UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
//            [button setBackgroundColor:[UIColor clearColor]];
//            [button setFrame:CGRectMake(29*ScreenWidthCoefficientWith(0)+y*(size.width+29*ScreenWidthCoefficientWith(0)), i*size.height, size.width, size.height)];
////            if (i==4&&y==3) {
////                continue;
////            }else
//            if (i==3&&y==4) {
//
//                continue;
//            }else{
//                [button.titleLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0*ScreenWidthCoefficientWith(0)]];
//                [button setTitle: [_faces objectAtIndex:i*5+y+(page*19)]forState:UIControlStateNormal];
//                button.tag=i*5+y+(page*19);
//
//            }
//            [button addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
//            [self addSubview:button];
//        }
//    }
//
//    UIButton *button1=[UIButton buttonWithType:UIButtonTypeCustom];
//    [button1 setBackgroundColor:[UIColor clearColor]];
//    [button1 setFrame:CGRectMake(300*ScreenWidthCoefficientWith(0), 3 * size.height + 10, size.width, size.height*2/3)];
//    [button1 setImage:[UIImage imageNamed:@"comment_deleteIcon"] forState:UIControlStateNormal];
////    button.backgroundColor = [UIColor redColor];
//    button1.tag=10000;
//    [button1 addTarget:self action:@selector(selected:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:button1];
}


-(void)selected:(UIButton*)bt
{
    if (bt.tag==10000) {
     //   NSLog(@"点击删除");
        [delegate selectedDelete:@"删除"];
    }else{
        NSString *str=[_faces objectAtIndex:bt.tag];
      //  NSLog(@"点击其他%@",str);
        [delegate selectedFacialView:str];
    }	
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code.
}
*/
- (void)dealloc {
//    [super dealloc];
}
@end
