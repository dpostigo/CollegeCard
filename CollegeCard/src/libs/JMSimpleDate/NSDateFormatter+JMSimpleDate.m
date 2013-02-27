// NSDateFormatter+JMSimpleDate.h
//
// Copyright (c) 2013 James Martinez
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

#import "NSDateFormatter+JMSimpleDate.h"
#import "JMSimpleDateConstants.h"

@implementation NSDateFormatter (JMSimpleDate)

+ (NSString *)formattedStringTimeElapsedFromDate:(NSDate *)date {
    
    NSDate *now = [NSDate date];
    NSTimeInterval timeIntervalDifference = [date timeIntervalSinceDate:now] * -1.0; // turns the time interval since now into a positive number
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger units = (NSYearCalendarUnit|
                        NSMonthCalendarUnit |
                        NSDayCalendarUnit |
                        NSHourCalendarUnit |
                        NSMinuteCalendarUnit |
                        NSSecondCalendarUnit);
    NSDateComponents *components = [calendar components:units fromDate:date toDate:now options:0];
    
    NSString *returnString;
    
    if (timeIntervalDifference < 0) {
        NSLog(@"You just created some sort of time warp. You're in the future? Tell me how you did that! JMSimpleDate throwing exception...");
        [NSException raise:@"JMSimpleDate Exception" format:@"When trying to format the string in a time elapsed fashion, we received a date in the future. That can't be formatted."];
    } else if (timeIntervalDifference < 1 * kMinute) { // less than a minute
        //seconds
        returnString = (components.second == 1) ? @"1 second ago" : [NSString stringWithFormat:@"%d seconds ago",components.second];
        
    } else if (timeIntervalDifference < 2 * kMinute) { // less than two minutes
        returnString =  @"a minute ago";
        
    } else if (timeIntervalDifference < 59 * kMinute) { // less than 59 minutes
        returnString = [NSString stringWithFormat:@"%d minutes ago",components.minute];
        
    } else if (timeIntervalDifference < 120 * kMinute) { // less than an hour and a half
        returnString = @"an hour ago";
        
    } else if (timeIntervalDifference < 24 * kHour) { // less than a day
        returnString = [NSString stringWithFormat:@"%d hours ago",components.hour];
        
    } else if (timeIntervalDifference < 48 * kHour) { // less than two days
        returnString = @"Yesterday";
        
    } else if (timeIntervalDifference < 30 * kDay) { // less than a month
        returnString = [NSString stringWithFormat:@"%d days ago",components.day];
        
    } else if (timeIntervalDifference < 12 * kMonth) { // less than a year
        returnString = (components.month <= 1) ? @"one month ago" : [NSString stringWithFormat:@"%d months ago",components.month];
        
    } else { //a year or more
        returnString = (components.year <= 1) ? @"one year ago" : [NSString stringWithFormat:@"%d years ago",components.year];
    }
    
    return returnString;
}

#pragma mark - Date Format Templates

+ (NSString *)timeFormatStringShowingSeconds:(BOOL)showSeconds {
    if (showSeconds) {
        return @"HH:mm:ss";
    }
    return @"HH:mm";
}

+ (NSString *)timeFormatString {
    return [self timeFormatStringShowingSeconds:YES];
}

+ (NSString *)dateFormatStringWithAmericanFormat:(BOOL)isAmerican {
    if (isAmerican) {
        return @"MM-dd-yyyy";
    }
	return @"yyyy-MM-dd";
}

+ (NSString *)dateFormatString {
    return [self dateFormatStringWithAmericanFormat:NO];
}

+ (NSString *)timestampFormatStringWithAmericanFormat:(BOOL)isAmerican showingSeconds:(BOOL)showSeconds {
    
    if (isAmerican && showSeconds) {
        return @"MM-dd-yyyy HH:mm:ss";
    }
    
    if (isAmerican && !showSeconds) {
        return @"MM-dd-yyyy HH:mm"; 
    }
    
    if (!isAmerican && !showSeconds) {
        return @"yyyy-MM-dd HH:mm";
    }
    
	return @"yyyy-MM-dd HH:mm:ss";
}

+ (NSString *)timestampFormatString {
    return [self timestampFormatStringWithAmericanFormat:NO showingSeconds:YES];
}


@end
