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

#import "AGSTableEntry.h"


@implementation AGSTableEntryHelper

+ (BOOL)entry:(id<AGSTableEntry>)entry isEqualTo:(id<AGSTableEntry>)otherEntry
{
    if(entry == otherEntry)
    {
        return YES;
    }
    else if([entry isKindOfClass:[otherEntry class]])
    {
        BOOL equalKeys = [self key:entry.key isEqualToKey:otherEntry.key];
        BOOL equalObjects = [self object:entry.object isEqualToObject:otherEntry.object];
        if(equalKeys && equalObjects)
        {
            return TRUE;
        }
    }
    return FALSE;
}

+ (BOOL)key:(id)key isEqualToKey:(id)otherKey
{
    return [key isEqual:otherKey];
}

+ (BOOL)object:(id)object isEqualToObject:(id)otherObject
{
    return [object isEqual:otherObject];
}

@end

@implementation AGSTableEntryStrongStrong
- (BOOL)isEqual:(id)instance
{
    return [AGSTableEntryHelper entry:self isEqualTo:instance];
}
@end

@implementation AGSTableEntryStrongWeak
- (BOOL)isEqual:(id)instance
{
    return [AGSTableEntryHelper entry:self isEqualTo:instance];
}

- (void)setObject:(id)object
{
    _object = object;
}

- (void)dealloc
{
    
}

@end

@implementation AGSTableEntryStrongCopy
- (BOOL)isEqual:(id)instance
{
    return [AGSTableEntryHelper entry:self isEqualTo:instance];
}
@end

@implementation AGSTableEntryWeakStrong
- (BOOL)isEqual:(id)instance
{
    return [AGSTableEntryHelper entry:self isEqualTo:instance];
}
@end

@implementation AGSTableEntryWeakWeak
- (BOOL)isEqual:(id)instance
{
    return [AGSTableEntryHelper entry:self isEqualTo:instance];
}
@end

@implementation AGSTableEntryWeakCopy
- (BOOL)isEqual:(id)instance
{
    return [AGSTableEntryHelper entry:self isEqualTo:instance];
}
@end

@implementation AGSTableEntryCopyStrong
- (BOOL)isEqual:(id)instance
{
    return [AGSTableEntryHelper entry:self isEqualTo:instance];
}
@end

@implementation AGSTableEntryCopyWeak
- (BOOL)isEqual:(id)instance
{
    return [AGSTableEntryHelper entry:self isEqualTo:instance];
}
@end

@implementation AGSTableEntryCopyCopy
- (BOOL)isEqual:(id)instance
{
    return [AGSTableEntryHelper entry:self isEqualTo:instance];
}
@end

