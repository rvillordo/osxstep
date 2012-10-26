#include <XSTree.h>
#include <AppKit/AppKit.h>
#include "osxstep.h"

treeview_t *treeview_create(widget_t *parent, float width, float height, float x, float y, char *title, char *rootPath) //node_t *rootNode)
{
	id pview;
	//char *datas[10] = { "root", "node 1", "node 2", "item 1 node 1", "item 2 node 1", "item 3 node 1", "item 4 node 1", "item 1 node 2", "item 2 node 2", NULL };
	treeview_t *tree;
	//int i = count_c(rootNode);
	//printf("TOTAL: %d\n", i);
	//exit(0);
	/*iter = node_iterator_create(rootNode->children);
	for(current = iter->begin; current != NULL; current = iter->next(iter)) {
		XSTreeList *child = [[XSTreeList alloc] initWithParent:lista];
		[child setStringValue:[NSString stringWithUTF8String:(char *)current->data]];
		[lista addChild:child];
		NSLog(@"CURRENT: %s", (char *)current->data);
	}*/

	/*root = node_create(NULL, strdup(datas[0]));
	node1 = node_create(root, strdup(datas[1]));
	node = node_create(node1, strdup(datas[3]));
	node = node_create(node1, strdup(datas[4]));
	node = node_create(node1, strdup(datas[5]));
	node = node_create(node1, strdup(datas[6]));
	node2 = node_create(root, strdup(datas[2]));
	node = node_create(node2, strdup(datas[7]));
	node = node_create(node2, strdup(datas[8]));*/

	//NSLog(@"LISTA: %@", _lista);
	if(parent == NULL)
		return (NULL);

	tree = (window_t *)widget_create(width, height, x, y, title, XS_WTYPE_TREEVIEW);
	tree->name = strdup(title);
	tree->type = XS_WTYPE_TREEVIEW;
	tree->tag = hash(title, strlen(title)) + hash(tree, sizeof(treeview_t));

	pview = (id)(parent->gptr);

	NSRect frame = NSMakeRect(x, y, width, height);

	XSTree *_tree = [[XSTree alloc] initWithFrame:frame andTitle:[NSString stringWithUTF8String:title] andDataSource:[NSString stringWithUTF8String:rootPath]];

	[_tree setParent:pview];
	[_tree setWptr:tree];
	[[pview contentView] addSubview:[_tree scrollView]];

	tree->gptr = (void *)_tree;

	widget_list_insert(parent, tree);

	return (tree);
}

char *treeview_get_selected(widget_t *parent)
{
	id view = parent->gptr;
	return ((char *)[view getSelected]);
}

void *treeview_get_list(widget_t *parent)
{
	id view= parent->gptr;
	return [view treeData];
}

void treeview_set_bgcolor(window_t *w, unsigned char color)
{
	NSWindow *window = (NSWindow *)w->gptr;
	switch(color) {
		case XS_COLOR_BLACK:
  [window setBackgroundColor:[NSColor blackColor]];
  break;
		case XS_COLOR_WHITE:
  [window setBackgroundColor:[NSColor whiteColor]];
  break;
		case XS_COLOR_GRAY:
 [window setBackgroundColor:[NSColor grayColor]]; 
 break;
		case XS_COLOR_RED:
[window setBackgroundColor:[NSColor redColor]];
break;
		case XS_COLOR_YELLOW:
   [window setBackgroundColor:[NSColor yellowColor]];
   break;
		case XS_COLOR_GREEN:
  [window setBackgroundColor:[NSColor greenColor]];
  break;
		case XS_COLOR_BLUE:
 [window setBackgroundColor:[NSColor blueColor]];
 break;
	}
}

