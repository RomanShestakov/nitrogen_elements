% Nitrogen Elements
% Copyright (c) 2013 Roman Shestakov (romanshestakov@yahoo.co.uk)
% See MIT-LICENSE for licensing information.

-module (element_jqgrid).
-include ("nitrogen_elements.hrl").
-include_lib("nitrogen_core/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, jqgrid).

render_element(#jqgrid{options = GridOptions} = Record) ->
    %% define IDs, jqGrid depends on html_ids
    ID = Record#jqgrid.id,
    TableHtmlID = "grid_html_id_" ++ wf:temp_id(),
    PagerID = "pager_html_id_" ++ wf:temp_id(),

    %% add extra options
    Record1 = Record#jqgrid{options = [{pager, list_to_binary(wf:f("#~s", [PagerID]))} | GridOptions]},

    %% init jqGrid control with specified options
    Options = common:options_to_js(Record1#jqgrid.options),

    %% create grid
    wf:wire(ID, wf:f("$(function(){$(obj('~s')).jqGrid(~s);})", [ID, Options])),

    %% output html markup
    #panel{body = [
	#table{html_id = TableHtmlID, id = ID, rows = [#tablerow{cells = []}]},
	#panel{html_id = PagerID}
    ]}.

event({?BEFORESELECTROW, Postback}) ->
    RowId = wf:q(rowid),
    Event = wf:q(event),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, Event}});
event({?ONSELECTROW, Postback}) ->
    RowId = wf:q(rowid),
    Status = wf:q(status),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, Status}});
event({?ONCELLSELECT, Postback}) ->
    RowId = wf:q(rowid),
    ICol = wf:q(iCol),
    Cellcontent = wf:q(cellcontent),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, ICol, Cellcontent}});
event({?AFTERINSERTROW, Postback}) ->
    RowId = wf:q(rowid),
    Rowdata = wf:q(rowdata),
    Rowelem = wf:q(rowelem),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, Rowdata, Rowelem}});
event({?BEFOREREQUEST, Postback}) ->
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {}});
event({?ONDBLCLICKROW, Postback}) ->
    RowId = wf:q(rowid),
    IRow = wf:q(iRow),
    ICol = wf:q(iCol),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, IRow, ICol}});
event({?ONRIGHTCLICKROW, Postback}) ->
    RowId = wf:q(rowid),
    IRow = wf:q(iRow),
    ICol = wf:q(iCol),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {RowId, IRow, ICol}});
event({?ONHEADERCLICK, Postback}) ->
    Gridstate = wf:q(gridstate),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {Gridstate}});
event({?ONLOADCOMPLETE, Postback}) ->
    Data = wf:q(data),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {Data}});
event({?ONPAGESIZECHANGE, Postback}) ->
    Page = wf:q(page),
    Total = wf:q(total),
    Records = wf:q(records),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {Page, Total, Records}});
event({?BEFOREPROCESSING, Postback}) ->
    Data = wf:q(data),
    Status = wf:q(status),
    Module = wf:page_module(),
    Module:jqgrid_event({Postback, {Data, Status}});
event(Event) ->
    ?PRINT({jqgrid_event, Event}),
    Module = wf:page_module(),
    Module:jqgrid_event({Event, {}}).
