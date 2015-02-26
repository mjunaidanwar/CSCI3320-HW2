//
//  Calculator-Brain.h
//  Calculator
//
//  Created by Mohammed Junaid Anwar on 2/2/15.
//  Copyright (c) 2015 Calculator. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator_Brain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@end
