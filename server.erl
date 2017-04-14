-module(server).
-export([listen_to_connections/1, recv_loop/1]).

listen_to_connections(Port) ->
	{ok, ListenSocket} = gen_tcp:listen(Port, [{active, false}, binary]),
	{ok, AcceptSocket} = gen_tcp:accept(ListenSocket),
	recv_loop(AcceptSocket),
    ok = gen_tcp:close(AcceptSocket).

recv_loop(Socket) ->
    Answer = gen_tcp:recv(Socket, 0),
    case Answer of
        {ok, Data} ->
            io:format("Message: ~p~n",[Data]),
            recv_loop(Socket);
        {error, Reason} ->
            io:format("Error in connection: ~p~n",[Reason])
    end.