-module(server).
-export([listen_to_connections/1, recv_loop/1]).

listen_to_connections(Port) ->
	{ok, ListenSocket} = gen_tcp:listen(Port, [{active, false}, binary]),
	{ok, AcceptSocket} = gen_tcp:accept(ListenSocket),
	recv_loop(AcceptSocket),
    ok = gen_tcp:close(AcceptSocket).

recv_loop(Socket) ->
    {ok, Data} = gen_tcp:recv(Socket, 0),
    io:format("Message: ~p~n",[Data]),
    recv_loop(Socket).