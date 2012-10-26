#import <Cocoa/Cocoa.h>
#import <XSTree.h>
#import <XSListItem.h>

@implementation XSTree 

@synthesize parent;
@synthesize wptr;
@synthesize defaultFont;
@synthesize scrollView;
@synthesize treeData;
@synthesize dataSource;

-(id)initWithFrame:(NSRect)frame andTitle:(NSString *)title andData:(id)data
{
	id _self = [super init];
	if(_self) {
		scrollView = [[NSScrollView alloc] initWithFrame:frame];
		[_self setFrame:[scrollView bounds]];
		NSTableColumn *col = [[NSTableColumn alloc] initWithIdentifier:@"tree_column"];

		[[col headerCell] setStringValue:title];
		[col setWidth:[_self frame].size.width];
		[_self addTableColumn:col];
		[col release];

		[scrollView setBorderType:NSBezelBorder];
		[scrollView setHasVerticalScroller:YES];
		[scrollView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
		[scrollView setAutohidesScrollers:YES];
		//[scrollView setVerticalScrollElasticity:NSScrollElasticityNone];
		//[scrollView setHorizontalScrollElasticity:NSScrollElasticityNone];
		[scrollView setAutoresizesSubviews:YES];
		//[scrollView setVerticallyResizable:YES];
		//[scrollView setHorizontallyResizable:NO];
		[scrollView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];

		XSListItem *item = [XSListItem setRootItem:@"root item"];
		XSListItem *child = [[XSListItem alloc] initWithString:@"first child" parent:item];
		[child setRootItem:@"root item child"];
		NSMutableArray *nar = [[NSMutableArray alloc] initWithCapacity:10];
		[item setChildren:nar];
		XSListItem *child1 = [[XSListItem alloc] initWithString:@"first child" parent:item];
		//[child1 setRootItem:item];
		[nar addObject:child];
		[nar addObject:child1];

		//dataSource = [[XSTreeData alloc] init];
		//[dataSource setRootNode:@"/tmp/"];

		//[_self setDataSource:(id)dataSource];
		//[_self setDataSource:(id)item];
		[_self setDelegate:_self];
		//[_self expandItem:[dataSource getRootNode] expandChildren:NO];
		//[_self reloadData];

		[scrollView setDocumentView:_self];
		[scrollView setNeedsDisplay:YES];
	}
	return (_self);
}

-(id)initWithFrame:(NSRect)frame andTitle:(NSString *)title andDataSource:(NSString *)path
{
	id _self = [super init];
	if(_self) {
		scrollView = [[NSScrollView alloc] initWithFrame:frame];
		[_self setFrame:[scrollView bounds]];
		NSTableColumn *col = [[NSTableColumn alloc] initWithIdentifier:@"tree_column"];

		[[col headerCell] setStringValue:title];
		[col setWidth:[_self frame].size.width];
		[_self addTableColumn:col];

		[scrollView setBorderType:NSBezelBorder];
		[scrollView setHasVerticalScroller:YES];
		[scrollView setAutoresizingMask:NSViewHeightSizable|NSViewWidthSizable];
		//[scrollView setVerticalScrollElasticity:NSScrollElasticityNone];
		//[scrollView setHorizontalScrollElasticity:NSScrollElasticityNone];
		[scrollView setAutoresizesSubviews:YES];

		XSListItem *item = [XSListItem setRootItem:@"root item"];
		XSListItem *child = [[XSListItem alloc] initWithString:@"first child" parent:item];
		NSMutableArray *nar = [[NSMutableArray alloc] initWithCapacity:10];
		[item setChildren:nar];
		XSListItem *child1 = [[XSListItem alloc] initWithString:@"second child" parent:item];
		[nar addObject:child];
		[nar addObject:child1];
		XSListItem *child2 = [[XSListItem alloc] initWithString:@"third child" parent:child1];
		NSMutableArray *nar1 = [[NSMutableArray alloc] initWithCapacity:10];
		[nar1 addObject:child2];
		[child1 setChildren:nar1];

		//dataSource = [[XSTreeData alloc] init];
		//[dataSource setRootNode:@"/Users/rafael/osxtep-0.1/libwin/osxstep-0.2"];

		//[_self setIndentationMarkerFollowsCell:YES];
		[_self setDataSource:(id)item];

		//dataSource = [[XSTreeData alloc] init];
		//[dataSource setRootNode:path];
		//[_self setDataSource:dataSource];
		//[_self expandItem:[dataSource getRootNode] expandChildren:NO];

		[scrollView setDocumentView:_self];
		[scrollView setNeedsDisplay:YES];
		[_self setDelegate:_self];
		[_self setNeedsDisplay:YES];
		[_self reloadData];

		[col release];

	}
	return (_self);
}

- (id)getSelected
{
	return [self itemAtRow:[self selectedRow]];
}

- (void)setTreeData:(id)data
{
	treeData = (id)data;
}

- (id)getTreeData
{
	return (id)treeData;
}

- (void)mouseDown:(NSEvent *)theEvent
{
	[super mouseDown:theEvent];
	id item = [self itemAtRow:[self selectedRow]];
	BOOL isExpanded = [self isItemExpandable:item];
	if([theEvent clickCount] == 2) {
		if([self isItemExpanded:item]) {
			 [self collapseItem:item];
		} else if(isExpanded){
			[self expandItem:item];
		}
	}
}

- (void)outlineView:(NSOutlineView *)outlineView willDisplayCell:(id)cell forTableColumn:(NSTableColumn *)tableColumn item:(id)item
{
	NSTextFieldCell *c = cell;
	NSString *s;
	BOOL isSelected = false, isModified = false, expand;
	NSInteger depth;

	isSelected = isModified;

	NSLog(@"will display cell!\n");
	expand = [outlineView isExpandable:item];
	if(item == [item rootItem]) {
		depth = 0;
	}
	else {
		depth =  [outlineView levelForItem:item] * 2 + 1;
	}

	[cell setEditable:NO];
	[cell setFont:[NSFont systemFontOfSize:10]];

	if(expand && [outlineView isItemExpanded:item] == NO) {
		s = [[NSString alloc] initWithFormat:@"%@+ %@", [@" " stringByPaddingToLength:depth withString:@" " startingAtIndex:0], [c stringValue]];
	} else if(expand && [outlineView isItemExpanded:item] == YES) {
			   s = [[NSString alloc] initWithFormat:@"%@-  %@", [@" " stringByPaddingToLength:depth withString:@" " startingAtIndex:0], [c stringValue]];
	} else {
		s = [[NSString alloc] initWithFormat:@"%@-   %@", [@" " stringByPaddingToLength:depth+2 withString:@" " startingAtIndex:0], [c stringValue]];
	}
	[c setStringValue:s];
	[s release];
	[c setTextColor:[NSColor blackColor]];
	if(expand) {
		[c setTextColor:[NSColor blueColor]];
		[c setFont:[NSFont boldSystemFontOfSize:11]];
	}
}
/*
   - (void)outlineView:(NSOutlineView *)outlineView didClickTableColumn:(NSTableColumn *)tableColumn
   {
   NSLog(@"did click! %@\n", [[self dataSource] getRootNode]);
   }
   */

/*
 *
 *
 * DATA SOURCE
 *
 *
 */
- (id)outlineView:(NSOutlineView *)outlineView child:(NSInteger)index ofItem:(id)item 
{   
	NSLog(@"datasource porra");
	return (item == nil) ? (id)[self treeData] : [[item children] objectAtIndex:index];
}

- (id)outlineView:(NSOutlineView *)outlineView objectValueForTableColumn:(NSTableColumn *)tableColumn byItem:(id)item 
{
	NSLog(@"lero lero");
	return (item == nil ? @"null" : (id)[item data]);
}

- (NSInteger)outlineView:(NSOutlineView *)outlineView numberOfChildrenOfItem:(id)item 
{
	NSLog(@"laskjdlajsd");
	return (item == nil) ? 1 : [[item children] count];
}

- (BOOL) isItemExpandable:(id)item
{
	return (item == nil ? NO : ([[item children] count] ? YES : NO));
}

- (BOOL)outlineView:(NSOutlineView *)outlineView isItemExpandable:(id)item
{
	NSLog(@"IS ITEM EXPANDABLE?!? %@", item);
	return (item == nil ? NO : ([[item children] count] ? YES : NO));
}

@end
