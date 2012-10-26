/* 
 * generic double linked list implementation
*/
#include "dllist.h"

list_t *list_init(void *content)
{
	list_t *list = (list_t *)malloc(sizeof(list_t));
	if(list == NULL)
		return ((list_t *)NULL);
	list->content = content;
	list->next = list->prev = NULL;
	list->head = list->tail = NULL;
	return (list);
}

void list_finish(list_t **list)
{
	list_t *p;
	LIST_FOREACH_NEXT(p, list)
		list_del(list, p);
}

void list_add(list_t **list, list_t *new)
{
	if((*list) == NULL) {
		new->next = new->prev = NULL;
		new->head = NULL;
		new->tail = new;
	} else {
		new->tail = (*list)->tail;
		new->next = (*list);
		new->prev = (*list)->prev;
		(*list)->prev = new;
		if(new->prev != NULL)
			new->prev->next = new;
		new->head = (*list)->prev;
	}
	*list = new;

}

void list_del(list_t **list, list_t *del)
{
	list_t *next, *prev;

	if(del == NULL) return;

	prev = del->prev;
	next = del->next;

	if(prev != NULL)
		prev->next = next;
	if(next != NULL)
		next->prev = prev;
	if(del == (*list)) {
		if(next != NULL)
			(*list) = next;
		else
			(*list) = prev;
	}
	del->content = NULL;
	free(del);
}

int list_compare(void *c1, void *c2)
{
	list_t *p;
	p = (list_t *)c1;
	if(p->content == c2)
		return (1);
	return (0);
}

list_t *list_search(list_t **list, void *data, int (*compare)(void *, void *), unsigned direction)
{
	list_t *p;

	if(compare == NULL)
		compare = list_compare;

	switch(direction) {
		case LIST_SEARCH_ALL:
			LIST_FOREACH_NEXT(p, list)
				if(compare(p, data))
					return (p);
			LIST_FOREACH_PREV(p, list)
				if(compare(p, data))
					return (p);
			break;
		case LIST_SEARCH_FORWARD:
			LIST_FOREACH_PREV(p, list) 
				if(compare(p, data))
					return (p);
			break;
		case LIST_SEARCH_BACKWARD:
			LIST_FOREACH_NEXT(p, list)
				if(compare(p, data))
					return (p);
			break;
		default:
			break;

	}
	return ((list_t *)NULL);
}


