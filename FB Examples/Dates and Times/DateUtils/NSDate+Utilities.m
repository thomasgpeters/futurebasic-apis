//
//  NSDate+Utilities.m
//
//  Created by BrianS on 8/19/13.
//  Copyright (c) 2013 BrilorSoftware. All rights reserved.
//

#import "NSDate+Utilities.h"

@implementation NSDate (Utilities)

+ (NSInteger)daysBetweenDate:(NSDate*)fromDateTime andDate:(NSDate*)toDateTime
{
    NSDate *fromDate;
    NSDate *toDate;
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate
                 interval:NULL forDate:fromDateTime];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate
                 interval:NULL forDate:toDateTime];
    
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay
                                               fromDate:fromDate toDate:toDate options:0];
    
    return [difference day];
}

+(NSDate *)dateFromYYMMDDStr:(NSString *)string {
    NSDateComponents *comps = [[[NSDateComponents alloc] init]autorelease];
    [comps setYear:[[string substringToIndex:4]integerValue]];
    [comps setMonth:[[string substringWithRange:NSMakeRange(4, 2)]integerValue]];
    [comps setDay:[[string substringFromIndex:6]integerValue]];

    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+(void)year:(NSInteger *)y
      month:(NSInteger *)m
        day:(NSInteger *)d
   fromDate:(NSDate *) passedDate {
    
    NSCalendar *cal = [NSCalendar currentCalendar];
    *y = [cal component:NSCalendarUnitYear fromDate:passedDate];
    *m = [cal component:NSCalendarUnitMonth fromDate:passedDate];
    *d = [cal component:NSCalendarUnitDay fromDate:passedDate];
}

+(NSString *)YYYYMMDDStrFromDate:(NSDate *)passedDate {
    NSString *monthFormat, *dayFormat;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    
    NSInteger year  = [calendar component:NSCalendarUnitYear fromDate:passedDate];
    NSInteger month = [calendar component:NSCalendarUnitMonth fromDate:passedDate];
    NSInteger day   = [calendar component:NSCalendarUnitDay fromDate:passedDate];
    if ( month > 9 ) monthFormat = @"%ld"; else monthFormat = @"0%ld";
    if ( day   > 9 ) dayFormat   = @"%ld"; else dayFormat   = @"0%ld";
    NSString *formatString = [NSString stringWithFormat:@"%@%@%@",@"%ld", monthFormat, dayFormat ];
    NSString *stringDate = [NSString stringWithFormat:formatString,year,month,day];
    return stringDate;
}
+(NSDate *)janFirstThisYear{
   
    //NSDateComponents *comps = [[[NSDateComponents alloc] init]autorelease];
    //[comps setYear:[[NSDate currentYear] integerValue]];
    //NSInteger year = [[NSDate currentYear] integerValue];
    return [NSDate dateFromYear:[[NSDate currentYear] integerValue] andMonth:1 andDay:1];
    //[comps setMonth:1];
    //[comps setDay:1];
    //[comps setHour:0];
    //[comps setMinute:0];
    //[comps setSecond:0];
    
    //return [[NSCalendar currentCalendar] dateFromComponents:comps];
}
+(NSDate *) dateFromYear:(NSInteger)yr
                andMonth:(NSInteger)mo
                  andDay:(NSInteger)day {
    NSDateComponents *comps = [[[NSDateComponents alloc] init]autorelease];
    [comps setYear:yr];
    [comps setMonth:mo];
    [comps setDay:day];
    [comps setHour:0];
    [comps setMinute:0];
    [comps setSecond:0];
    
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}
+ (NSDate *)cleanseDate:(NSDate *)date {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    return [formatter dateFromString:[formatter stringFromDate:date]];
}

+ (NSDate *)dateByAddingDays:(NSDate *)date
                          days:(NSInteger)days
                        months:(NSInteger)months
                         years:(NSInteger)years
{
    // create a dateComponents to add years, months and days to a date
    NSDateComponents *newComponents = [[[NSDateComponents alloc] init]autorelease];
    [newComponents setYear:years];
    [newComponents setMonth:months];
    [newComponents setDay:days];

    // get a new date by adding components
    return  [[NSCalendar currentCalendar] dateByAddingComponents:newComponents toDate:date options:0];
}
+ (NSDateComponents *)diffDate:(NSDate *) date1
                       andDate:(NSDate *) date2
                    components:(NSCalendarUnit)units {
    return [[NSCalendar currentCalendar] components:units fromDate:date1 toDate:date2 options:0];
}

+(NSString *)componentOfDate:(NSDate *) theDate
                 usingFormat:(NSDateFormatter *)formatter {
    
   return [formatter stringFromDate:theDate];
}

+(NSString *)mediumStyleFromDate:(NSDate *)theDate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    return [NSDate componentOfDate:theDate usingFormat:formatter];
}
+(NSString *)longStyleFromDate:(NSDate *)theDate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateStyle:NSDateFormatterLongStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    return [NSDate componentOfDate:theDate usingFormat:formatter];
}


