-module(server).
-export([listen_to_connections/1]).

listen_to_connections(Port) ->
	{ok, ListenSocket} = gen_tcp:listen(Port, [{active, false}, binary]),
	{ok, AcceptSocket} = gen_tcp:accept(ListenSocket),
	{ok, Bin} = gen_tcp:recv(AcceptSocket, 0),
    ok = gen_tcp:close(AcceptSocket),
    Bin.