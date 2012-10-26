#ifndef WIDGET_H 
#define WIDGET_H

typedef enum osxstep_color_list {
	XS_COLOR_LIST_BACKGROUND = 0,
	XS_COLOR_LIST_FOREGROUND,
	XS_COLOR_LIST_BORDER,
	XS_COLOR_LIST_FOCUS,
	XS_COLOR_LIST_MAX
} XS_WIDGET_COLOR_LIST;

typedef enum osxstep_color {
	XS_COLOR_BLACK	= 0,
	XS_COLOR_RED,
	XS_COLOR_GREEN,
	XS_COLOR_YELLOW,
	XS_COLOR_BLUE,
	XS_COLOR_MAGENTA,
	XS_COLOR_CYAN,
	XS_COLOR_WHITE,
	XS_COLOR_GRAY,
	XS_COLOR_RESERVED,
	XS_COLOR_RESET,
	XS_COLOR_NONE = 0xFF
} XS_COLOR_LIST;

typedef enum osxstep_color_mod {
	XS_COLOR_MOD_NORMAL = 0,
	XS_COLOR_MOD_BOLD,
	XS_COLOR_MOD_BLINK,
	XS_COLOR_MOD_SWAP,
	XS_COLOR_MOD_UNDERLINE,
	XS_COLOR_MOD_RESET
} XS_COLOR_MODIFIER;

typedef enum osxstep_widget_types {

XS_WTYPE_SCREEN = 1,
XS_WTYPE_WINDOW,
XS_WTYPE_VIEW,
XS_WTYPE_BOX,
XS_WTYPE_PATHVIEW,
XS_WTYPE_TREEVIEW,
XS_WTYPE_TABLEVIEW,
XS_WTYPE_SCROLLVIEW,

XS_WTYPE_LABEL,
XS_WTYPE_INPUTBOX,
XS_WTYPE_INPUTBOX_PASSWORD,
XS_WTYPE_INPUTBOX_FOTMATTED,

XS_WTYPE_BUTTON,
XS_WTYPE_BUTTON_PUSH,
XS_WTYPE_BUTTON_CHECK,
XS_WTYPE_BUTTON_RADIO,
XS_WTYPE_BUTTON_TOGGLE,

XS_WTYPE_COMBOBOX,
XS_WTYPE_POPUP,
XS_WTYPE_MENU,

XS_WTYPE_SLIDE_BAR,
XS_WTYPE_PROGRESS_BAR,
XS_WTYPE_PROGRESS_ROUND,
XS_WTYPE_LEVELBAR,

XS_WTYPE_MAX

} XS_WIDGET_TYPE_LIST;

typedef enum {

	XS_EVENT_EXPOSE = 1,
	XS_EVENT_RESIZE,
	XS_EVENT_UPDATE,

	XS_EVENT_FOCUS_ENTER,
	XS_EVENT_FOCUS_LEAVE,

	XS_EVENT_MOUSE_DOWN,
	XS_EVENT_MOUSE_UP,
	XS_EVENT_MOUSE_CLICK,
	XS_EVENT_MOUSE_MOVE,

	XS_EVENT_KEYPRESS,

	XS_EVENT_CLOSE,

	XS_EVENT_TICK,

	XS_EVENT_MAX

} XS_WIDGET_EVENT_LIST;

typedef struct {
	float	w, h, x, y;
} XSRect;

typedef struct {
	char	*identifier;
	void 	*data;
} tableRow_t;

/* WIDGET STRUCTURE */
typedef struct widget {
	/* identification and visual properties */
	char 			*name;				/* widget title/name */
	unsigned int	tag;				/* widget hash */
	void			*gptr;				/* general purpose pointer */
	XSRect			geometry;			/* widget geometry */
	
	XSRect			aGeometry;			/* animation geometry */

	unsigned char	type;				/* widget type */

	/* callbacks and thread properties */
	cbptr_t			event[XS_EVENT_MAX];/* widget events callback pointer array */
	unsigned char	runInBackground;	/* perform event on a new thread */

	/* widgets global lists and parent linking properties */
	list_t			*cwlist;
	struct widget	*parent;

} widget_t;

/* widgets */
typedef widget_t	checkbutton_t;
typedef widget_t	radiobutton_t;
typedef widget_t	scrollview_t;
typedef widget_t	progressbar_t;
typedef widget_t	sliderbar_t;
typedef widget_t	inputbox_t;
typedef widget_t	textarea_t;
typedef widget_t 	treeview_t;
typedef widget_t 	tableview_t;
typedef widget_t 	combobox_t;
typedef widget_t	screen_t;
typedef widget_t	window_t;
typedef widget_t	button_t;
typedef widget_t	label_t;
typedef widget_t 	box_t;
typedef widget_t 	view_t;

