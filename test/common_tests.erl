-module(common_tests).
-compile([export_all]).
-include_lib("eunit/include/eunit.hrl").

options_to_js_test_() ->
    [
     ?_assertEqual("{ selected: 0 }", common:options_to_js([{selected, 0}])),
     ?_assertEqual("{ url: 'get_jqgrid_data',datatype: 'json',colNames: [ 'ID','Name','Values' ],colModel: [ {name: 'id', index: 'id', width: 55},{name: 'name', index: 'name1', width: 80},{name: 'values1', index: 'values1', width: 100} ] }",
		   common:options_to_js(
					[
					 {url, 'get_jqgrid_data'},
					 {datatype, <<"json">>},
					 {colNames, ['ID', 'Name', 'Values']},
					 {colModel, [
						     [{name, 'id'}, {index, 'id'}, {width, 55}],
						     [{name, 'name'}, {index, 'name1'}, {width, 80}],
						     [{name, 'values1'}, {index, 'values1'}, {width, 100}]
						    ]}
					])),
     ?_assertEqual("{ paneSelector: '.ID',size: 200,spacing_open: 0,spacing_closed: 0 }",
		   common:options_to_js([{paneSelector, list_to_binary("." ++ "ID")}] ++
					    [{size, 200}, {spacing_open, 0}, {spacing_closed, 0}])),
     ?_assertEqual("{ icons: { submenu: 'ui-icon-circle-triangle-e' } }",
		   common:options_to_js([{icons, {{submenu, <<"ui-icon-circle-triangle-e">>}}}])),
     ?_assertEqual("{ icons: { submenu: 'ui-icon-circle-triangle-e',submenu1: 'ui-icon-circle-triangle-r' } }",
		   common:options_to_js([{icons, {{submenu, <<"ui-icon-circle-triangle-e">>}, {submenu1, <<"ui-icon-circle-triangle-r">>}}}])),
     ?_assertEqual("{ group: { grouping: true,group2: { grouping2: false,grouping3: true } } }",
     		   common:options_to_js([{group, {{grouping, 'true'}, {group2, {{grouping2, 'false'}, {grouping3, 'true'}}}}}])),
     ?_assertEqual("{ group: { grouping: true,groupingView: { groupField: [ 'name' ],groupColumn: [ false ] } } }",
     		   common:options_to_js([{group, {{grouping, true}, {groupingView, {{groupField, ['name']}, {groupColumn, [false]}}}}}])),
     ?_assertEqual("{ position: { my: 'left top',at: 'right-5 top+5' } }",
		   common:options_to_js([{position, {{my, <<"left top">>}, {at, <<"right-5 top+5">>}}}]))
    ].
