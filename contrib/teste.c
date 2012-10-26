#include <stdio.h>
#include "osxstep.h"

inputbox_t	*iuser, *ipass;
label_t		*luser, *lpass, *bglabel, *txtlabel, *svalue;
box_t		*box;
progressbar_t *level;
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

int on_slider_change(void *data)
{
	int value = *(int *)data;
	char text[128];
	sprintf(text, "slider value: %d", value);
	label_set_text(svalue, text);
	progressbar_set_value(level, value);
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

int on_checkbutton(void *p1)
{
	widget_set_textColor(txtlabel, rand() % XS_COLOR_LIST_MAX);
	return (1);
}

int on_button_check(void *p1)
{
	char *user = inputbox_get_text(iuser);
	char *pass = inputbox_get_text(ipass);
	printf("User: %s, pass: %s\n", user, pass);
	return (1);
}

int main(int argc, const char *argv[], const char **envp)
{
	screen_t 	*screen;
	window_t 	*window;
	button_t 	*button;
	label_t		*label;
	combobox_t	*combobox;

	XSAppInit();

	screen 	= screen_create(0,0);

	window	= window_create(screen, 320.0, 240.0, 160.0, 160.0," osxstep v0.1 ", 0);
	window_set_bgcolor(window, XS_COLOR_GRAY);

	box		= box_create(window, 295, 210, 12, 12, ".:[ box example ]:.", 0);

	label 	= label_create(box, 80, 15, 12, 18, "usuario: ", XS_LABEL_NORMAL);
	label 	= label_create(box, 80, 15, 12, 38, "senha: ", XS_LABEL_NORMAL);
	widget_set_fontStyle(label, XS_FONT_STYLE_BOLD);

	iuser 	= inputbox_create(box, 100, 18, 95, 18, "user", XS_INPUT_NORMAL);
	ipass 	= inputbox_create(box, 100, 18, 95, 38, "pass", XS_INPUT_PASSWORD);

	button 	= button_create(box, 58, 22, 95 + 105, 36, " check ", &on_button_check);

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

	level = progressbar_create(box, 200, 18, 10, 10, 0, 100, XS_WTYPE_PROGRESS_BAR);
	progressbar_set_value(level, 32.0);

	button = checkbutton_create(box, 150, 18, 140, 90, "checkbutton", &on_checkbutton);
	button = radiobutton_create(box, 150, 18, 140, 70, "radio1", NULL);
	button = radiobutton_create(box, 150, 18, 200, 70, "radio2", NULL);

	clocklabel = label_create(window, 200, 18, 320 - 60, -2, "00:00:00", XS_LABEL_NORMAL);
	widget_set_fontStyle(clocklabel, XS_FONT_STYLE_BOLD);
	widget_set_event(clocklabel, XS_EVENT_TICK, update_clock);
	widget_set_textColor(clocklabel, XS_COLOR_GREEN);

	sliderbar_create(box, 150, 22, 10, 50, 0, 100, &on_slider_change);
	svalue = label_create(window, 200, 18, 200, 155, "slider value: 0", XS_LABEL_NORMAL);

	XSAddTimer(XS_WAIT_MAINLOOP, 1.0, clocklabel);

	return (XSAppMain(screen, argc, argv));
}
