#include <stdio.h>
#include "osxstep.h"

#define XS_ALERT_INFO 0

label_t		*luser, *lpass, *bglabel, *txtlabel;
box_t		*box;
window_t	*window;
treeview_t 	*dirlist;
view_t 		*view;

int on_button_quit(void *p1)
{
	return (XSAppQuit());
}

int drawRect(void *data)
{
	view_draw_line((view_t *)data, 1, 10, 280, 1, 1, 1);
	return (0);
}

int main(int argc, const char **argv)
{
	screen_t 	*screen;
	button_t 	*button;
	label_t		*label;
	combobox_t	*combobox;
	char *names[] = {
		"root node",
		"child 1",
		"expandable 1",
		"child 1", "child 2",
		"expandable 2",
		NULL
	};

	XSAppInit();

	screen 	= screen_create(0,0);

	window	= window_create(screen, 640, 480, 160, 160," osxstep v0.1 ", 0);
	window_set_bgcolor(window, XS_COLOR_GRAY);

	box		= box_create(window, 295, 210, 12, 255, ".:[ box example ]:.", 0);

	label 	= label_create(box, 80, 15, 12, 18, "usuario: ", XS_LABEL_NORMAL);
	label 	= label_create(box, 80, 15, 12, 38, "senha: ", XS_LABEL_NORMAL);
	widget_set_fontStyle(label, XS_FONT_STYLE_BOLD);

	iuser 	= inputbox_create(box, 80, 18, 95, 18, "user", XS_INPUT_NORMAL);
	ipass 	= inputbox_create(box, 80, 18, 95, 38, "pass", XS_INPUT_PASSWORD);

	button 	= button_create(box, 58, 22, 95 + 85, 36, " check ", &on_button_check);
	button->runInBackground = 1;

	button	= button_create(box, 58, 22, (295 - 62 - 8), 210 - (28 * 2), "clear", &on_button_clear);
	button	= button_create(box, 58, 22, (295 - 62 - 8), (210 - 28), "quit", &on_button_quit);

	bglabel = label_create(box, 80, 15, 12, 60, "background color", XS_LABEL_NORMAL);
	widget_set_background(bglabel, XS_COLOR_YELLOW);

	txtlabel 	= label_create(box, 80, 15, 12, 80, "text color: ", XS_LABEL_BIG);
	widget_set_textColor(txtlabel, XS_COLOR_RED);

	combobox = combobox_create(box, 120, 22, 12, 90, "cores", &on_combo_change);
	combobox_add_item(combobox, "vermelho 1");
	combobox_add_item(combobox, "verde    2");
	combobox_add_item(combobox, "amarelo  3");
	combobox_add_item(combobox, "azul     4");

	dirlist = treeview_create(window, 300, 210, 12, 20, "treeview", "/Users/rafael/osxtep-0.1/libwin/osxstep-0.2/");
	//dirlist = treeview_create(window, 300, 210, 12, 20, "treeview", root);

	table = tableview_create(window, 290, 210, 320, 250, "tableview", 0);
	tableview_add_column(table, "ip", 75, 0);
	tableview_add_column(table, "user", 75, 0);
	tableview_add_column(table, "senha", 75, 0);

	level = progressbar_create(box, 200, 18, 10, 10, 0, 100, XS_WTYPE_PROGRESS_BAR);

	button = checkbutton_create(box, 150, 18, 140, 90, "checkbutton", on_checkbutton);
	button = radiobutton_create(box, 150, 18, 140, 70, "radio1", NULL);
	button = radiobutton_create(box, 150, 18, 200, 70, "radio2", NULL);

	clocklabel = label_create(window, 200, 18, 570, 460, "00:00:00", XS_LABEL_NORMAL);
	widget_set_fontStyle(clocklabel, XS_FONT_STYLE_BOLD);
	widget_set_event(clocklabel, XS_EVENT_TICK, update_clock);
	widget_set_textColor(clocklabel, XS_COLOR_GREEN);

	view = view_create(window, 290, 210, 320, 190, "lero", 0);
	widget_set_background(view, XS_COLOR_YELLOW);
	widget_set_event(view, XS_EVENT_EXPOSE, &drawRect);

	//sliderbar_create(box, 200, 22, 10, 50, 0, 100, XS_WTYPE_SLIDE_BAR);
	//view_draw_line(view, 10, 0, 0, 10, 0, 100);

	XSAddTimer(XS_WAIT_MAINLOOP, 1.0, clocklabel);

	return (XSAppMain(screen, argc, argv));
}
