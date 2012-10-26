#include <stdio.h>
#include <math.h>
#include "osxstep.h"

label_t *digital;
view_t *analog;

int on_button_quit(void *p1)
{
	return (XSAppQuit());
}

int analog_update(void *p1)
{
	widget_set_update(analog);
	return (0);
}

int digital_update(void *data)
{
	time_t now = time(NULL);
	struct tm *tm = localtime(&now);
	char buf[64];

	snprintf(buf, sizeof(buf), "%02d:%02d:%02d", tm->tm_hour, tm->tm_min, tm->tm_sec);
	label_set_text(digital, buf);
	widget_set_update(digital);
}

int analog_draw(void *data)
{
	widget_t *wid = analog;
	time_t reference = time(NULL);
	struct tm *stm;

	int x,y,d,i;

	x=(wid->geometry.w)/2;
	y=(wid->geometry.h)/2;

	d=((wid->geometry.w>wid->geometry.h)?wid->geometry.h:wid->geometry.w)-8;

	stm=localtime(&reference);

	for(i=0;i!=60;i++) {

		if(i%5==0)
			view_draw_line((view_t *)wid, 1, 2, 
					x+(int)(sin((i)*2.0*M_PI/60.0)*d/2.3),
					y-(int)(cos((i)*2.0*M_PI/60.0)*d/2.3),
					x+(int)(sin((i)*2.0*M_PI/60.0)*d/2.0),
					y-(int)(cos((i)*2.0*M_PI/60.0)*d/2.0));             
		else
			view_draw_line((view_t *)wid, 1, 10, 
					x+(int)(sin((i)*2.0*M_PI/60.0)*d/2.1),
					y-(int)(cos((i)*2.0*M_PI/60.0)*d/2.1),
					x+(int)(sin((i)*2.0*M_PI/60.0)*d/2.0),
					y-(int)(cos((i)*2.0*M_PI/60.0)*d/2.0));
	}

	view_draw_line((view_t *)wid, 1, 2, 
			x,y,
			x+(int)(sin((stm->tm_hour%12+stm->tm_min/60.0)*2.0*M_PI/12.0)*d/4.0),
			y-(int)(cos((stm->tm_hour%12+stm->tm_min/60.0)*2.0*M_PI/12.0)*d/4.0));
	view_draw_line((view_t *)wid, 1, 2, 
			x,y,
			x+(int)(sin(stm->tm_min*2.0*M_PI/60.0)*d/3.0),
			y-(int)(cos(stm->tm_min*2.0*M_PI/60.0)*d/3.0));

	view_draw_line((view_t *)wid, 1, 4, 
			x,y,
			x+(int)(sin(stm->tm_sec*2.0*M_PI/60.0)*d/2.5),
			y-(int)(cos(stm->tm_sec*2.0*M_PI/60.0)*d/2.5));

	widget_set_update(wid);
	return (0);
}

int main(int argc, const char **argv)
{
	screen_t 	*screen;
	button_t 	*quit;
	window_t 	*win;

	XSAppInit();

	screen 	= screen_create(0,0);
	win		= window_create(screen, 180, 180, 160, 160," clock example ", 0);
	window_set_bgcolor(win, XS_COLOR_BLACK);
	analog = view_create(win, 100, 80, (180/2) - 50, (60 - 80), "analog clock", 0);
	widget_set_event(analog, XS_EVENT_EXPOSE, &analog_draw);
	widget_set_event(analog, XS_EVENT_TICK, &analog_update);

	button_create(win, 58, 22, 180-58-5, 180-28, "quit", &on_button_quit);
	digital = label_create(win, 64, 25, 4, 180-28, "00:00:00", XS_LABEL_BIG);
	widget_set_fontSize(digital, 18);
	widget_set_textColor(digital, XS_COLOR_BLUE);
	widget_sizeToFit(digital);
	widget_set_event(digital, XS_EVENT_TICK, &digital_update);

	XSAddTimer(XS_WAIT_MAINLOOP, 1.0, analog);
	XSAddTimer(XS_WAIT_MAINLOOP, 1.0, digital);

	return (XSAppMain(screen, argc, argv));
}
