//
//  FilesystemItem.h
//  Editor
//
//  Created by rafael villordo on 06/09/11.
//  Copyright 2011 infralogic. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FileSystemItem : NSObject
{
    NSString        *relativePath;
    NSMutableString *rootPath;
    
    FileSystemItem  *parent;
    
    BOOL            isDir;
    BOOL            isSel;
    BOOL            isMod;
    
    NSMutableString *data;
    
    NSMutableArray  *children;
}

+ (FileSystemItem *)    rootItem;
+ (FileSystemItem *)    setRootItem:(NSString *)path;

- (id)                  initWithPath:(NSString *)path parent:(FileSystemItem *)parentItem;

- (void)save;

- (id)                  setRootItem:(NSString *)path;

- (void)                setData:(NSString *)pData;
- (NSMutableString *)          getData;

- (NSInteger)           numberOfChildren;           // Returns -1 for leaf nodes
- (FileSystemItem *)    childAtIndex:(NSUInteger)n; // Invalid to call on leaf nodes
- (FileSystemItem *)    childByPath:(NSString *)path;

- (NSMutableString *)   fullPath;
- (NSString *)          relativePath;

- (BOOL)                isDirectory;

- (void)                setModified:(BOOL)state;
- (BOOL)                isModified;

- (void)                setSelected:(BOOL)state;
- (BOOL)                isSelected;


@end
