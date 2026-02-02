From 01d98d7b50b7844126c2adf200d984d9bd2df2db Mon Sep 17 00:00:00 2001
From: pml68 <contact@pml68.dev>
Date: Thu, 18 Sep 2025 18:50:50 +0200
Subject: [PATCH] update 'alpha' patch for dwm commit 74edc27

---
 config.def.h |  2 ++
 config.mk    |  2 +-
 drw.c        | 25 +++++++++++-----------
 drw.h        |  9 +++++---
 dwm.c        | 60 ++++++++++++++++++++++++++++++++++++++++++++++------
 5 files changed, 76 insertions(+), 22 deletions(-)

diff --git a/config.def.h b/config.def.h
index 81c3fc0..1680db5 100644
--- a/config.def.h
+++ b/config.def.h
@@ -7,6 +7,8 @@ static const int showbar            = 1;        /* 0 means no bar */
 static const int topbar             = 1;        /* 0 means bottom bar */
 static const char *fonts[]          = { "monospace:size=10" };
 static const char dmenufont[]       = "monospace:size=10";
+static unsigned int baralpha        = 0xd0;
+static unsigned int borderalpha     = OPAQUE;
 static const char col_gray1[]       = "#222222";
 static const char col_gray2[]       = "#444444";
 static const char col_gray3[]       = "#bbbbbb";
diff --git a/config.mk b/config.mk
index b469a2b..31b21ef 100644
--- a/config.mk
+++ b/config.mk
@@ -23,7 +23,7 @@ FREETYPEINC = /usr/include/freetype2
 
 # includes and libs
 INCS = -I${X11INC} -I${FREETYPEINC}
-LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS}
+LIBS = -L${X11LIB} -lX11 ${XINERAMALIBS} ${FREETYPELIBS} -lXrender
 
 # flags
 CPPFLAGS = -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700L -DVERSION=\"${VERSION}\" ${XINERAMAFLAGS}
diff --git a/drw.c b/drw.c
index c41e6af..201d8be 100644
--- a/drw.c
+++ b/drw.c
@@ -47,7 +47,7 @@ utf8decode(const char *s_in, long *u, int *err)
 }
 
 Drw *
-drw_create(Display *dpy, int screen, Window root, unsigned int w, unsigned int h)
+drw_create(Display *dpy, int screen, Window root, unsigned int w, unsigned int h, Visual *visual, unsigned int depth, Colormap cmap)
 {
 	Drw *drw = ecalloc(1, sizeof(Drw));
 
@@ -56,8 +56,11 @@ drw_create(Display *dpy, int screen, Window root, unsigned int w, unsigned int h
 	drw->root = root;
 	drw->w = w;
 	drw->h = h;
-	drw->drawable = XCreatePixmap(dpy, root, w, h, DefaultDepth(dpy, screen));
-	drw->gc = XCreateGC(dpy, root, 0, NULL);
+	drw->visual = visual;
+	drw->depth = depth;
+	drw->cmap = cmap;
+	drw->drawable = XCreatePixmap(dpy, root, w, h, depth);
+	drw->gc = XCreateGC(dpy, drw->drawable, 0, NULL);
 	XSetLineAttributes(dpy, drw->gc, 1, LineSolid, CapButt, JoinMiter);
 
 	return drw;
@@ -73,7 +76,7 @@ drw_resize(Drw *drw, unsigned int w, unsigned int h)
 	drw->h = h;
 	if (drw->drawable)
 		XFreePixmap(drw->dpy, drw->drawable);
-	drw->drawable = XCreatePixmap(drw->dpy, drw->root, w, h, DefaultDepth(drw->dpy, drw->screen));
+	drw->drawable = XCreatePixmap(drw->dpy, drw->root, w, h, drw->depth);
 }
 
 void
@@ -167,21 +170,21 @@ drw_fontset_free(Fnt *font)
 }
 
 void
