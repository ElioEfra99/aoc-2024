#import <Foundation/Foundation.h>

NSInteger safe(NSInteger value) {
    return value + 1;
}

NSInteger unsafe() {
    return 0;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *filePath = @"../input.txt";
        NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSArray *array = [fileContents componentsSeparatedByString:@"\n"];
        NSMutableArray *reports = [NSMutableArray array];
        
        for (NSString *element in array) {
            NSArray *someArray = [element componentsSeparatedByString:@" "];
            [reports addObject:someArray];
        }
        
        BOOL (^differenceWithinRange)(NSInteger, NSInteger) = ^BOOL(NSInteger left, NSInteger right) {
            NSInteger difference = labs(left - right);
            return difference >= 1 && difference <= 3;
        };
        
        BOOL (^doesNotSatisfyRules)(NSInteger, NSInteger, BOOL) = ^BOOL(NSInteger left, NSInteger right, BOOL isAscending) {
            if (isAscending) {
                return left > right || !differenceWithinRange(left, right);
            } else {
                return left < right || !differenceWithinRange(left, right);
            }
        };
        
        NSInteger totalSafeReports = 0;
        for (NSArray *report in reports) {
            BOOL isAscending = NO;
            
            NSInteger firstLevel = [report[0] integerValue];
            NSInteger secondLevel = [report[1] integerValue];
            
            if (firstLevel == secondLevel) {
                continue;
            } else if (firstLevel < secondLevel) {
                isAscending = YES;
            }
            
            if (!differenceWithinRange(firstLevel, secondLevel)) {
                continue;
            }
            BOOL shouldSkipOuterLoop = NO;
            for (int i = 1; i < ([report count] - 1); i++) {
                NSInteger leftLevel = [report[i] integerValue];
                NSInteger rightLevel = [report[i+1] integerValue];

                if (doesNotSatisfyRules(leftLevel, rightLevel, isAscending)) {
                    shouldSkipOuterLoop = YES;
                    continue;
                }
            }
            
            if (shouldSkipOuterLoop) {
                continue;
            }
            
            totalSafeReports += 1;
        }
        
        NSLog(@"%lu", totalSafeReports);
    }
    
    return 0;
}
