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

#import "NSDate+JMSimpleDate.h"

#import "JMSimpleDateConstants.h"

@implementation NSDate (JMSimpleDate)

#pragma mark - Relative Dates

+ (NSDate *)dateInDays:(NSInteger)days {
    NSTimeInterval daysTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + (kDay * days);
	NSDate *returnDate = [NSDate dateWithTimeIntervalSinceReferenceDate:daysTimeInterval];
	return returnDate;
}

+ (NSDate *)dateInHours:(NSInteger)hours {
	NSTimeInterval hoursTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kHour * hours;
	NSDate *returnDate = [NSDate dateWithTimeIntervalSinceReferenceDate:hoursTimeInterval];
	return returnDate;
}

+ (NSDate *)dateInMinutes:(NSInteger)minutes {
	NSTimeInterval minutesTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kMinute * minutes;
	NSDate *returnDate = [NSDate dateWithTimeIntervalSinceReferenceDate:minutesTimeInterval];
	return returnDate;
}

+ (NSDate *)dateInSeconds:(NSInteger)seconds {
	NSTimeInterval secondsTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + seconds;
	NSDate *returnDate = [NSDate dateWithTimeIntervalSinceReferenceDate:secondsTimeInterval];
	return returnDate;
}

+ (NSDate *)tomorrowsDate {
    return [self dateInDays:1];
}

+ (NSDate *)yesterdaysDate {
    return [self dateInDays:-1];
}

#pragma mark - Date Comparison

- (BOOL)isOnSameDate:(NSDate *)date ignoringTimeOfDay:(BOOL)ignoreTimeOfDay {
    if (ignoreTimeOfDay) {
        NSCalendar *currentCalendar = [NSCalendar currentCalendar];
        NSDateComponents *selfComponents = [currentCalendar components:DATE_COMPONENTS fromDate:self];
        NSDateComponents *inputDateComponents = [currentCalendar components:DATE_COMPONENTS fromDate:date];
        
        if ((selfComponents.year == inputDateComponents.year &&
             selfComponents.month == inputDateComponents.month &&
             selfComponents.day == inputDateComponents.day)) {
            return YES;
        }
        return NO;
    } else {
        if (self == date) {
            return YES;
        }
        return NO;
    }
}

- (BOOL)isInSameWeekAsDate:(NSDate *)date {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *selfComponents = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	NSDateComponents *inputDateComponents = [currentCalendar components:DATE_COMPONENTS fromDate:date];
    
	if (selfComponents.week == inputDateComponents.week) {
        return YES;
    }
    
    if (abs([self timeIntervalSinceDate:date]) < kWeek) {
        return YES;
    }
    
    return NO;
}

- (BOOL)isInSameMonthAsDate:(NSDate *)date {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *selfComponents = [currentCalendar components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *inputDateComponents = [currentCalendar components:NSYearCalendarUnit fromDate:date];
    
    if ((selfComponents.month == inputDateComponents.month) &&
        (selfComponents.year == inputDateComponents.year)) {
        return YES;
    }
	return NO;
}

- (BOOL)isInSameYearAsDate:(NSDate *)date {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *selfComponents = [currentCalendar components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *inputDateComponents = [currentCalendar components:NSYearCalendarUnit fromDate:date];
    
    if (selfComponents.year == inputDateComponents.year) {
        return YES;
    }
	return NO;
}

- (BOOL)isEarlierThanDate:(NSDate *)date {
    if ([self compare:date] == NSOrderedAscending) {
        return YES;
    }
	return NO;
}

- (BOOL)isLaterThanDate:(NSDate *)date {
    if ([self compare:date] == NSOrderedDescending) {
        return YES;
    }
    return NO;
}

#pragma mark - Roles

- (BOOL)isToday {
	return [self isOnSameDate:[NSDate date] ignoringTimeOfDay:YES];
}

- (BOOL)isTomorrow {
    return [self isOnSameDate:[NSDate tomorrowsDate] ignoringTimeOfDay:YES];
}

- (BOOL)isYesterday {
    return [self isOnSameDate:[NSDate yesterdaysDate] ignoringTimeOfDay:YES];
}

- (BOOL)isThisWeek {
	return [self isInSameWeekAsDate:[NSDate date]];
}

- (BOOL)isNextWeek {
	NSTimeInterval nextWeekTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kWeek;
	NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:nextWeekTimeInterval];
	return [self isInSameWeekAsDate:date];
}

- (BOOL)wasLastWeek {
	NSTimeInterval lastWeekTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] - kWeek;
	NSDate *date = [NSDate dateWithTimeIntervalSinceReferenceDate:lastWeekTimeInterval];
	return [self isInSameWeekAsDate:date];
}

- (BOOL)isThisMonth {
    return [self isInSameMonthAsDate:[NSDate date]];
}

- (BOOL)isThisYear {
	return [self isInSameYearAsDate:[NSDate date]];
}

