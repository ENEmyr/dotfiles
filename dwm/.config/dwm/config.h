/* See LICENSE file for copyright and license details. */

/* appearance */
static const unsigned int borderpx = 3; /* border pixel of windows */
static const unsigned int default_border =
    0; // to switch back to default border after dynamic border resizing via
       // keybinds
static const unsigned int snap = 32;   /* snap pixel */
static const unsigned int gappih = 10; /* horiz inner gap between windows */
static const unsigned int gappiv = 10; /* vert inner gap between windows */
static const unsigned int gappoh =
    10; /* horiz outer gap between windows and screen edge */
static const unsigned int gappov =
    10; /* vert outer gap between windows and screen edge */
static int smartgaps =
    0; /* 1 means no outer gap when there is only one window */
static const unsigned int systraypinning =
    0; /* 0: sloppy systray follows selected monitor, >0: pin systray to monitor
          X */
static const unsigned int systrayspacing = 2; /* systray spacing */
static const int systraypinningfailfirst =
    1; /* 1: if pinning fails,display systray on the 1st monitor,False: display
          systray on last monitor*/
static const int showsystray = 1; /* 0 means no systray */
static const int showbar = 1;     /* 0 means no bar */
enum showtab_modes {
  showtab_never,
  showtab_auto,
  showtab_nmodes,
  showtab_always
};
static const int showtab = showtab_nmodes;
static const int toptab = True;
static const int topbar = 1; /* 0 means bottom bar */
static const int horizpadbar = 5;
static const int vertpadbar = 11;
static const int vertpadtab = 33;
static const int horizpadtabi = 15;
static const int horizpadtabo = 15;
static const int scalepreview = 4;
static int tag_preview = 1; /* 1 means enable, 0 is off */

static const char *fonts[] = {
    "CascadiaCode NF:style:medium:size=11",
    "Source Code Pro:style:medium:size=10",
    "Iosevka Nerd Font:size=12",
};
static const char dmenufont[] = "CascadiaCode NF:size=10";
static const int colorfultag =
    1; /* 0 means use SchemeSel for selected non vacant tag */

// theme
#include "themes/onedark.h"

static const char *colors[][3] = {
    /*               fg         bg         border   */
    [SchemeNorm] = {white, black, gray2},
    [SchemeSel] = {gray4, blue, blue},
    [TabSel] = {blue, gray2, black},
    [TabNorm] = {gray3, black, black},
    [SchemeTag] = {gray3, black, black},
    [SchemeTag1] = {blue, black, black},
    [SchemeTag2] = {green, black, black},
    [SchemeTag3] = {red, black, black},
    [SchemeTag4] = {orange, black, black},
    [SchemeTag5] = {yellow, black, black},
    [SchemeTag6] = {pink, black, black},
    [SchemeTag7] = {white, black, black},
    [SchemeLayout] = {green, black, black},
    [SchemeBtnPrev] = {green, black, black},
    [SchemeBtnNext] = {yellow, black, black},
    [SchemeBtnClose] = {red, black, black},
};

/* tagging */
// static char *tags[] = {"", "", "", "", "", "", "漣"};
/* static const char *tags[] = { "", "", "", "", "", "", "", "", "" };
 */
/* static const char *tags[] = { "I", "II", "III", "IV", "V", "VI", "VII",
 * "VIII", "IX" }; */
static const char *tags[] = {"I", "II", "III", "IV", "V", "VI", "VII"};

static const int tagschemes[] = {SchemeTag1, SchemeTag2, SchemeTag3, SchemeTag4,
                                 SchemeTag5, SchemeTag6, SchemeTag7};

static const unsigned int ulinepad =
    5; /* horizontal padding between the underline and tag */
static const unsigned int ulinestroke =
    2; /* thickness / height of the underline */
static const unsigned int ulinevoffset =
    0; /* how far above the bottom of the bar the line should appear */
static const int ulineall =
    0; /* 1 to show underline on all tags, 0 for just the active ones */

static const Rule rules[] = {
    /* xprop(1):
     *	WM_CLASS(STRING) = instance, class
     *	WM_NAME(STRING) = title
     */
    /* class      instance    title       tags mask     iscentered   isfloating
       monitor */
    {"discord", NULL, NULL, 2, 0, 0, 1},
    {"Spotify", NULL, NULL, 1 << 5, 0, 0, 1},
};

/* layout(s) */
static const float mfact = 0.62; /* factor of master area size [0.05..0.95] */
static const int nmaster = 1;    /* number of clients in master area */
static const int resizehints =
    0; /* 1 means respect size hints in tiled resizals */
static const int attachbelow =
    1; /* 1 means attach after the currently active window */
static const int lockfullscreen =
    1; /* 1 will force focus on the fullscreen window */

