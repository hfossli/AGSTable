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

#import <Foundation/Foundation.h>

@protocol AGSTableEntry <NSObject>

+ (id)new;
+ (id)alloc;
- (id)key;
- (id)object;
- (void)setKey:(id)key;
- (void)setObject:(id)object;

@end


@interface AGSTableEntryHelper : NSObject

+ (BOOL)entry:(id<AGSTableEntry>)entry isEqualTo:(id<AGSTableEntry>)otherEntry;
+ (BOOL)key:(id)key isEqualToKey:(id)otherKey;
+ (BOOL)object:(id)object isEqualToObject:(id)otherObject;

@end

@interface AGSTableEntryStrongStrong : NSObject <AGSTableEntry>
@property (nonatomic, strong) id key;
@property (nonatomic, strong) id object;
@end

@interface AGSTableEntryStrongWeak : NSObject <AGSTableEntry>
@property (nonatomic, strong) id key;
@property (nonatomic, weak)   id object;
@end

@interface AGSTableEntryStrongCopy : NSObject <AGSTableEntry>
@property (nonatomic, strong) id key;
@property (nonatomic, copy)   id <NSCopying> object;
@end

@interface AGSTableEntryWeakStrong : NSObject <AGSTableEntry>
@property (nonatomic, weak)   id key;
@property (nonatomic, strong) id object;
@end

@interface AGSTableEntryWeakWeak : NSObject <AGSTableEntry>
@property (nonatomic, weak)   id key;
@property (nonatomic, weak)   id object;
@end

@interface AGSTableEntryWeakCopy : NSObject <AGSTableEntry>
@property (nonatomic, weak)   id key;
@property (nonatomic, copy)   id <NSCopying> object;
@end

@interface AGSTableEntryCopyStrong : NSObject <AGSTableEntry>
@property (nonatomic, copy)   id <NSCopying> key;
@property (nonatomic, strong) id object;
@end

@interface AGSTableEntryCopyWeak : NSObject <AGSTableEntry>
@property (nonatomic, copy)   id <NSCopying> key;
@property (nonatomic, weak)   id object;
@end

@interface AGSTableEntryCopyCopy : NSObject <AGSTableEntry>
@property (nonatomic, copy)   id <NSCopying> key;
@property (nonatomic, copy)   id <NSCopying> object;
@end


