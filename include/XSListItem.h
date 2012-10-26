//
//  FilesystemItem.h
//  Editor
//
//  Created by rafael villordo on 06/09/11.
//  Copyright 2011 infralogic. All rights reserved.
//

#import <AppKit/AppKit.h>
#import <Foundation/Foundation.h>

@interface XSListItem : NSObject
{
    XSListItem  		*_parentItem;
	NSString			*_stringValue;
    NSMutableArray  	*children;
}

+ (XSListItem *)    	rootItem;
+ (XSListItem *)    	setRootItem:(NSString *)stringValue;

- (void)				setChildren:(NSMutableArray *)chil;

- (id)                  initWithString:(NSString *)stringValue parent:(XSListItem *)parentItem;

- (id)                  setRootItem:(NSString *)stringValue;
- (NSString *)getStringValue;

- (NSInteger)           numberOfChildren;           // Returns -1 for leaf nodes
- (XSListItem *)    	childAtIndex:(NSUInteger)n; // Invalid to call on leaf nodes
- (id)children;

@end
