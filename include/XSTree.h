#import <XSTreeData.h>

@interface XSTree : NSOutlineView
{
	id 							parent;
	void 						*wptr;
	NSFont						*defaultFont;
	NSScrollView				*scrollView;
	id							treeData;
	XSTreeData					*dataSource;
}
@property (assign) id 			parent;
@property (assign) void 		*wptr;
@property (assign) NSFont 		*defaultFont;
@property (assign) NSScrollView *scrollView;
@property (assign) id 			treeData;
@property (assign) XSTreeData	*dataSource;

- (id)initWithFrame:(NSRect)frame andTitle:(NSString *)title andData:(id)data;
- (id)initWithFrame:(NSRect)frame andTitle:(NSString *)title andDataSource:(NSString *)path;

- (id)getSelected;
- (id)getTreeData;
- (void)setTreeData:(id)data;
- (BOOL)isItemExpandable:(id)item;

@end
