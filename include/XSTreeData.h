//
//  ILOutlineViewController.h
//  Editor
//
//  Created by rafael villordo on 13/09/11.
//  Copyright 2011 infralogic. All rights reserved.
//

#import <AppKit/AppKit.h>
#import "FilesystemItem.h"

@interface XSTreeData : NSObject <NSOutlineViewDataSource>
{
    FileSystemItem      *rootNode;
    BOOL                isMod;
}

- (void)setModified:(BOOL)state;
- (BOOL)isModified;

- (id)setRootNode:(NSString *)node;
- (id)getRootNode;

@end
