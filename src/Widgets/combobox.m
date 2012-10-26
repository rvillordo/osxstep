#include <XSComboBox.h>
#include <osxstep.h>

combobox_t *combobox_create(widget_t *parent, float w, float h, float x, float y, char *title, int (*cb)(void *))
{
	combobox_t *combobox;

	if(parent == NULL) 
		return (NULL);

	XSComboBox *combo = [[XSComboBox alloc] initWithFrame:NSMakeRect(x, y, w, h)];
	id pview = (parent->gptr);

	combobox = (combobox_t *)widget_create(w, h, x, y, title, XS_WTYPE_COMBOBOX);
	combobox->name = strdup(title);
	combobox->type = XS_WTYPE_COMBOBOX;

	combobox->tag = hash(title, strlen(title)) + hash(combobox, sizeof(combobox_t));

	[combo setStringValue:[NSString stringWithUTF8String:title]];
	[combo setEditable:NO];
	[combo setFont:[NSFont systemFontOfSize:10]];
	[combo setItemHeight:20];
	[combo setParent:pview];
	[combo setWptr: combobox];
	[combo setCallback:cb];

	combobox->parent = parent;
	combobox->gptr = combo;

	[[pview contentView] addSubview:combo];

	return (combobox);
}

void combobox_add_item(combobox_t *combo, char *value)
{
	XSComboBox *cbox = (XSComboBox *)combo->gptr;

	[cbox addItemWithObjectValue:[NSString stringWithUTF8String:value]];
	[cbox reloadData];
}

char *combobox_get_selected(combobox_t *combobox)
{
	XSComboBox *combo = (XSComboBox *)combobox->gptr;
	char *sel = (char *)[[combo objectValueOfSelectedItem] UTF8String];

	return (sel);
}
