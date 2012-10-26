#ifndef DLLIST_H
#define DLLIST_H

#include <stdio.h>
#include <stdlib.h>

typedef struct dllist list_t;

struct dllist {
	void 	*content;
	list_t	*next, *prev;
	list_t  *head, *tail;
};

#define LIST_SEARCH_FORWARD		0
#define LIST_SEARCH_BACKWARD	1
#define LIST_SEARCH_ALL			2

/* loop backward */
#define LIST_FOREACH_NEXT(var, __list) \
	for(var = (*__list)->head; var; var = var->next)

/* loop forward */
#define LIST_FOREACH_PREV(var, __list) \
	for(var = (*__list)->tail; var; var = var->prev)

#define print_next(var, l) \
	LIST_FOREACH_NEXT(var, l) { \
		printf("NEXT: %p, (prev: %p, next: %p)\n", var, var->prev, var->next); \
	}
#define print_prev(var, l) \
	LIST_FOREACH_PREV(var, l) { \
		printf("PREV: %p, (prev: %p, next: %p)\n", var, var->prev, var->next); \
	}

#define LIST_LAST_NEXT(__list) (*__list)->tail->prev->next
#define LIST_LAST_PREV(__list) (*__list)->head->next->prev

#define LIST_NEXT(l) l->next
#define LIST_PREV(l) l->prev

list_t 	*list_init(void *);
void	list_finish(list_t **);

int 	list_compare(void *, void *);

list_t  *list_search(list_t  **, void *, int (*)(void *, void *), unsigned);

void 	list_add(list_t **, list_t *);
void 	list_del(list_t **, list_t *);

#endif
