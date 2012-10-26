//
//  ILOutlineViewController.m
//  Editor
//
//  Created by rafael villordo on 13/09/11.
//  Copyright 2011 infralogic. All rights reserved.
//

#import "XSTreeData.h"

@implementation XSTreeData

- (id)init
{
    id _self = [super init];
    if (_self) {
		[_self setRootNode:nil];
    }
    return _self;
}

- (void)dealloc
{
    [super dealloc];
}

- (void)setModified:(BOOL)state
{
    isMod = state;
}

- (BOOL)isModified
{
    return isMod;
}

- (id)setRootNode:(NSString *)node {
    if (node == nil) {
        [rootNode release];
        rootNode = nil;
    } else {
		rootNode = [FileSystemItem setRootItem:[NSString stringWithString:node]];
	}
    return (rootNode);
}

- (id)getRootNode {
    return (rootNode);
}

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
    NSTextFieldCell *c = cell;
	NSString *s;
    BOOL isSelected, isModified, expand;
	NSInteger depth;
    isSelected = [(FileSystemItem *)item isSelected];
    isModified = [(FileSystemItem *)item isModified];
	expand = [outlineView isExpandable:item];
	if(item == rootNode && item == [item rootItem]) {
		depth = 1;
	}
	else {
		depth =  [outlineView levelForItem:item] * 2 + 1;
	}

	[cell setEditable:NO];

	FileSystemItem *node = [outlineView itemAtRow:[outlineView selectedRow]];
	if(node != nil) {
		//NSLog(@"bla: %@", node);
		//if([outlineView isItemExpanded:node])
		//	[outlineView collapseItem:node];
	}

	if(expand && [outlineView isItemExpanded:item] == NO) {
		s = [[NSString alloc] initWithFormat:@"%@[+] %@", [@" " stringByPaddingToLength:depth withString:@" " startingAtIndex:0], [c stringValue]];
	} else if(expand && [outlineView isItemExpanded:item] == YES) {
		s = [[NSString alloc] initWithFormat:@"%@[-] %@", [@" " stringByPaddingToLength:depth withString:@" " startingAtIndex:0], [c stringValue]];
	} else {
		s = [[NSString alloc] initWithFormat:@"%@| - %@", [@" " stringByPaddingToLength:depth+2 withString:@" " startingAtIndex:0], [c stringValue]];
	}
	//NSString *s = [[c stringValue] stringByPaddingToLength:(depth+[[c stringValue] length]) withString:@"" startingAtIndex:0];
	//NSLog(@"str: %@", s);
	[c setStringValue:s];
	[s release];
    [c setTextColor:[NSColor blackColor]];
    if(expand)
        [c setTextColor:[NSColor blueColor]];
}

- (void)outlineView:(NSOutlineView *)outlineView didClickTableColumn:(NSTableColumn *)tableColumn
{
	NSLog(@"did click!");
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item 
{
    return (item == nil) ? 1 : [item numberOfChildren];
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item 
{    
    return (item == nil) ? YES : ([item numberOfChildren] != -1);    
}

- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item 
{   
    return (item == nil) ? rootNode : [(FileSystemItem *)item childAtIndex:index];
}

- (void)outlineViewSelectionDidChange:(NSNotification *)aNotification
{
	NSOutlineView *oview = [aNotification object];
	FileSystemItem *node = [oview itemAtRow:[oview selectedRow]];
	if ([oview isExpandable:node])  {
	//NSLog(@"haha, notification! %@, %@", aNotification, [[oview dataSource] getRootNode]);
	//	NSLog(@"EXPANDABLE!! %@, selected: %@", [node relativePath], [node fullPath]);
		if([oview isItemExpanded:node])
			 [oview collapseItem:node];
		else
			[oview expandItem:node expandChildren:NO]; 
	} 
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item 
{
    if(item == nil)
        return nil;
    return [item relativePath];
}
@end

/*
@implementation XSTreeList

- (id) init
{
	 return [ super initWithCapacity:128 ];
}

- (id) initWithParent:(id)_parent andList:(node_t *)list
{
	node_iterator_t *iter;
	node_t *current;
	self = [super initWithCapacity:(list->count)];
	if(self) {
		if (parent == nil) {
			_isRoot = true;
			_isLeaf = true;
		} else {
			_isRoot = false;
			_isLeaf = true;
		}
		_isNode = true;
		stringValue = [[NSString alloc] initWithUTF8String:(char *)list->data];
		iter = node_iterator_create(list->children);
		children = [[XSTreeList alloc] init];
	}
	return (self);
}

- (BOOL)isRoot
{
	return (_isRoot);
}

- (BOOL)isLeaf
{
	return (_isLeaf);
}

- (BOOL)isNode
{
	return (_isNode);
}

- (void)addChild:(id)child
{
	[children addObject:child];
}

- (void)setStringValue:(NSString *)value
{
	stringValue = value;
}

- (void)setIntValue:(NSInteger)value
{
	intValue = value;
}

- (void)setFloatValue:(CGFloat)value
{
	floatValue = value;
}

- (void)dealloc
{
	[children release];
	[super dealloc];
}

@end*/
