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

#import "AGSHashTable.h"
#import "AGSTableEntry.h"

@interface AGSHashTable ()

@property (nonatomic, strong) Class <AGSTableEntry> entryClass;
@property (nonatomic, strong) NSMutableArray *entries;

@end

@implementation AGSHashTable

#pragma mark - Construct and destruct

+ (id)hashTableWithStrongToStrongObjects
{
    Class entryClass = [AGSTableEntryStrongStrong class];
    return [self newWithEntryClass:entryClass];
}

+ (id)hashTableWithStrongToWeakObjects
{
    Class entryClass = [AGSTableEntryStrongWeak class];
    return [self newWithEntryClass:entryClass];
}

+ (id)hashTableWithStrongToCopyObjects
{
    Class entryClass = [AGSTableEntryStrongCopy class];
    return [self newWithEntryClass:entryClass];
}

+ (id)hashTableWithWeakToStrongObjects
{
    Class entryClass = [AGSTableEntryWeakStrong class];
    return [self newWithEntryClass:entryClass];
}

+ (id)hashTableWithWeakToWeakObjects
{
    Class entryClass = [AGSTableEntryWeakWeak class];
    return [self newWithEntryClass:entryClass];
}

+ (id)hashTableWithWeakToCopyObjects
{
    Class entryClass = [AGSTableEntryWeakCopy class];
    return [self newWithEntryClass:entryClass];
}

+ (id)hashTableWithCopyToStrongObjects
{
    Class entryClass = [AGSTableEntryCopyStrong class];
    return [self newWithEntryClass:entryClass];
}

+ (id)hashTableWithCopyToWeakObjects
{
    Class entryClass = [AGSTableEntryCopyWeak class];
    return [self newWithEntryClass:entryClass];
}

+ (id)hashTableWithCopyToCopyObjects
{
    Class entryClass = [AGSTableEntryCopyCopy class];
    return [self newWithEntryClass:entryClass];
}

+ (id)newWithEntryClass:(Class<AGSTableEntry>)entryClass
{
    AGSHashTable *instance = [[self alloc] initWithEntryClass:entryClass];
    return instance;
}

- (id)initWithEntryClass:(Class<AGSTableEntry>)entryClass
{
    self = [super init];
    if (self)
    {
        self.entryClass = entryClass;
        self.entries = [NSMutableArray array];
    }
    return self;
}

- (id)init
{
    [NSException raise:NSInvalidArgumentException format:@"Use designated initalizers"];
    return nil;
}

- (NSUInteger)indexOfObjectForKey:(id)key
{
    NSUInteger index = [self.entries indexOfObjectPassingTest:^BOOL(id <AGSTableEntry> needle, NSUInteger idx, BOOL *stop) {
        return [AGSTableEntryHelper key:key isEqualToKey:needle.key];
    }];
    return index;
}

- (id <AGSTableEntry>)entryForKey:(id)key
{
    NSUInteger index = [self indexOfObjectForKey:key];
    if(index != NSNotFound)
    {
        id <AGSTableEntry> entry = self.entries[index];
        if(entry.key == nil || [entry object] == nil)
        {
            [self.entries removeObject:entry];
            entry = nil;
        }
        return entry;
    }
    return nil;
}

- (id)objectForKey:(id)key
{
    return [[self entryForKey:key] object];
}

- (void)setObject:(id)object forKey:(id)key
{
    if(object == nil)
    {
        [self removeObjectForKey:key];
    }
    else
    {
        id <AGSTableEntry> entry = [self entryForKey:key];
        if(entry == nil)
        {
            entry = [self.entryClass new];
            entry.key = key;
            [self.entries addObject:entry];
        }
        entry.object = object;
    }
}

- (void)removeObjectForKey:(id)key
{
    id <AGSTableEntry> entry = [self entryForKey:key];
    if(entry != nil)
    {
        [self.entries removeObject:entry];
    }
}

- (void)each:(void(^)(id key, id object, BOOL *stop))block
{
    [[self.entries copy] enumerateObjectsUsingBlock:^(id <AGSTableEntry> entry, NSUInteger idx, BOOL *stop) {
        if([entry key] == nil || [entry object] == nil)
        {
            [self.entries removeObject:entry];
        }
        else
        {
            block(entry.key, entry.object, stop);
        }
    }];
}

- (id)objectForKeyedSubscript:(id)key
{
    return [self objectForKey:key];
}

- (void)setObject:(id)obj forKeyedSubscript:(id)key
{
    [self setObject:obj forKey:key];
}

@end
