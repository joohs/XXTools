//
//  UILabel+Extension.m
//  component
//
//  Created by WXX on 2020/11/24.
//

#import "UILabel+Extension.h"
#import <YYText/YYText.h>
#import "StringTool.h"

@implementation UILabel (Extension)

- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor {
    self.font = font;
    self.textColor = textColor;
    self.numberOfLines = 0;
}

- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor attributedString:(NSString *)attributedString {
    self.font = font;
    self.textColor = textColor;
    self.numberOfLines = 0;
    [self allText:attributedString matchTextDiction:nil matchColor:textColor];
}

- (void)setFont:(UIFont *)font textColor:(UIColor *)textColor attributedString:(NSString *)attributedString attributedColor:(UIColor *)attributedColor {
    if (attributedColor == nil) {
        attributedColor = textColor;
    }
    self.font = font;
    self.textColor = textColor;
    self.numberOfLines = 0;
    [self allText:attributedString matchTextDiction:nil matchColor:attributedColor];
}

/**
 *  通过标签的字典来实现富文本的展示
 *  @{@"start":@"<em>", @"end":@"</em>"}
 */
- (void)allText:(NSString *)allText matchTextDiction:(nullable NSDictionary *)matchTextDiction matchColor:(UIColor *)matchColor {
    
    [self allText:allText matchTextDiction:matchTextDiction matchColor:matchColor lineSpacing:4.f font:self.font];
}

- (void)allText:(NSString *)allText matchTextDiction:(NSDictionary *)matchTextDiction matchColor:(UIColor *)matchColor  lineSpacing:(CGFloat)lineSpacing {
    [self allText:allText matchTextDiction:matchTextDiction matchColor:matchColor lineSpacing:lineSpacing font:self.font];
}

- (void)allText:(NSString *)allText matchTextDiction:(NSDictionary *)matchTextDiction matchColor:(UIColor *)matchColor lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font {
    
    if (![allText isKindOfClass:[NSString class]]) {
        allText = @"";
    }
    //matchTextDiction:传递过来的标签
    NSString *startMatchText = @"<em>";
    NSInteger startMatchLength = startMatchText.length;
    NSString *endMatchText = @"</em>";
    NSInteger endMatchLength = endMatchText.length;
    if ([matchTextDiction valueForKey:@"start"]) {
        startMatchText = [matchTextDiction valueForKey:@"start"];
        startMatchLength = startMatchText.length;
        endMatchText = [matchTextDiction valueForKey:@"end"];
    }
    
#pragma mark -- 清空标志位
    NSString *tureText=[allText stringByReplacingOccurrencesOfString:startMatchText withString:@""];
    tureText=[tureText stringByReplacingOccurrencesOfString:endMatchText withString:@""];
    
#pragma mark -- 获取有几个标签
    NSMutableArray *tagArray=[self getRangeStr:allText findText:startMatchText];
    NSMutableArray *tagAArray=[self getRangeStr:allText findText:endMatchText];
    
#pragma mark -- 标签不成对存在的时候，直接返回清空标签后的内容
    if ([tagArray count] != [tagAArray count] ){
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:tureText attributes:nil];
        attributedString.yy_lineSpacing = lineSpacing;
        self.attributedText = attributedString;
    } else {
    
        NSMutableArray *textArray=[NSMutableArray array];
        NSMutableArray *endTextArray=[NSMutableArray array];
        for (int ii=0; ii<tagArray.count; ii++) {
            
            NSInteger location1=[[tagArray[ii] valueForKey:@"location"] integerValue];
            NSInteger location2=[[tagAArray[ii] valueForKey:@"location"] integerValue];
            [textArray addObject:@{@"location1":[NSNumber numberWithInteger:location1],@"location2":[NSNumber numberWithInteger:location2]}];
        }
        NSMutableDictionary *diction = [NSMutableDictionary dictionary];
        NSInteger reduceNumber = 0;
        for (int i = 0; i < [textArray count]; i ++) {
            NSDictionary *dic = textArray[i];
            NSRange rangeTemop;
            rangeTemop.location=[[dic valueForKey:@"location1"] integerValue]+startMatchLength;
            rangeTemop.length=[[dic valueForKey:@"location2"] integerValue]-[[dic valueForKey:@"location1"] integerValue]-startMatchLength;
            NSUInteger location = [[dic valueForKey:@"location1"] integerValue]-reduceNumber;
            NSUInteger length = rangeTemop.length;
            reduceNumber += (startMatchLength+endMatchLength);
            [diction setValue:matchColor forKey:[NSString stringWithFormat:@"%lu-%ld", (unsigned long)location, length]];
        }
        if ([diction count]) {
            self.attributedText =  [self setAttributedLabelTextColorAndRange:diction string:tureText lineSpacing:lineSpacing font:font];
        }else{
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:tureText attributes:nil];
            attributedString.yy_lineSpacing = lineSpacing;
            self.attributedText = attributedString;
        }
    }
}

