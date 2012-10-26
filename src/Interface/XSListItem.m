//
//  XSListItem.m
//  Created by rafael villordo on 06/09/11.
//  Copyright 2011 infralogic. All rights reserved.
//

#import "XSListItem.h"

@implementation XSListItem

static XSListItem 		*rootItem = nil;
static NSMutableArray 	*leafNode = nil;

+ (void)initialize 
{
    if (self == [XSListItem class]) 
	{
        leafNode = [[NSMutableArray alloc] init];
    }
}

- (XSListItem *)rootItem 
{
    return (rootItem);
}

- (id)initWithString:(NSString *)stringValue parent:(XSListItem *)parentItem 
{
    self = [super init];    
    if (self) {
		_parentItem = parentItem;
		_stringValue = stringValue;
		children = nil;
    }
    return self;    
}

- (id)setRootItem:(NSString *)stringValue
{
    rootItem = [[XSListItem alloc] initWithString:stringValue parent:nil];
    return (rootItem);
}

+ (XSListItem *)setRootItem:(NSString *)stringValue 
{
    rootItem = [[XSListItem alloc] initWithString:stringValue parent:nil];
    return (rootItem);
}

+ (XSListItem *)rootItem {
    return rootItem;
}

- (id)copy {
    return [super copy];
}

- (void)setChildren:(NSMutableArray *)chil
{
	children = chil;
}

- (NSArray *)children 
{
    return children;
}

- (XSListItem *)childAtIndex:(NSUInteger)n {
    
    return [[self children] objectAtIndex:n];
}

- (NSInteger)numberOfChildren {
    NSArray *tmp = [self children];
    return (tmp == leafNode) ? (-1) : [tmp count];
}

- (NSString *)getStringValue
{
	return _stringValue;
}

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
    NSTextFieldCell *c = cell;
	[c setNeedsDisplay:YES];
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item 
{
    return (item == nil) ? 1 : [item numberOfChildren];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item 
{    
    return (item == nil) ? YES : ([item numberOfChildren] != 0);    
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item 
{   
    return (item == nil) ? rootItem : [(XSListItem *)item childAtIndex:index];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item 
{
	XSListItem *l = item;
    if(item == nil)
        return nil;
    return [l getStringValue];
}



- (void)dealloc {
    
    if (children != leafNode) {        
        [children release];
    }
    
    [super dealloc];
}

@end
