#include <XSTree.h>
#include "osxstep.h"

treeview_t *treeview_create(widget_t *parent, float width, float height, float x, float y, char *title, void *list)
{
	id pview;
	treeview_t *tree;

	if(parent == NULL)
		return (NULL);

	tree = (window_t *)widget_create(width, height, x, y, title, XS_WTYPE_TREEVIEW);
	tree->name = strdup(title);
	tree->type = XS_WTYPE_TREEVIEW;
	tree->tag = hash(title, strlen(title)) + hash(tree, sizeof(treeview_t));

	pview = (id)(parent->gptr);

	NSRect frame = NSMakeRect(x, y, width, height);

	//XSTree *_tree = [[XSTree alloc] initWithFrame:frame andTitle:[NSString stringWithUTF8String:title] andList:list];
	XSTree *_tree = [[XSTree alloc] initWithFrame:frame andTitle:[NSString stringWithUTF8String:title] andDataSource:[NSString stringWithUTF8String:(char *)list]];

	[[pview contentView] addSubview:[_tree scrollView]];

	tree->gptr = (void *)_tree;

	widget_list_insert(parent, tree);

	return (tree);
}

void *treeview_get_selected(widget_t *parent)
{
	id view = parent->gptr;
	node_t *node = [view getSelected];
	return (node);
}
