//
//  FilesystemItem.m
//  Editor
//
//  Created by rafael villordo on 06/09/11.
//  Copyright 2011 infralogic. All rights reserved.
//

#import "FilesystemItem.h"

@implementation FileSystemItem

static FileSystemItem *rootItem = nil;
static NSMutableArray *leafNode = nil;

+ (void)initialize {
    if (self == [FileSystemItem class]) {
        leafNode = [[NSMutableArray alloc] init];
    }
}

- (void)setSelected:(BOOL)state
{
    isSel = state;
}

- (BOOL)isSelected
{
    return isSel;
}

- (FileSystemItem *)rootItem {
    return (rootItem);
}

- (id)initWithPath:(NSString *)path parent:(FileSystemItem *)parentItem {
    self = [super init];    
    BOOL isValid, isDirectory;
    
    if (self) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *mPath = parentItem ? [[parentItem fullPath] stringByAppendingPathComponent:path] : path;
        isValid = [fileManager fileExistsAtPath:mPath isDirectory:&isDirectory];
        if(isValid && !isDirectory)  {
            data = [[NSMutableString alloc] initWithContentsOfFile:mPath encoding:NSUTF8StringEncoding error:NULL];
        }
        else 
            data = nil;
        
        isDir = isDirectory;
        isMod = FALSE;
        rootPath = [[NSMutableString alloc] initWithString:mPath];
        relativePath = [[mPath lastPathComponent] copy];
        parent = parentItem;    
    }
    return self;    
}

- (id)setRootItem:(NSString *)path {
    rootItem = [[FileSystemItem alloc] initWithPath:path parent:nil];
    return (rootItem);
}

+ (FileSystemItem *)setRootItem:(NSString *)path {
    rootItem = [[FileSystemItem alloc] initWithPath:path parent:nil];
    return (rootItem);
}

+ (FileSystemItem *)rootItem {
    return rootItem;
}

- (id)copy {
    return [super copy];
}

- (void)setData:(NSString *)pData
{
    [data setString:pData];
}

- (NSMutableString *)getData
{
    return (data);
}

- (void) save
{
    NSString *content;
    if (isMod == TRUE) {
        content = [self getData];
        NSLog(@"Saving file: %@\n%@", [self fullPath], content);
        [content writeToFile:[self fullPath] atomically:YES encoding:NSUTF8StringEncoding error:NULL];
        isMod = FALSE;
    }
}

- (NSArray *)children {
    if (children == nil) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSMutableString *path = [self fullPath];
        BOOL valid;
        
        valid = [fileManager fileExistsAtPath:path isDirectory:&isDir];
        
        if (valid && isDir) { //&& !([[self relativePath] isEqualToString:@"build"])) {
            NSArray *array = [fileManager contentsOfDirectoryAtPath:path error:NULL];
            NSUInteger numChildren, i;
            numChildren = [array count];
            children = [[NSMutableArray alloc] initWithCapacity:numChildren];
            for (i = 0; i < numChildren; i++) {
                NSString *file = [array objectAtIndex:i];
                if (([[file lastPathComponent] isEqualToString:@"Makefile"] == TRUE) || ([[file pathExtension] isEqualToString:@"c"] == TRUE) || ([[file pathExtension] isEqualToString:@"h"] == TRUE) || (isDir == TRUE)) {
                    FileSystemItem *newChild = [[FileSystemItem alloc] initWithPath:file parent:self];                    
                    [children addObject:newChild];
                    [newChild release];
                } else {
                    
                }
            }
        } else {
            children = leafNode;
        }
    }
    return children;
}

- (NSString *)relativePath {    
    return relativePath;
}

- (BOOL) isDirectory {
    return isDir;
}

- (NSString *)fullPath {
    
    if (parent == nil) {
        return rootPath;
    }
    return [[parent fullPath] stringByAppendingPathComponent:relativePath];    
}

- (FileSystemItem *)childByPath:(NSString *)path {
    NSUInteger i;
    for(i = 0; i < [[self children] count]; i++) {
        if ([[[[self children] objectAtIndex:i] relativePath] isEqualToString:path])
            return [[self children] objectAtIndex:i];
    }
    return (nil);
}

- (void)setModified:(BOOL)state
{
    isMod = state;
}

- (BOOL)isModified
{
    return isMod;
}

- (FileSystemItem *)childAtIndex:(NSUInteger)n {
    
    return [[self children] objectAtIndex:n];
}

- (NSInteger)numberOfChildren {
    
    NSArray *tmp = [self children];
    return (tmp == leafNode) ? (-1) : [tmp count];
}

- (void)dealloc {
    
    if (children != leafNode) {        
        [children release];
    }
    
    [relativePath release];
    [super dealloc];
}

@end