- (NSMutableAttributedString *) getAttributedStringWithAllText:(NSString *)allText matchTextDiction:(NSDictionary *)matchTextDiction matchColor:(UIColor *)matchColor lineSpacing:(CGFloat)lineSpacing {
    
    if (![allText isKindOfClass:[NSString class]]) {
        allText = @"";
    }
    //matchTextDiction:传递过来的标签
    NSString *startMatchText = @"<em>";
    NSInteger startMatchLength = startMatchText.length;
    NSString *endMatchText = @"</em>";
    if ([matchTextDiction valueForKey:@"start"]) {
        startMatchText = [matchTextDiction valueForKey:@"start"];
        startMatchLength = startMatchText.length;
        endMatchText = [matchTextDiction valueForKey:@"end"];
    }
    
#pragma mark -- 清空标志位
    NSString *tureText=[allText stringByReplacingOccurrencesOfString:startMatchText withString:@""];
    tureText=[tureText stringByReplacingOccurrencesOfString:endMatchText withString:@""];
    
#pragma mark -- 获取有几个标签
    NSMutableArray *tagArray=[self getRangeStr:allText findText:startMatchText];
    NSMutableArray *tagAArray=[self getRangeStr:allText findText:endMatchText];
    
#pragma mark -- 标签不成对存在的时候，直接返回清空标签后的内容
    if([tagArray count] != [tagAArray count] ){
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:tureText attributes:nil];
        attributedString.yy_lineSpacing = lineSpacing;
        return attributedString;
    }else{
        
        NSMutableArray *textArray=[NSMutableArray array];
        NSMutableArray *endTextArray=[NSMutableArray array];
        for (int ii=0; ii<tagArray.count; ii++) {
            
            NSInteger location1=[[tagArray[ii] valueForKey:@"location"] integerValue];
            NSInteger location2=[[tagAArray[ii] valueForKey:@"location"] integerValue];
            [textArray addObject:@{@"location1":[NSNumber numberWithInteger:location1],@"location2":[NSNumber numberWithInteger:location2]}];
        }
        for (NSDictionary *dic in textArray) {
            NSRange rangeTemop;
            rangeTemop.location=[[dic valueForKey:@"location1"] integerValue]+startMatchLength;
            rangeTemop.length=[[dic valueForKey:@"location2"] integerValue]-[[dic valueForKey:@"location1"] integerValue]-startMatchLength;
            [endTextArray addObject:[allText substringWithRange:rangeTemop]];
        }
        NSMutableDictionary *diction = [NSMutableDictionary dictionary];
        for (NSString *str in endTextArray) {
            
            NSMutableArray *marr=[self getRangeStr:tureText findText:str];
            NSArray *arr=[NSArray arrayWithArray:marr];
            for (NSDictionary *dic in arr) {
                NSInteger loc=[[dic valueForKey:@"location"] integerValue];
                NSInteger len=[[dic valueForKey:@"length"] integerValue];
                
                [diction setValue:matchColor forKey:[NSString stringWithFormat:@"%ld-%ld",(long)loc,(long)len]];
            }
        }
        if ([diction count]) {
            return [self setAttributedLabelTextColorAndRange:diction string:tureText lineSpacing:lineSpacing font:self.font];
        }else{
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:tureText attributes:nil];
            attributedString.yy_lineSpacing = lineSpacing;
            return attributedString;
        }
    }
}

/**
 *  通过传入的文本来实现富文本的展示
 *
 */
-(void)allText:(NSString *)allText matchText:(NSString *)matchText matchColor:(UIColor *)matchColor {
    
    [self allText:allText matchText:matchText matchColor:matchColor lineSpacing:4.f];
}

-(void)allText:(NSString *)allText matchText:(NSString *)matchText matchColor:(UIColor *)matchColor lineSpacing:(CGFloat)lineSpacing {
    NSString *match = [NSString stringWithFormat:@"%@",matchText];
    allText =  [StringTool string:allText];
    if (![allText isKindOfClass:[NSString class]]) {
        allText = @"";
    }
    matchText = [StringTool string:match];
    
    NSMutableArray *tagArray=[self getRangeStr:allText findText:matchText];
    
    NSMutableDictionary *diction = [NSMutableDictionary dictionary];
    
    for (NSDictionary *dic in tagArray) {
        NSInteger loc=[[dic valueForKey:@"location"] integerValue];
        NSInteger len=[[dic valueForKey:@"length"] integerValue];
        [diction setValue:matchColor forKey:[NSString stringWithFormat:@"%ld-%ld",(long)loc,(long)len]];
    }
    
    if ([diction count]) {
        self.attributedText =  [self setAttributedLabelTextColorAndRange:diction string:allText lineSpacing:lineSpacing font:self.font];
    }else{
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:allText attributes:nil];
        attributedString.yy_lineSpacing = lineSpacing;
        self.attributedText = attributedString;
    }
}

