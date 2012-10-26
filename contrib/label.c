#include <stdio.h>
#include "osxstep.h"

label_t		*luser, *lpass, *bglabel, *txtlabel;
label_t *clocklabel;

int on_button_quit(void *p1)
{
	return (XSAppQuit());
}

int update_clock(void *data)
{
	char tdate[16];
	time_t now = time(NULL);
	struct tm *tm = localtime(&now);
	snprintf(tdate, 16, "%02d:%02d:%02d", tm->tm_hour, tm->tm_min, tm->tm_sec);
	label_set_text(clocklabel, tdate);
	return (0);
}

int on_combo_change(void *p1)
{
	char	*item;
	int i;
	widget_t *combobox = (widget_t *)p1;
	item = combobox_get_selected(combobox);
	i = atoi(index(item, ' ') + 1);
	widget_set_background(bglabel, i);
	return (i);
}

int main(int argc, const char **argv)
{
	screen_t 	*screen;
	window_t *window;
	button_t *button;
	label_t		*label;
	combobox_t	*combobox;

	XSAppInit();

	screen 	= screen_create(0,0);

	window	= window_create(screen, 640, 480, 160, 160," osxstep v0.1 ", 0);
	window_set_bgcolor(window, XS_COLOR_GRAY);

	button	= button_create(window, 58, 22, (295 - 62 - 8), (210 - 28), "quit", &on_button_quit);

	bglabel = label_create(window, 80, 15, 12, 60, "background color", XS_LABEL_NORMAL);
	widget_set_background(bglabel, XS_COLOR_YELLOW);

	txtlabel 	= label_create(window, 80, 15, 12, 80, "text color: ", XS_LABEL_BIG);
	widget_set_textColor(txtlabel, XS_COLOR_RED);

	combobox = combobox_create(window, 120, 22, 12, 90, "cores", &on_combo_change);
	combobox_add_item(combobox, "vermelho 1");
	combobox_add_item(combobox, "verde    2");
	combobox_add_item(combobox, "amarelo  3");
	combobox_add_item(combobox, "azul     4");

	clocklabel = label_create(window, 200, 18, 570, 460, "00:00:00", XS_LABEL_NORMAL);
	widget_set_fontStyle(clocklabel, XS_FONT_STYLE_BOLD);
	widget_set_event(clocklabel, XS_EVENT_TICK, update_clock);
	widget_set_textColor(clocklabel, XS_COLOR_GREEN);

	XSAddTimer(XS_WAIT_MAINLOOP, 1.0, clocklabel);

	return (XSAppMain(screen, argc, argv));
}
