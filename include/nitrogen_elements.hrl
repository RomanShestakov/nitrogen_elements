-ifndef(NITROGEN_ELEMENTS_HRL).
-define(NITROGEN_ELEMENTS_HRL, ok).

%% NOTE: set the include path bellow to your nitrogen installation location
-include_lib("nitrogen_core/include/wf.inc").

%% Dialog
-record(dialog, {?ELEMENT_BASE(element_dialog), body="", width="auto", height="auto", show_cancel=false, buttons=[]}).

%% progress bar
-record(progressbar, {?ELEMENT_BASE(element_progressbar), options=[]}).
-record(progressbar_value, {?ACTION_BASE(action_progressbar), value}).
-record(progressbar_disable, {?ACTION_BASE(action_progressbar)}).
-record(progressbar_enable, {?ACTION_BASE(action_progressbar)}).
-record(progressbar_event_on, {?ACTION_BASE(action_progressbar), event, postback}).
-record(progressbar_event_off, {?ACTION_BASE(action_progressbar), event}).

%% accordion
-define(EVENT_ACCORDION_ACTIVATE, 'accordionactivate').
-define(EVENT_ACCORDION_BEFORE_ACTIVATE, 'accordionbeforeactivate').
-define(EVENT_ACCORDION_CREATE, 'accordioncreate').
-record(accordion, {?ELEMENT_BASE(element_accordion), body=[], options=[]}).
-record(accordion_destroy, {?ACTION_BASE(action_accordion)}).
-record(accordion_disable, {?ACTION_BASE(action_accordion)}).
-record(accordion_enable, {?ACTION_BASE(action_accordion)}).
-record(accordion_event_on, {?ACTION_BASE(action_accordion), type, postback, extra_param=""}).
-record(accordion_event_off, {?ACTION_BASE(action_accordion), type}).

%% tabs
-define(EVENT_TABS_ACTIVATE, 'tabsactivate').
-define(EVENT_TABS_BEFORE_ACTIVATE, 'tabsbeforeactivate').
-define(EVENT_TABS_BEFORE_LOAD, 'tabsbeforeload').
-define(EVENT_TABS_CREATE, 'tabscreate').
-define(EVENT_TABS_LOAD, 'tabsload').
-record(tabs, {?ELEMENT_BASE(element_tabs), tabs=[], options=[], tag}).
-record(tab, {id=wf:temp_id(), title="No Title", class="", style="", body=[], closable=true, tag, url}).
-record(tab_destroy, {?ACTION_BASE(action_tabs)}).
-record(tab_disable, {?ACTION_BASE(action_tabs), tab}).
-record(tab_enable, {?ACTION_BASE(action_tabs), tab}).
-record(tab_option, {?ACTION_BASE(action_tabs), postback, key, value}).
-record(tab_add, {?ACTION_BASE(action_tabs), url, title}).
-record(tab_remove, {?ACTION_BASE(action_tabs), tab}).
-record(tab_select, {?ACTION_BASE(action_tabs), tab}).
-record(tab_event_on, {?ACTION_BASE(action_tabs), type, postback, extra_param=""}).
-record(tab_event_off, {?ACTION_BASE(action_tabs), type}).
-record(tab_cache, {?ACTION_BASE(action_tabs)}).


%% jqgrid
-define(BEFORESELECTROW, "jqGridBeforeSelectRow").
-define(ONSELECTROW, "jqGridSelectRow").
-define(ONCELLSELECT, "jqGridCellSelect").
-define(AFTERINSERTROW, "afterInsertRow").
-define(BEFOREPROCESSING, "beforeProcessing").
-define(BEFOREREQUEST, "jqGridBeforeRequest").
-define(ONDBLCLICKROW, "jqGridDblClickRow").
-define(ONHEADERCLICK, "qGridHeaderClick").
-define(ONRIGHTCLICKROW, "jqGridRightClickRow").
-define(ONLOADCOMPLETE, "jqGridLoadComplete").
%% not standard event to figure out the size of the page
-define(ONPAGESIZECHANGE, "onpagesizechange").
-record(jqgrid, {?ELEMENT_BASE(element_jqgrid), options=[]}).
-record(jqgrid_event, {?ACTION_BASE(action_jqgrid), event_name, type, postback}).

%% menu
-define(EVENT_MENU_BLUR, 'menublur').
-define(EVENT_MENU_CREATE, 'menucreate').
-define(EVENT_MENU_FOCUS, 'menufocus').
-define(EVENT_MENU_SELECT, 'menuselect').
-record(menu, {?ELEMENT_BASE(element_menu), options=[], body=[]}).
-record(item, {id=wf:temp_id(), title="No Title", url="#", class="", style="", body=[], postback}).
-record(menu_blur, {?ACTION_BASE(action_menu)}).
-record(menu_option, {?ACTION_BASE(action_menu), postback, key, value}).
-record(menu_event_on, {?ACTION_BASE(action_menu), type, postback}).
-record(menu_event_off, {?ACTION_BASE(action_menu), type}).

%% menubar
%% -define(EVENT_MENU_CREATE, 'menucreate').
%% -define(EVENT_MENU_FOCUS, 'menufocus').
%% -define(EVENT_MENU_SELECT, 'menuselect').
-record(menubar, {?ELEMENT_BASE(element_menubar), options=[], body=[]}).
-record(menubar_event_on, {?ACTION_BASE(action_menubar), type, postback}).
-record(menubar_event_off, {?ACTION_BASE(action_menubar), type}).

%% layout
-record (layout, {?ELEMENT_BASE(element_layout), north, south, east, west, center,
		  north_options=[], south_options=[], east_options=[], west_options=[], center_options=[]}).

%% viz.js
-record(viz, {?ELEMENT_BASE(element_viz), data}).

%% ajax load action
-record(ajax_load, {?ACTION_BASE(action_ajax_load), url = ""}).

%% websocket api
-record(ws_open, {?ACTION_BASE(action_ws_api), server = "", func = ""}).
-record(ws_message, {?ACTION_BASE(action_ws_api), func = ""}).
-record(ws_error, {?ACTION_BASE(action_ws_api), func = ""}).
-record(ws_close, {?ACTION_BASE(action_ws_api), func = ""}).
-record(ws_send, {?ACTION_BASE(action_ws_api), func = ""}).

-endif.