+(NSString *)shortStyleFromDate:(NSDate *)theDate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateStyle:NSDateFormatterShortStyle];
    [formatter setTimeStyle:NSDateFormatterNoStyle];
    return [NSDate componentOfDate:theDate usingFormat:formatter];
}

+(NSString *)yearFromDate:(NSDate *)theDate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"yyyy"];
    return [NSDate componentOfDate:theDate usingFormat:formatter];
}

+(NSString *)monthFromDate:(NSDate *)theDate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"MM"];
    return [NSDate componentOfDate:theDate usingFormat:formatter];
}

+(NSString *)dayFromDate:(NSDate *)theDate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"d"];
    return [NSDate componentOfDate:theDate usingFormat:formatter];
}


+(NSString *)currentYear {
    return [NSDate yearFromDate:[NSDate date]];
}

+(NSString *)currentMonth {
    return [NSDate monthFromDate:[NSDate date]];
}

+(NSString *)currentDay {
    return [NSDate dayFromDate:[NSDate date]];
}

+(NSString *)dayNameFromDate:(NSDate *)theDate {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    [formatter setDateFormat:@"EEEE"];
    return [NSDate componentOfDate:theDate usingFormat:formatter];
}

+(NSString *)monthNameFromDate:(NSDate *)theDate {
    NSDateFormatter *f = [[[NSDateFormatter alloc] init]autorelease];
    //NSLocale *locale = [NSLocale currentLocale];
    //[f setLocale:locale];
    //NSString *monthSymbol = [[f monthSymbols] objectAtIndex:(1 - 1)];
    //return monthSymbol;
    [f setDateFormat:@"MMMM"];
    return [f stringFromDate:theDate];
}
+(NSInteger)weekDayNumberFromDate:(NSDate *)theDate {
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] autorelease];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitWeekday fromDate:theDate];
    return [comps weekday];

}
+(NSInteger)monthNumberFromDate:(NSDate *)theDate {
    NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian] autorelease];
    NSDateComponents *comps = [gregorian components:NSCalendarUnitMonth fromDate:theDate];
    return [comps month];
    
}


/*
 The block method to access the index in fast enumeration might be better but I don't know blocks yet. Plus Apple's docs recommend tracking the index yourself 
 
 "If you need to keep track of the current index, simply count the iterations as they occur:"
 from "Fast Enumeration Makes It Easy to Enumerate a Collection" here: https://developer.apple.com/library/ios/documentation/cocoa/conceptual/ProgrammingWithObjectiveC/FoundationTypesandCollections/FoundationTypesandCollections.html#//apple_ref/doc/uid/TP40011210-CH7-SW1
 
 [savedArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
 
 //... Do your usual stuff here
 
 obj  // This is the current object
 idx  // This is the index of the current object
 stop // Set this to true if you want to stop
 
 */

// send it October and it returns 10
+(NSInteger)monthNumberFromName:(NSString *)name {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
     return [[formatter monthSymbols] indexOfObject:name] + 1;
}


// send it 10 and it returns October
+(NSString *)monthNameFromNumber:(NSInteger)monthNum {
    NSString *retStr = nil;
    
    if ( monthNum >= 1 && monthNum <= 12 ) {
        NSDateFormatter *formatter = [[[NSDateFormatter alloc] init] autorelease];
        retStr = [[formatter monthSymbols] objectAtIndex:monthNum - 1];
  
    }
        return retStr;
}

+(NSInteger)dayNumberFromName:(NSString *)name {
    NSDateFormatter *formatter = [[[NSDateFormatter alloc] init]autorelease];
    return [[formatter weekdaySymbols] indexOfObject:name]; 
}

+(NSInteger)daysInMonth:(NSDate *) date {
    NSRange range = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay
                                                       inUnit:NSCalendarUnitMonth
                                                      forDate:date];
    return range.length;
}

+(BOOL)isThisDate:(NSDate *)date1 equalToSecondDate:(NSDate *)date2 {
    NSCalendar       *calendar  = [NSCalendar currentCalendar];
    NSCalendarUnit    unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay;
    NSDateComponents *cmp1      = [calendar components:unitFlags fromDate:date1];
    NSDateComponents *cmp2      = [calendar components:unitFlags fromDate:date2];
    
    return [cmp1 day]   == [cmp2 day] &&
           [cmp1 month] == [cmp2 month] &&
           [cmp1 year]  == [cmp2 year];
}


@end
