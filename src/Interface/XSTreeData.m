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
    self = [super init];
    if (self) {
        rootNode = nil;
    }
    return self;
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
    } else
        rootNode = [FileSystemItem setRootItem:node];
    
    return (rootNode);
}

- (id)getRootNode {
    return (rootNode);
}

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
	NSLog(@"bla bla");
    NSTextFieldCell *c = cell;
    BOOL isSelected, isModified;
    isSelected = [(FileSystemItem *)item isSelected];
    isModified = [(FileSystemItem *)item isModified];

    [c setTextColor:[NSColor blackColor]];
    if(isModified)
        [c setTextColor:[NSColor redColor]];
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

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item {
    if(item == nil)
        return nil;
    return [item relativePath];
}



@end