#define FORCE_VSPLIT                                                           \
  1 /* nrowgrid layout: force two clients to always split vertically */
#include "functions.h"

static const Layout layouts[] = {
    /* symbol     arrange function */
    {"[@]", spiral}, /* first entry is default */
    {"[\\]", dwindle},
    {"[]=", tile},
    {"[M]", monocle},
    {"H[]", deck},
    {"TTT", bstack},
    {"===", bstackhoriz},
    {"HHH", grid},
    {"###", nrowgrid},
    {"---", horizgrid},
    {":::", gaplessgrid},
    {"|M|", centeredmaster},
    {">M>", centeredfloatingmaster},
    {"|+|", tatami},
    {"><>", NULL}, /* no layout function means floating behavior */
};

/* key definitions */
#define ALTKEY Mod1Mask
#define MODKEY Mod4Mask
#define TAGKEYS(KEY, TAG)                                                      \
  {MODKEY, KEY, view, {.ui = 1 << TAG}},                                       \
      {MODKEY | ControlMask, KEY, toggleview, {.ui = 1 << TAG}},               \
      {MODKEY | ShiftMask, KEY, tag, {.ui = 1 << TAG}},                        \
      {MODKEY | ControlMask | ShiftMask, KEY, toggletag, {.ui = 1 << TAG}},

/* helper for spawning shell commands in the pre dwm-5.0 fashion */
#define SHCMD(cmd)                                                             \
  {                                                                            \
    .v = (const char *[]) { "/bin/sh", "-c", cmd, NULL }                       \
  }

/* commands */
static const char *dmenucmd[] = {"dmenu_run", "-m",  "-1",  "-fn", dmenufont,
                                 "-x",        "290", "-y",  "19",  "-z",
                                 "900",       "-nb", black, "-nf", white,
                                 "-sb",       cyan,  "-sf", green, NULL};

#include "selfrestart.c"

static Key keys[] = {
    /* modifier                     key        function        argument */

    {MODKEY, XK_d, spawn, {.v = dmenucmd}},
    {MODKEY, XK_b, togglebar, {0}},
    {MODKEY | ControlMask, XK_w, tabmode, {-1}},
    {MODKEY, XK_j, focusstack, {.i = +1}},
    {MODKEY, XK_k, focusstack, {.i = -1}},
    {MODKEY, XK_i, incnmaster, {.i = +1}},
    {MODKEY, XK_u, incnmaster, {.i = -1}},
    {MODKEY, XK_h, setmfact, {.f = -0.05}},
    {MODKEY, XK_l, setmfact, {.f = +0.05}},
    {MODKEY | ShiftMask, XK_h, setcfact, {.f = +0.25}},
    {MODKEY | ShiftMask, XK_l, setcfact, {.f = -0.25}},
    {MODKEY | ShiftMask, XK_o, setcfact, {.f = 0.00}},
    {MODKEY | ShiftMask, XK_j, movestack, {.i = +1}},
    {MODKEY | ShiftMask, XK_k, movestack, {.i = -1}},
    {MODKEY, XK_Tab, view, {0}},

    // overall gaps
    {MODKEY | ControlMask, XK_i, incrgaps, {.i = +1}},
    {MODKEY | ControlMask, XK_u, incrgaps, {.i = -1}},

    // inner gaps
    {MODKEY | ShiftMask, XK_i, incrigaps, {.i = +1}},
    {MODKEY | ControlMask | ShiftMask, XK_i, incrigaps, {.i = -1}},

    // outer gaps
    {MODKEY | ControlMask, XK_o, incrogaps, {.i = +1}},
    {MODKEY | ControlMask | ShiftMask, XK_o, incrogaps, {.i = -1}},

    {MODKEY | ControlMask, XK_6, incrihgaps, {.i = +1}},
    {MODKEY | ControlMask | ShiftMask, XK_6, incrihgaps, {.i = -1}},
    {MODKEY | ControlMask, XK_7, incrivgaps, {.i = +1}},
    {MODKEY | ControlMask | ShiftMask, XK_7, incrivgaps, {.i = -1}},
    {MODKEY | ControlMask, XK_8, incrohgaps, {.i = +1}},
    {MODKEY | ControlMask | ShiftMask, XK_8, incrohgaps, {.i = -1}},
    {MODKEY | ControlMask, XK_9, incrovgaps, {.i = +1}},
    {MODKEY | ControlMask | ShiftMask, XK_9, incrovgaps, {.i = -1}},

    {MODKEY | ControlMask, XK_t, togglegaps, {0}},
    {MODKEY | ControlMask | ShiftMask, XK_d, defaultgaps, {0}},

    {MODKEY, XK_q, killclient, {0}},
    {MODKEY, XK_t, setlayout, {.v = &layouts[0]}},
    {ALTKEY | ShiftMask, XK_f, setlayout, {.v = &layouts[1]}},
    {ALTKEY, XK_m, setlayout, {.v = &layouts[2]}},
    {ALTKEY | ControlMask, XK_g, setlayout, {.v = &layouts[10]}},
    {ALTKEY | ControlMask | ShiftMask, XK_t, setlayout, {.v = &layouts[13]}},
    {ALTKEY, XK_space, setlayout, {0}},
    {MODKEY | ControlMask, XK_comma, cyclelayout, {.i = -1}},
    {MODKEY | ControlMask, XK_period, cyclelayout, {.i = +1}},
    {MODKEY, XK_space, cyclelayout, {.i = +1}},
    {MODKEY | ShiftMask, XK_space, togglefloating, {0}},
    {MODKEY, XK_f, togglefullscr, {0}},
    {MODKEY, XK_0, view, {.ui = ~0}},
    {MODKEY | ShiftMask, XK_0, tag, {.ui = ~0}},
    // {MODKEY, XK_comma, focusmon, {.i = -1}},
    // {MODKEY, XK_period, focusmon, {.i = +1}},
    // {MODKEY | ShiftMask, XK_comma, tagmon, {.i = -1}},
    // {MODKEY | ShiftMask, XK_period, tagmon, {.i = +1}},
    {MODKEY, XK_bracketleft, focusmon, {.i = -1}},
    {MODKEY, XK_bracketright, focusmon, {.i = +1}},
    {MODKEY | ShiftMask, XK_bracketleft, tagmon, {.i = -1}},
    {MODKEY | ShiftMask, XK_bracketright, tagmon, {.i = +1}},
    {ControlMask | ShiftMask, XK_minus, setborderpx, {.i = -1}},
    {ControlMask | ShiftMask, XK_p, setborderpx, {.i = +1}},
    {ControlMask | ShiftMask, XK_w, setborderpx, {.i = default_border}},
    TAGKEYS(XK_1, 0) TAGKEYS(XK_2, 1) TAGKEYS(XK_3, 2) TAGKEYS(XK_4, 3)
        TAGKEYS(XK_5, 4) TAGKEYS(XK_6, 5)
            TAGKEYS(XK_7, 6){ControlMask | ShiftMask, XK_q, quit, {0}},

    {MODKEY | ShiftMask, XK_q, self_restart, {0}},
    {ControlMask | ShiftMask, XK_r, quit, {1}},
    {MODKEY, XK_e, hidewin, {0}},
    {MODKEY | ShiftMask, XK_e, restorewin, {0}},

};

