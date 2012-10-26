#include <stdio.h>
#include <math.h>
#include "osxstep.h"

label_t *digital;
view_t *analog;
float **data, *max, gmax;
int cols = 800; 
int rows = 200;

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

int analog_draw(void *_data)
{
	widget_t *wid = analog;
	time_t reference = time(NULL);
	char 	smax[256];
	struct tm *stm;
	int width = 800, height = 400;
	int vectorize = 1;

	int x,y,d,i,flag=1;

	//x=(wid->geometry.w)/2;
	//y=(wid->geometry.h)/2;

	d=((wid->geometry.w>wid->geometry.h)?wid->geometry.h:wid->geometry.w)-4;

	stm=localtime(&reference);
	for(x=0;x!=cols;x++) {	
		for(y=0;y!=(vectorize?rows-1:rows);y++) {
			if(vectorize) 
				view_draw_line((view_t *)wid, 1, 1, y * (width - 16) / rows, height - 8 - (data[x][y] * (height - 16) / gmax), 8 + (y + 1) * (width - 16) / rows, 10);
				//view_draw_line((view_t *)wid, 1, 1, 8 + (int)(y * (width - 16) / rows), height-8-(int)(data[x][y]*(height-16)/gmax),
				//	8+(int)(y+1)*(width-16)/rows,height-8-(int)(data[x][y+1]*(height-16)/gmax));

		}
	}
	widget_set_update(wid);
	return (0);
}

int main(int argc, const char **argv)
{
	screen_t 	*screen;
	button_t 	*quit;
	window_t 	*win;

	FILE 	 	*fp;
	int 		x,y;
	fp=fopen(argv[1],"r");
	data  =(float **)malloc(cols*sizeof(float *));
	max   =(float *) malloc(cols*sizeof(float));
	gmax  =0.0;

	for(x=0;x!=cols;x++) { 
		max[x]=0.0;
		data[x]=(float *)malloc(rows*sizeof(float *));
	}
	for(y=0;y!=rows;y++) {
		for(x=0;x!=cols;x++) {
			fscanf(fp,"%f",&(data[x][y]));
			if(data[x][y]>max[x]) max[x]=data[x][y];
			if(data[x][y]>gmax)   gmax=data[x][y];
		}
	}
	fclose(fp);

	XSAppInit();

	screen 	= screen_create(0,0);
	win		= window_create(screen, 900, 400, 160, 160," clock example ", 0);
	window_set_bgcolor(win, XS_COLOR_BLACK);
	analog = view_create(win, 800, 80, (180/2) - 50, (60 - 80), "analog clock", 0);
	widget_set_event(analog, XS_EVENT_EXPOSE, &analog_draw);
	widget_set_event(analog, XS_EVENT_TICK, &analog_update);

	button_create(win, 58, 22, 180-58-5, 180-28, "quit", &on_button_quit);
	digital = label_create(win, 64, 25, 4, 180-28, "00:00:00", XS_LABEL_BIG);
	widget_set_fontSize(digital, 18);
	widget_set_textColor(digital, XS_COLOR_BLUE);
	widget_sizeToFit(digital);
	//widget_set_event(digital, XS_EVENT_TICK, &digital_update);

	XSAddTimer(XS_WAIT_MAINLOOP, 1.0, analog);
	//XSAddTimer(XS_WAIT_MAINLOOP, 1.0, digital);

	return (XSAppMain(screen, argc, argv));
}

