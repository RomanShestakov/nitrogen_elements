%%%-------------------------------------------------------------------
%%% Copyright 2009 Ceti Forge
%%%
%%% Licensed under the Apache License, Version 2.0 (the "License");
%%% you may not use this file except in compliance with the License.
%%% You may obtain a copy of the License at
%%%
%%% http://www.apache.org/licenses/LICENSE-2.0
%%%
%%% Unless required by applicable law or agreed to in writing,
%%% software distributed under the License is distributed on an "AS
%%% IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
%%% express or implied.  See the License for the specific language
%%% governing permissions and limitations under the License.
%%%
%%%-------------------------------------------------------------------
%%% File    : element_dialog.erl
%%% Author  : Tom McNulty <tom.mcnulty@cetiforge.com>
%%%
%%% Description : JQuery UI Dialog
%%%
%%%-------------------------------------------------------------------
-module(element_dialog).
-export([render_element/1, event/1]).
-include ("nitrogen_elements.hrl").

render_element(Record) ->
    Id = wf:temp_id(),

    %% Buttons are ordered in the order they appear.
    Buttons = create_buttons(Record#dialog.buttons, Id, []),
    %% add Cancel button
    Buttons1 =
    case Record#dialog.show_cancel of
	true -> ["\"Cancel\": function(){$(this).dialog('destroy').remove();}" | Buttons];
	false -> Buttons
    end,
    Buttons2 = string:join(Buttons1, ", "),

    %% generate jQuery funtion which will create dialog
    wf:wire(Id, wf:f("jQuery(obj('~s')).dialog({"
	"modal: true, "
	"closeOnEscape: true, "
	"show: 'scale', hide: 'scale', "
	"resizable: false, "
	"width: ~p, height: ~p, "
	"buttons: {~s}});", [Id, Record#dialog.width, Record#dialog.height, Buttons2])),

    %% render html
    #panel{
	id = Id,
	%% currently #panel element doesn't have 'title' attribute
	%%title = Record#dialog.title,
	body = Record#dialog.body
    }.

create_buttons([], _Id, Buttons) -> Buttons;
create_buttons([{Title, Postback} | Rest], Id, Buttons) ->
    PickledPostbackInfo = wf_event:serialize_event_context({Id, Postback}, Id, Id, false, ?MODULE),
    Button = wf:f("\"~s\": function() {Nitrogen.$queue_event('~s','~s')}", [Title, Id, PickledPostbackInfo]),
    create_buttons(Rest, Id, [Button | Buttons]).

event({Id, Event}) ->
    Module = wf:page_module(),
    %% now dismiss dialog and send event to the page
    wf:wire(wf:f("jQuery(obj('~s')).dialog('destroy').remove();", [Id])),
    Module:event(Event).
