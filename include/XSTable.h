#include <osxstep.h>

@interface XSTable : NSTableView <NSTableViewDelegate, NSTableViewDataSource>
{
	id 					parent;
	void 				*wptr;
	NSMutableDictionary *colDic;
	int					totalRows;
}
@property (assign) id parent;
@property (assign) void *wptr;
@property (assign) NSMutableDictionary *colDic;
@property (assign) int totalRows;

- (id)initWithFrame:(NSRect)frame andParent:(id)parent;
- (void)clearTable;

@end

@interface XSTableView : NSOutlineView <NSOutlineViewDataSource, NSOutlineViewDelegate>
{
}

@end

