#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *filePath = @"../input.txt";
        NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
        
        NSArray *pairs = [fileContents componentsSeparatedByString:@"\n"];
        
        NSMutableArray *list1 = [NSMutableArray array];
        NSMutableArray *list2 = [NSMutableArray array];
        
        for (NSString *pair in pairs) {
            NSArray *components = [pair componentsSeparatedByString:@"   "];
            
            [list1 addObject:@([components[0] integerValue])];
            [list2 addObject:@([components[1] integerValue])];
        }
        
        NSComparisonResult (^ascendingComparison)(NSNumber *num1, NSNumber *num2) = ^NSComparisonResult(NSNumber *num1, NSNumber *num2) {
            if ([num1 integerValue] < [num2 integerValue]) {
                return NSOrderedAscending;
            } else if ([num1 integerValue] > [num2 integerValue]) {
                return NSOrderedDescending;
            } else {
                return NSOrderedSame;
            }
        };
        
        // Sort the array in ascending order using a comparator block
        [list1 sortUsingComparator:ascendingComparison];
        [list2 sortUsingComparator:ascendingComparison];
        
        NSInteger totalDistance = 0;
        for (int i = 0; i < (int)[list1 count]; i++) {
            totalDistance += labs([list1[i] integerValue] - [list2[i] integerValue]);
        }
        
        NSLog(@"%ld", totalDistance);
    }
    
    return 0;
}
