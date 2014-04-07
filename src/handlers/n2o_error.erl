-module(n2o_error).
-include_lib("n2o/include/wf.hrl").
-export(?FAULTER_API).

% Plain Text Error Page Render
% Here is sample
%
% ERROR:  error:badarith
%
% STACK:  index:body/0:18
%         index:main/0:8
%         wf_core:run/1:15

error_page(Class,Error) ->
    io_lib:format("ERROR:  ~w:~w~n~n",[Class,Error]) ++
    "STACK: " ++ 
    [ wf:render([io_lib:format("\t~w:~w/~w:~w",
        [ Module,Function,Arity,proplists:get_value(line, Location) ]),"\n"])
    ||  { Module,Function,Arity,Location} <- erlang:get_stacktrace() ].