-drw_clr_create(Drw *drw, Clr *dest, const char *clrname)
+drw_clr_create(Drw *drw, Clr *dest, const char *clrname, unsigned int alpha)
 {
 	if (!drw || !dest || !clrname)
 		return;
 
-	if (!XftColorAllocName(drw->dpy, DefaultVisual(drw->dpy, drw->screen),
-	                       DefaultColormap(drw->dpy, drw->screen),
+	if (!XftColorAllocName(drw->dpy, drw->visual, drw->cmap,
 	                       clrname, dest))
 		die("error, cannot allocate color '%s'", clrname);
+	dest->pixel = (dest->pixel & 0x00ffffffU) | (alpha << 24);
 }
 
 /* Wrapper to create color schemes. The caller has to call free(3) on the
  * returned color scheme when done using it. */
 Clr *
-drw_scm_create(Drw *drw, const char *clrnames[], size_t clrcount)
+drw_scm_create(Drw *drw, const char *clrnames[], const unsigned int clralphas[], size_t clrcount)
 {
 	size_t i;
 	Clr *ret;
@@ -191,7 +194,7 @@ drw_scm_create(Drw *drw, const char *clrnames[], size_t clrcount)
 		return NULL;
 
 	for (i = 0; i < clrcount; i++)
-		drw_clr_create(drw, &ret[i], clrnames[i]);
+		drw_clr_create(drw, &ret[i], clrnames[i], clralphas[i]);
 	return ret;
 }
 
@@ -250,9 +253,7 @@ drw_text(Drw *drw, int x, int y, unsigned int w, unsigned int h, unsigned int lp
 		XFillRectangle(drw->dpy, drw->drawable, drw->gc, x, y, w, h);
 		if (w < lpad)
 			return x + w;
-		d = XftDrawCreate(drw->dpy, drw->drawable,
-		                  DefaultVisual(drw->dpy, drw->screen),
-		                  DefaultColormap(drw->dpy, drw->screen));
+		d = XftDrawCreate(drw->dpy, drw->drawable, drw->visual, drw->cmap);
 		x += lpad;
 		w -= lpad;
 	}
diff --git a/drw.h b/drw.h
index 6471431..670dfc3 100644
--- a/drw.h
+++ b/drw.h
@@ -20,6 +20,9 @@ typedef struct {
 	Display *dpy;
 	int screen;
 	Window root;
+	Visual *visual;
+	unsigned int depth;
+	Colormap cmap;
 	Drawable drawable;
 	GC gc;
 	Clr *scheme;
@@ -27,7 +30,7 @@ typedef struct {
 } Drw;
 
 /* Drawable abstraction */
-Drw *drw_create(Display *dpy, int screen, Window win, unsigned int w, unsigned int h);
+Drw *drw_create(Display *dpy, int screen, Window win, unsigned int w, unsigned int h, Visual *visual, unsigned int depth, Colormap cmap);
 void drw_resize(Drw *drw, unsigned int w, unsigned int h);
 void drw_free(Drw *drw);
 
@@ -39,8 +42,8 @@ unsigned int drw_fontset_getwidth_clamp(Drw *drw, const char *text, unsigned int
 void drw_font_getexts(Fnt *font, const char *text, unsigned int len, unsigned int *w, unsigned int *h);
 
 /* Colorscheme abstraction */
-void drw_clr_create(Drw *drw, Clr *dest, const char *clrname);
-Clr *drw_scm_create(Drw *drw, const char *clrnames[], size_t clrcount);
+void drw_clr_create(Drw *drw, Clr *dest, const char *clrname, unsigned int alpha);
+Clr *drw_scm_create(Drw *drw, const char *clrnames[], const unsigned int clralphas[], size_t clrcount);
 
 /* Cursor abstraction */
 Cur *drw_cur_create(Drw *drw, int shape);
diff --git a/dwm.c b/dwm.c
index 4cf07eb..01b784d 100644
--- a/dwm.c
+++ b/dwm.c
@@ -56,6 +56,8 @@
 #define TAGMASK                 ((1 << LENGTH(tags)) - 1)
 #define TEXTW(X)                (drw_fontset_getwidth(drw, (X)) + lrpad)
 
+#define OPAQUE                  0xffU
+
 /* enums */
 enum { CurNormal, CurResize, CurMove, CurLast }; /* cursor */
 enum { SchemeNorm, SchemeSel }; /* color schemes */
@@ -231,6 +233,7 @@ static Monitor *wintomon(Window w);
 static int xerror(Display *dpy, XErrorEvent *ee);
 static int xerrordummy(Display *dpy, XErrorEvent *ee);
 static int xerrorstart(Display *dpy, XErrorEvent *ee);
+static void xinitvisual(void);
 static void zoom(const Arg *arg);
 
 /* variables */
@@ -266,6 +269,10 @@ static Display *dpy;
 static Drw *drw;
 static Monitor *mons, *selmon;
 static Window root, wmcheckwin;
+static int useargb = 0;
+static Visual *visual;
+static int depth;
+static Colormap cmap;
 
 /* configuration, allows nested code to access above variables */
 #include "config.h"
@@ -1557,7 +1564,8 @@ setup(void)
 	sw = DisplayWidth(dpy, screen);
 	sh = DisplayHeight(dpy, screen);
 	root = RootWindow(dpy, screen);
-	drw = drw_create(dpy, screen, root, sw, sh);
+	xinitvisual();
+	drw = drw_create(dpy, screen, root, sw, sh, visual, depth, cmap);
 	if (!drw_fontset_create(drw, fonts, LENGTH(fonts)))
 		die("no fonts could be loaded.");
 	lrpad = drw->fonts->h;
@@ -1584,8 +1592,9 @@ setup(void)
 	cursor[CurMove] = drw_cur_create(drw, XC_fleur);
 	/* init appearance */
 	scheme = ecalloc(LENGTH(colors), sizeof(Clr *));
+	unsigned int alphas[] = {borderalpha, baralpha, OPAQUE};
 	for (i = 0; i < LENGTH(colors); i++)
-		scheme[i] = drw_scm_create(drw, colors[i], 3);
+		scheme[i] = drw_scm_create(drw, colors[i], alphas, 3);
 	/* init bars */
 	updatebars();
 	updatestatus();
@@ -1820,16 +1829,18 @@ updatebars(void)
 	Monitor *m;
 	XSetWindowAttributes wa = {
 		.override_redirect = True,
-		.background_pixmap = ParentRelative,
+		.background_pixel = 0,
+		.border_pixel = 0,
+		.colormap = cmap,
 		.event_mask = ButtonPressMask|ExposureMask
 	};
 	XClassHint ch = {"dwm", "dwm"};
 	for (m = mons; m; m = m->next) {
 		if (m->barwin)
 			continue;
-		m->barwin = XCreateWindow(dpy, root, m->wx, m->by, m->ww, bh, 0, DefaultDepth(dpy, screen),
-				CopyFromParent, DefaultVisual(dpy, screen),
-				CWOverrideRedirect|CWBackPixmap|CWEventMask, &wa);
+		m->barwin = XCreateWindow(dpy, root, m->wx, m->by, m->ww, bh, 0, depth,
+				InputOutput, visual,
+				CWOverrideRedirect|CWBackPixel|CWBorderPixel|CWColormap|CWEventMask, &wa);
 		XDefineCursor(dpy, m->barwin, cursor[CurNormal]->cursor);
 		XMapRaised(dpy, m->barwin);
 		XSetClassHint(dpy, m->barwin, &ch);
@@ -2127,6 +2138,43 @@ xerrorstart(Display *dpy, XErrorEvent *ee)
 	return -1;
 }
 
+void
+xinitvisual(void)
+{
+	XVisualInfo *infos;
+	XRenderPictFormat *fmt;
+	int nitems;
+	int i;
+
+	XVisualInfo tpl = {
+		.screen = screen,
+		.depth = 32,
+		.class = TrueColor
+	};
+	long masks = VisualScreenMask | VisualDepthMask | VisualClassMask;
+
+	infos = XGetVisualInfo(dpy, masks, &tpl, &nitems);
+	visual = NULL;
+	for(i = 0; i < nitems; i++) {
+		fmt = XRenderFindVisualFormat(dpy, infos[i].visual);
+		if (fmt->type == PictTypeDirect && fmt->direct.alphaMask) {
+			visual = infos[i].visual;
+			depth = infos[i].depth;
+			cmap = XCreateColormap(dpy, root, visual, AllocNone);
+			useargb = 1;
+			break;
+		}
+	}
+
+	XFree(infos);
+
+	if (!visual) {
+		visual = DefaultVisual(dpy, screen);
+		depth = DefaultDepth(dpy, screen);
+		cmap = DefaultColormap(dpy, screen);
+	}
+}
+
 void
 zoom(const Arg *arg)
 {
-- 
2.51.0