- (NSMutableAttributedString *)setAttributedLabelTextColorAndRange:(NSDictionary *)dic string:(NSString *)string lineSpacing:(CGFloat)lineSpacing font:(UIFont *)font
{
    NSMutableAttributedString *str = [self attributedString:string];
    str.yy_alignment = self.textAlignment;
    str.yy_lineSpacing = lineSpacing;
    for (NSString *key in dic) {
        NSAssert([[dic objectForKey:key] isKindOfClass:[UIColor class]], @"Color format is not correct");
        NSArray *array = [key componentsSeparatedByString:@"-"];
        if (array.count == 1) {
            NSAssert(NO, @"Range format is not correct");
        }
        NSRange range = {[[array firstObject] integerValue], [[array lastObject] integerValue]};
        if ([self searchRange:range andText:string]) {
            [str addAttribute:NSForegroundColorAttributeName value:[dic objectForKey:key] range:range];
            [str addAttribute:NSFontAttributeName value:font range:range];
        }else{
            NSAssert(NO, @"Range beyond the length of the label text");
        }
    }
    return str;
}

/**
 *  获取富文本字符串
 *
 *  @return 富文本字符串
 */
- (NSMutableAttributedString *)attributedString
{
    if (self.text != nil) {
        return [[NSMutableAttributedString alloc] initWithString:self.text];
    }else{
        NSAssert([self.text isKindOfClass:[NSString class]], @"Label text is not set");
        return nil;
    }
}

- (NSMutableAttributedString *)attributedString:(NSString *)string
{
    if (string != nil) {
        return [[NSMutableAttributedString alloc] initWithString:string];
    }else{
        NSAssert([string isKindOfClass:[NSString class]], @"Label text is not set");
        return nil;
    }
}

#pragma mark - 获取某个子字符串在某个总字符串中位置数组
- (NSMutableArray *)getRangeStr:(NSString *)text findText:(NSString *)findText
{
    NSMutableArray *arrayRanges = [NSMutableArray arrayWithCapacity:20];
    if (findText == nil && [findText isEqualToString:@""]) {
        return nil;
    }
    NSRange rang = [text rangeOfString:findText];
    if (rang.location != NSNotFound && rang.length !=0) {
        [arrayRanges addObject:@{@"location":[NSNumber numberWithInteger:rang.location],
                                 @"length":[NSNumber  numberWithInteger:findText.length]}];
        NSRange rang1 = {0,0};
        NSInteger location = 0;
        NSInteger length = 0;
        for (int ii = 0;; ii++)
        {
            if (0 == ii) {
                location = rang.location + rang.length;
                length = text.length - rang.location - rang.length;
                rang1 = NSMakeRange(location, length);
            }
            else
            {
                location = rang1.location + rang1.length;
                length = text.length - rang1.location - rang1.length;
                rang1 = NSMakeRange(location, length);
            }
            rang1 = [text rangeOfString:findText options:NSCaseInsensitiveSearch range:rang1];
            if (rang1.location == NSNotFound && rang1.length == 0) {
                break;
            }else
                [arrayRanges addObject:@{@"location":[NSNumber numberWithInteger:rang1.location],
                                         @"length":[NSNumber  numberWithInteger:findText.length]}];
        }
        return arrayRanges;
    }
    return nil;
}

/**
 *  为多个范围文字添加不同颜色属性
 *
 *  @param dic @{@"4-5":[UIColor redColor]};
 *              key = 范围   value = 颜色
 */
- (void)setAttributedLabelTextColorAndRange:(NSDictionary *)dic
{
    NSMutableAttributedString *str = [self attributedString];
    for (NSString *key in dic) {
        NSAssert([[dic objectForKey:key] isKindOfClass:[UIColor class]], @"Color format is not correct");
        NSArray *array = [key componentsSeparatedByString:@"-"];
        if (array.count == 1) {
            NSAssert(NO, @"Range format is not correct");
        }
        NSRange range = {[[array firstObject] integerValue], [[array lastObject] integerValue]};
        if ([self searchRange:range andText:self.text]) {
            [str addAttribute:NSForegroundColorAttributeName value:[dic objectForKey:key] range:range];
        }else{
            NSAssert(NO, @"Range beyond the length of the label text");
        }
    }
    self.attributedText = str;
}

/**
 *  将range转化成string
 *
 *  @param range range description
 *
 *  @return return value description
 */
- (NSString *)RangeConversionString:(NSRange)range
{
    return [NSString stringWithFormat:@"%lu-%lu", (unsigned long)range.location, (unsigned long)range.length];
}

/**
 *  判断range是否超出字符串长度
 *
 *  @param range range description
 *  @param text  text description
 *
 *  @return YES 没有超出范围 NO 超出范围
 */
- (BOOL)searchRange:(NSRange)range andText:(NSString *)text
{
    if (range.length + range.location > text.length) {
        return NO;
    }else{
        return YES;
    }
}

@end