widget_t 		*widget_create(float width, float height, float x, float y, char *name, int type);

/* set properties */
void 			widget_set_title(widget_t *widget, char *title);
void 			widget_set_style(widget_t *widget, unsigned char style);
void 			widget_set_type(widget_t *widget, unsigned char type);
void			widget_set_event(widget_t *widget, int, cbptr_t evCallback);

void			widget_set_backgroundColor(widget_t *wid, XS_COLOR_LIST color);
void			widget_set_foregroundColor(widget_t *wid, XS_COLOR_LIST color);

void 			widget_list_insert(widget_t *, widget_t *);
widget_t 		*widget_list_tail(widget_t *);
widget_t 		*widget_list_head(widget_t *);

screen_t 		*screen_create(float width, float height);

checkbutton_t 	*checkbutton_create(widget_t *, float, float, float, float, char *, int (*)(void *));
radiobutton_t 	*radiobutton_create(widget_t *, float, float, float, float, char *, int (*)(void *));
progressbar_t 	*progressbar_create(widget_t *parent, float, float, float, float, float, float,  unsigned int);
scrollview_t	*scrollview_create(widget_t *, float, float, float, float, char *, unsigned int);
sliderbar_t 	*sliderbar_create(widget_t *parent, float, float, float, float, float, float, int (*)(void *));
combobox_t 		*combobox_create(widget_t *, float, float, float, float, char *, int (*)(void *));
tableview_t 	*tableview_create(widget_t *parent, float w, float h, float x, float y, char *name, unsigned int type);
treeview_t 		*treeview_create(widget_t *, float, float, float, float, char *, char *);
inputbox_t 		*inputbox_create(widget_t *, float, float, float, float, char *, unsigned int);
window_t 		*window_create(widget_t *, float, float, float, float, char *, unsigned long);
button_t 		*button_create(widget_t *, float, float, float, float, char *, int (*)(void *));
label_t			*label_create(widget_t *, float, float, float, float, char *, unsigned int);
view_t			*view_create(widget_t *, float, float, float, float, char *, unsigned int);
box_t 			*box_create(widget_t *, float, float, float, float, char *, unsigned int);



void inputbox_set_max_length(widget_t *input, int length);
void inputbox_set_text(widget_t *input,  char *text);
char *inputbox_get_text(widget_t *input);

void widget_set_max_inputlen(widget_t *, int);
void widget_set_text(widget_t *,  char *text);
char *widget_get_text(widget_t *);

void label_set_text(widget_t *input, char *text);

void widget_set_textColor(widget_t *, int _color);
void widget_set_background(widget_t *, int _color);

void widget_set_update(widget_t *);

#define XS_INPUT_NORMAL			0
#define XS_INPUT_PASSWORD		1

#define XS_FONT_SIZE_SMALL		8
#define XS_FONT_SIZE_NORMAL		11
#define XS_FONT_SIZE_BIG		14

#define XS_FONT_STYLE_NORMAL	0
#define XS_FONT_STYLE_BOLD		1
#define XS_FONT_STYLE_ITALIC	2
#define XS_FONT_STYLE_UNDERLINE 3

#define XS_LABEL_SMALL			0
#define XS_LABEL_NORMAL			1
#define XS_LABEL_BIG			2


void 	widget_set_fontSize(widget_t *, int size);
void 	widget_set_fontStyle(widget_t *, int style);
void 	widget_set_textFontType(widget_t *, int type);

void	button_set_enabled(widget_t *, int);
void	button_set_state(widget_t *, int);

void 	widget_set_state(widget_t *, unsigned char);
void 	widget_set_visible(widget_t *, unsigned char);

void 	combobox_add_item(combobox_t *, char *);
char 	*combobox_get_selected(combobox_t *);

void  	progressbar_set_value(progressbar_t *, float);
float 	progressbar_get_value(progressbar_t *);
void  	progressbar_set_disable(progressbar_t *progress);


void 	tableview_add_row(widget_t *table, tableRow_t items[]);
void 	tableview_add_column(widget_t *table, char *, int, int);
void 	tableview_clear_table(widget_t *table);
void 	tableview_reload_data(widget_t *table);

char 	*treeview_get_selected(widget_t *parent);
void	*treeview_get_list(widget_t *parent);

extern unsigned int hash(void *, unsigned int);

void view_draw_line(widget_t *view, int lineWidth, long color, int x, int y, int xl, int yl);


#endif
