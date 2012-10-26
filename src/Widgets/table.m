#include <osxstep.h>
#include <XSTable.h>

void tableview_add_column(widget_t *table, char *identifier, int width, int type)
{
	XSTable *_table = (XSTable *)table->gptr;
	NSTableColumn *column = [[NSTableColumn alloc] initWithIdentifier:[NSString stringWithUTF8String:identifier]];
	[column setWidth:width];
	[_table addTableColumn:column];
	[column release];
}

void tableview_add_row(widget_t *table, tableRow_t items[])
{
	int i;
	id key, row;
	XSTable *_table = (XSTable *)table->gptr;
	NSTextFieldCell *cell;
	if ( [_table totalRows] >= 50) 
		return;
	NSAutoreleasePool  *autor = [[NSAutoreleasePool alloc] init];
	for (i = 0; items[i].identifier != nil; i++) {
		key = [NSString stringWithUTF8String:items[i].identifier];
		row = [[_table colDic] objectForKey:key];
		if(items[i].data == nil)
			break;
		cell = [[NSTextFieldCell alloc] init];
		[cell setStringValue:[NSString stringWithUTF8String:items[i].data]];
		[cell setFont:[NSFont systemFontOfSize:10]];
		[row addObject:cell];
		[cell release];
	}
	[autor drain];
	_table.totalRows++;
}

void tableview_del_row(widget_t *table, int rowIndex)
{
	XSTable *_table = (XSTable *)table->gptr;
	[_table clearTable];
	[_table reloadData];
}

tableview_t *tableview_create(widget_t *parent, float w, float h, float x, float y, char *name, unsigned int type)
{
	widget_t *table;
	id _parent = (id)(parent->gptr);

	table = widget_create(w, h, x, y, name, XS_WTYPE_TREEVIEW);
	XSTable * tableView = [[XSTable alloc] initWithFrame:NSMakeRect(x, y, w, h) andParent:_parent];
	
	[tableView setWptr:table];
	[tableView setParent:_parent];
	[tableView setFont:[NSFont systemFontOfSize:9]];

	table->gptr = tableView;

	[tableView setDelegate:tableView];
	[tableView setDataSource:tableView];

	[tableView sizeToFit];
	[tableView reloadData];

	widget_list_insert(parent, table);

	return (table);
}

void tableview_reload_data(widget_t *tableview)
{
	id table = (id)(tableview->gptr);
	[table reloadData];
}

void tableview_clear_table(widget_t *tableview)
{
	id table = (id)(tableview->gptr);
	[table clearTable];
}
