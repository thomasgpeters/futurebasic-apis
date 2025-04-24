//
//  NSDate+Utilities.h
//
//  Created by BrianS on 8/19/13.
//  Copyright (c) 2013 BrilorSoftware. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Utilities)

+(void)year:(NSInteger *)y
      month:(NSInteger *)m
        day:(NSInteger *)d
   fromDate:(NSDate *) passedDate;

+(NSDate *)janFirstThisYear;                              // returns January 1st of the current year as NSDate
+(NSDate *) dateFromYear:(NSInteger)yr                    // send it yr = 2019, mo = 03 and day = 4 and returns NSDate
                andMonth:(NSInteger)mo
                  andDay:(NSInteger)day;

+ (NSDate *)cleanseDate:(NSDate *)theDate;                // limits NSDate to "yyyy-MM-dd"
                                                          // created to elminate time from NSDate due to bug when
                                                          // storing an NSDate in an XML file

+ (NSDate *)dateByAddingDays:(NSDate *)date               // either adds( positive number ) or subtracts ( negative number )
                          days:(NSInteger)days            // the specified days, months and years from from date and returns NSDate
                        months:(NSInteger)months
                         years:(NSInteger)years;

+ (NSDateComponents *)diffDate:(NSDate *)date1            // Return difference between two dates in years, months and days
                       andDate:(NSDate*) date2
                    components:(NSCalendarUnit)units;

+(NSString *)shortStyleFromDate:(NSDate *)theDate;
+(NSString *)mediumStyleFromDate:(NSDate *)theDate;
+(NSString *)longStyleFromDate:(NSDate *)theDate;
+(NSString *)yearFromDate:(NSDate *)theDate;              // returns 4-digit year as a string
+(NSString *)monthFromDate:(NSDate *)theDate;             // returns month number( as a string ) from 1 to 12
+(NSString *)dayFromDate:(NSDate *)theDate;               // returns day number( as a string ) from 1 to 31

+(NSString *)dayNameFromDate:(NSDate *)theDate;           // returns day name: Wednesday, Monday etc.
+(NSString *)monthNameFromDate:(NSDate *)theDate;         // returns full month name: October, April, etc.

+(NSString *)currentYear;                                 // returns current 4-digit year as a string
+(NSString *)currentMonth;                                // returns current month number( as a string ) from 1 to 12
+(NSString *)currentDay;                                  // returns current day number( as a string ) from 1 to 31

+(NSInteger)monthNumberFromName:(NSString *)name;         // send it October and it returns 10
+(NSString *)monthNameFromNumber:(NSInteger)monthNum;     // send it 10 and it returns October
+(NSInteger)weekDayNumberFromDate:(NSDate *)theDate;      // returns the weekday such as 13, 22, 31, 10, etc. so if date is July 23 it would return 23.
+(NSInteger)monthNumberFromDate:(NSDate *)theDate;        // returns 1,2,3,4,5,6,7,8,9,10,11 or 12

+(NSInteger)dayNumberFromName:(NSString *)name;           // 0 = Sunday, 1 = Monday, 2 = Tuesday, 3 = Wednesday, 4 = Thursday, 5 = Friday, 6 = Saturday.
+(NSInteger)daysInMonth:(NSDate *) date;                  // returns 28, 29, 30 or 31
+(NSString *)YYYYMMDDStrFromDate:(NSDate *)passedDate;      // converts NSDate to string in YYMMDD format
+(NSDate *)dateFromYYMMDDStr:(NSString *)string;
+(BOOL)isThisDate:(NSDate *)date1 equalToSecondDate:(NSDate *)date2 ;
@end
