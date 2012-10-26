#include <XSTable.h>

@implementation XSTable
@synthesize 	parent;
@synthesize 	wptr;
@synthesize		totalRows;
@synthesize		colDic;

- (id) initWithFrame:(NSRect)frame andParent:_parent
{
	NSScrollView * tableContainer = [[NSScrollView alloc] initWithFrame:frame];
	NSRect bound = [tableContainer bounds];
	id _self = [super initWithFrame:bound];
	if(_self) {
		totalRows = 0;
		colDic = [[NSMutableDictionary alloc] init];
		[_self setIntercellSpacing:NSMakeSize(2, 2)];
		//[_self setCellSpacing:2];
		[tableContainer setBorderType:NSBezelBorder];
		[tableContainer setDocumentView:_self];
		[tableContainer setHasVerticalScroller:YES];
		[tableContainer setHasHorizontalScroller:YES];
		//[tableContainer setVerticalScrollElasticity:NSScrollElasticityNone];
		//[tableContainer setHorizontalScrollElasticity:NSScrollElasticityNone];
		[tableContainer setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];

		[tableContainer setAutoresizesSubviews:YES];
		[[_parent contentView] addSubview:tableContainer];
	}
	return (_self);
}

- (void)addTableColumn:(NSTableColumn *)aTableColumn
{
	NSMutableArray *p = [[NSMutableArray alloc] init];
	[colDic setObject:p forKey:[aTableColumn identifier]];
	[[aTableColumn headerCell] setStringValue:[NSString stringWithString:[aTableColumn identifier]]];
	[aTableColumn setEditable:NO];
	//[aTableColumn setCellSpacing:NSMakeSize(0, 0)];
	[super addTableColumn:aTableColumn];
}

- (void)clearTable
{
	NSArray *p, *pa = [colDic objectsForKeys:[colDic allKeys] notFoundMarker:@"nil"];
	if(self.totalRows == 0)
		return;
	//NSLog(@"keys: %@", [colDic allKeys]);
	//for(i = 0; i < [pa count]; p = [pa objectAtIndex:i++]) {
	for( p in pa ) {
		NSLog(@"obj: [%@], key: [%@]", [p class], [colDic allKeysForObject:p]);
		[p release];
		//[colDic removeObjectsForKeys:[colDic allKeys]];
	}
	self.totalRows = 0;
}

- (NSInteger)numberOfRowsInTableView:(NSTableView *)aTableView
{
	return self.totalRows;
}

- (id)tableView:(NSTableView *)aTableView objectValueForTableColumn:(NSTableColumn    *)aTableColumn row:(NSInteger)rowIndex
{
	NSMutableArray *item = [self.colDic objectForKey:[aTableColumn identifier]];
	return (item == nil ? nil : [item objectAtIndex:rowIndex]);
}

- (void)mouseDown:(NSEvent *)theEvent
{
	[super mouseDown:theEvent];
}


@end
