//
// Author: Håvard Fossli <hfossli@agens.no>
//
// Copyright (c) 2013 Agens AS (http://agens.no/)
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

#import <XCTest/XCTest.h>
#import "AGSHashTable.h"

@interface AGSHashTableTest : XCTestCase

@end

@implementation AGSHashTableTest

#pragma mark - Construct and destruct

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}

- (void)testStrongStrong
{
    AGSHashTable *table = [AGSHashTable hashTableWithStrongToStrongObjects];
    
    __block NSObject *key = nil;
    
    @autoreleasepool {
        key = [NSObject new];
        table[key] = [NSObject new];
        XCTAssertNotNil(table[key], @"");
    }
    
    XCTAssertNotNil(table[key], @"");
}

- (void)testStrongWeak
{
    AGSHashTable *table = [AGSHashTable hashTableWithStrongToWeakObjects];
    
    __block NSObject *key = nil;
    
    @autoreleasepool {
        key = [NSObject new];
        NSObject *object = [NSObject new];
        table[key] = object;
        XCTAssertNotNil(table[key], @"");
    }
    
    XCTAssertNil(table[key], @"");
}

- (void)testStrongCopy
{
    AGSHashTable *table = [AGSHashTable hashTableWithStrongToCopyObjects];
    
    __block NSObject *key = nil;
    __block NSObject *object = nil;
    __block NSObject *storedObject = nil;
    
    @autoreleasepool {
        key = [NSObject new];
        object = [NSMutableArray arrayWithObject:@"test"];
        table[key] = object;
        storedObject = table[key];
        XCTAssert(storedObject != nil, @"");
    }
    
    XCTAssert(storedObject != nil, @"");
    XCTAssert(storedObject != object, @"");
    XCTAssert([storedObject isEqual:object], @"");
}

- (void)testWeakStrong
{
    AGSHashTable *table = [AGSHashTable hashTableWithWeakToStrongObjects];
    
    __weak NSObject *key = nil;
    
    @autoreleasepool {
        key = [NSMutableArray arrayWithObject:@"key"];
        NSObject *object = [NSMutableArray arrayWithObject:@"object"];
        table[key] = object;
        XCTAssertNotNil(table[key], @"");
    }
    
    XCTAssert(table[key] == nil, @"");
}

- (void)testWeakWeak
{
    AGSHashTable *table = [AGSHashTable hashTableWithWeakToStrongObjects];
    
    __weak NSObject *key = nil;
    
    @autoreleasepool {
        key = [NSMutableArray arrayWithObject:@"key"];
        NSObject *object = [NSMutableArray arrayWithObject:@"object"];
        table[key] = object;
        XCTAssertNotNil(table[key], @"");
    }
    
    XCTAssert(table[key] == nil, @"");
}

- (void)testWeakCopy
{
    AGSHashTable *table = [AGSHashTable hashTableWithWeakToCopyObjects];
    
    __weak NSObject *key = nil;
    
    @autoreleasepool {
        key = [NSMutableArray arrayWithObject:@"test"];
        NSObject *object = [NSMutableArray arrayWithObject:@"test"];
        table[key] = object;
        NSObject *storedObject = table[key];
        XCTAssertNotNil(table[key], @"");
        XCTAssert(storedObject != object, @"");
        XCTAssert([storedObject isEqual:object], @"");
    }
    
    XCTAssert(table[key] == nil, @"");
}

- (void)testCopyStrong
{
    AGSHashTable *table = [AGSHashTable hashTableWithCopyToStrongObjects];
    
    __weak NSObject *key = nil;
    
    @autoreleasepool {
        key = [NSMutableArray arrayWithObject:@"test"];
        NSObject *object = [NSMutableArray arrayWithObject:@"test"];
        table[key] = object;
        NSObject *storedObject = table[key];
        XCTAssertNotNil(table[key], @"");
        XCTAssert(storedObject == object, @"");
        XCTAssert([storedObject isEqual:object], @"");
    }
    
    XCTAssert(table[key] == nil, @"");
}

- (void)testCopyWeak
{
    AGSHashTable *table = [AGSHashTable hashTableWithCopyToWeakObjects];
    
    __block NSObject *key = nil;
    
    @autoreleasepool {
        key = [NSMutableArray arrayWithObject:@"key"];
        NSObject *object = [NSMutableArray arrayWithObject:@"object"];
        table[key] = object;
        XCTAssertNotNil(table[[NSMutableArray arrayWithObject:@"key"]], @"");
    }
    
    XCTAssertNil(table[key], @"");
}

- (void)testCopyCopy
{
    AGSHashTable *table = [AGSHashTable hashTableWithCopyToCopyObjects];
    
    @autoreleasepool {
        NSObject *key = [NSMutableArray arrayWithObject:@"test"];
        NSObject *object = [NSMutableArray arrayWithObject:@"test"];
        table[key] = object;
        NSObject *storedObject = table[key];
        XCTAssertNotNil(table[key], @"");
        XCTAssert(storedObject != object, @"");
        XCTAssert([storedObject isEqual:object], @"");
    }
    
    XCTAssertNotNil(table[[NSMutableArray arrayWithObject:@"test"]], @"");
}

- (void)testEach
{
    AGSHashTable *table = [AGSHashTable hashTableWithCopyToCopyObjects];
    table[@"test"] = @(1);
    table[@(4)] = @"ok";
    
    __block int numberOfCallbacks = 0;
    
    [table each:^(id key, id object, BOOL *stop) {
        if([key isKindOfClass:[NSString class]])
        {
            NSString *string = key;
            NSNumber *value = object;
            XCTAssert([string isEqualToString:@"test"], @"");
            XCTAssert([value isEqual:@(1)], @"");
        }
        if([key isKindOfClass:[NSNumber class]])
        {
            NSString *string = object;
            NSNumber *value = key;
            XCTAssert([string isEqualToString:@"ok"], @"");
            XCTAssert([value isEqual:@(4)], @"");
        }
        numberOfCallbacks++;
    }];
    
    XCTAssert(numberOfCallbacks == 2, @"");
}

@end
