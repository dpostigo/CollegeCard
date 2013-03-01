// NSDate+JMSimpleDate.h
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

#import <Foundation/Foundation.h>


@interface NSDate (JMSimpleDate)

#pragma mark - Relative Dates
+ (NSDate *) dateInDays: (NSInteger) days;
+ (NSDate *) dateInHours: (NSInteger) hours;
+ (NSDate *) dateInMinutes: (NSInteger) minutes;
+ (NSDate *) dateInSeconds: (NSInteger) seconds;
+ (NSDate *) tomorrowsDate;
+ (NSDate *) yesterdaysDate;

#pragma mark - Date Comparison
- (BOOL) isOnSameDate: (NSDate *) date ignoringTimeOfDay: (BOOL) ignoreTimeOfDay;
- (BOOL) isInSameWeekAsDate: (NSDate *) date;
- (BOOL) isInSameMonthAsDate: (NSDate *) date;
- (BOOL) isInSameYearAsDate: (NSDate *) date;
- (BOOL) isEarlierThanDate: (NSDate *) date;
- (BOOL) isLaterThanDate: (NSDate *) date;

#pragma mark - Roles
- (BOOL) isToday;
- (BOOL) isTomorrow;
- (BOOL) isYesterday;
- (BOOL) isThisWeek;
- (BOOL) isNextWeek;
- (BOOL) wasLastWeek;
- (BOOL) isThisMonth;
- (BOOL) isThisYear;
- (BOOL) isNextYear;
- (BOOL) isLastYear;
- (BOOL) isWeekend;
- (BOOL) isWeekday;

#pragma mark - Date Adjustment
- (NSDate *) dateByAddingDays: (NSInteger) days;
- (NSDate *) dateBySubtractingDays: (NSInteger) days;
- (NSDate *) dateByAddingHours: (NSInteger) hours;
- (NSDate *) dateBySubtractingHours: (NSInteger) hours;
- (NSDate *) dateByAddingMinutes: (NSInteger) minutes;
- (NSDate *) dateBySubtractingMinutes: (NSInteger) minutes;
- (NSDate *) dateAtMidnight;
- (NSDateComponents *) standardComponents;
- (NSDateComponents *) componentsWithOffsetFromDate: (NSDate *) date;

#pragma mark - Retrieving Intervals
- (BOOL) hasPassed;
- (NSInteger) minutesAfterDate: (NSDate *) date;
- (NSInteger) secondsAfterDate: (NSDate *) date;
- (NSInteger) minutesBeforeDate: (NSDate *) date;
- (NSInteger) hoursAfterDate: (NSDate *) date;
- (NSInteger) hoursBeforeDate: (NSDate *) date;
- (NSInteger) daysAfterDate: (NSDate *) date;
- (NSInteger) daysBeforeDate: (NSDate *) date;

#pragma mark - Date Decomposing
- (NSInteger) nearestHour;
- (NSInteger) hour;
- (NSInteger) minute;
- (NSInteger) seconds;
- (NSInteger) day;
- (NSInteger) month;
- (NSInteger) week;
- (NSInteger) weekday;
- (NSInteger) nthWeekday;
- (NSInteger) year;

@end