/* button definitions */
/* click can be ClkTagBar, ClkLtSymbol, ClkStatusText, ClkWinTitle,
 * ClkClientWin, or ClkRootWin */
static Button buttons[] = {
    /* click                event mask      button          function argument */
    {ClkLtSymbol, 0, Button1, setlayout, {0}},
    {ClkLtSymbol, 0, Button3, setlayout, {.v = &layouts[2]}},
    {ClkWinTitle, 0, Button2, zoom, {0}},

    /* Keep movemouse? */
    /* { ClkClientWin,         MODKEY,         Button1,        movemouse, {0} },
     */

    /* placemouse options, choose which feels more natural:
     *    0 - tiled position is relative to mouse cursor
     *    1 - tiled postiion is relative to window center
     *    2 - mouse pointer warps to window center
     *
     * The moveorplace uses movemouse or placemouse depending on the floating
     * state of the selected client. Set up individual keybindings for the two
     * if you want to control these separately (i.e. to retain the feature to
     * move a tiled window into a floating position).
     */
    {ClkClientWin, MODKEY, Button1, moveorplace, {.i = 0}},
    {ClkClientWin, MODKEY, Button2, togglefloating, {0}},
    {ClkClientWin, MODKEY, Button3, resizemouse, {0}},
    {ClkClientWin, ControlMask, Button1, dragmfact, {0}},
    {ClkClientWin, ControlMask, Button3, dragcfact, {0}},
    {ClkTagBar, 0, Button1, view, {0}},
    {ClkTagBar, 0, Button3, toggleview, {0}},
    {ClkTagBar, MODKEY, Button1, tag, {0}},
    {ClkTagBar, MODKEY, Button3, toggletag, {0}},
    {ClkTabBar, 0, Button1, focuswin, {0}},
    {ClkTabBar, 0, Button1, focuswin, {0}},
    {ClkTabPrev, 0, Button1, movestack, {.i = -1}},
    {ClkTabNext, 0, Button1, movestack, {.i = +1}},
    {ClkTabClose, 0, Button1, killclient, {0}},
};