- (BOOL)isNextYear {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *selfComponents = [currentCalendar components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *currentDateComponents = [currentCalendar components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    if (selfComponents.year == (currentDateComponents.year + 1)) {
        return YES;
    }
	return NO;
}

- (BOOL)isLastYear {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *selfComponents = [currentCalendar components:NSYearCalendarUnit fromDate:self];
	NSDateComponents *currentDateComponents = [currentCalendar components:NSYearCalendarUnit fromDate:[NSDate date]];
    
    if (selfComponents.year == (currentDateComponents.year - 1)) {
        return YES;
    }
	return NO;
}

- (BOOL)isWeekend {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components:NSYearCalendarUnit fromDate:self];
    if ((components.weekday == 1) || (components.weekday == 7)) {
        return YES;
    }
    return NO;
}

- (BOOL)isWeekday {
    // returns the opposite of occursOnWeekend
    return (![self isWeekend]);
}

#pragma mark - Date Adjustment

- (NSDate *)dateByAddingDays:(NSInteger)days {
	NSTimeInterval inputTimeInterval = [self timeIntervalSinceReferenceDate] + kDay * days;
	NSDate *returnDate = [NSDate dateWithTimeIntervalSinceReferenceDate:inputTimeInterval];
	return returnDate;
}

- (NSDate *)dateBySubtractingDays:(NSInteger)days {
	return [self dateByAddingDays: (kDay * -1)];
}

- (NSDate *)dateByAddingHours:(NSInteger)hours {
	NSTimeInterval inputTimeInterval = [self timeIntervalSinceReferenceDate] + kHour * hours;
	NSDate *returnDate = [NSDate dateWithTimeIntervalSinceReferenceDate:inputTimeInterval];
	return returnDate;
}

- (NSDate *)dateBySubtractingHours:(NSInteger)hours {
	return [self dateByAddingHours: (hours * -1)];
}

- (NSDate *)dateByAddingMinutes:(NSInteger)minutes {
	NSTimeInterval inputTimeInterval = [self timeIntervalSinceReferenceDate] + kMinute * minutes;
	NSDate *returnDate = [NSDate dateWithTimeIntervalSinceReferenceDate:inputTimeInterval];
	return returnDate;
}

- (NSDate *)dateBySubtractingMinutes:(NSInteger)minutes {
	return [self dateByAddingMinutes:(minutes * -1)];
}

- (NSDate *)dateAtMidnight {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	components.hour = 0;
	components.minute = 0;
	components.second = 0;
	return [currentCalendar dateFromComponents:components];
}

- (NSDateComponents *)componentsWithOffsetFromDate:(NSDate *)date {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *offsetDateComponents = [currentCalendar components:DATE_COMPONENTS fromDate:date toDate:self options:0];
	return offsetDateComponents;
}

#pragma mark - Retrieving Intervals

- (NSInteger)minutesAfterDate:(NSDate *)date {
	NSTimeInterval minutesTimeInterval = [self timeIntervalSinceDate:date];
	return (NSInteger) (minutesTimeInterval / kMinute);
}

- (NSInteger) secondsAfterDate:(NSDate *)date {
    NSTimeInterval minutesTimeInterval = [self timeIntervalSinceDate:date];
    return  ((NSInteger) minutesTimeInterval % 60);
}



- (NSInteger)minutesBeforeDate:(NSDate *)date {
	NSTimeInterval minutesTimeInterval = [date timeIntervalSinceDate:self];
	return (NSInteger) (minutesTimeInterval / kMinute);
}

- (NSInteger)hoursAfterDate:(NSDate *)date {
	NSTimeInterval hoursTimeInterval = [self timeIntervalSinceDate:date];
	return (NSInteger) (hoursTimeInterval / kHour);
}

- (NSInteger)hoursBeforeDate:(NSDate *)date {
	NSTimeInterval hoursTimeInterval = [date timeIntervalSinceDate:self];
	return (NSInteger) (hoursTimeInterval / kHour);
}

- (NSInteger)daysAfterDate:(NSDate *)date {
	NSTimeInterval daysTimeInterval = [date timeIntervalSinceDate:date];
	return (NSInteger) (daysTimeInterval / kDay);
}

- (NSInteger)daysBeforeDate:(NSDate *)date {
	NSTimeInterval daysTimeInterval = [date timeIntervalSinceDate:self];
	return (NSInteger) (daysTimeInterval / kDay);
}

#pragma mark - Date Decomposing

- (NSInteger)nearestHour { // determines whether self is closer to hour x or hour x + 1
	NSTimeInterval newDateTimeInterval = [[NSDate date] timeIntervalSinceReferenceDate] + kMinute * 30;
	NSDate *newDate = [NSDate dateWithTimeIntervalSinceReferenceDate:newDateTimeInterval];
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:NSHourCalendarUnit fromDate:newDate];
	return components.hour;
}

- (NSInteger)hour {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	return components.hour;
}

- (NSInteger)minute {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	return components.minute;
}

- (NSInteger)seconds {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	return components.second;
}

- (NSInteger)day {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	return components.day;
}

- (NSInteger)month {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	return components.month;
}

- (NSInteger)week {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	return components.week;
}

- (NSInteger)weekday {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	return components.weekday;
}

- (NSInteger)nthWeekday { // e.g. the third Sunday of the month is 3
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	return components.weekdayOrdinal;
}

- (NSInteger)year {
    NSCalendar *currentCalendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [currentCalendar components:DATE_COMPONENTS fromDate:self];
	return components.year;
}


@end
