-module(client).
-export([start/0, loop/1, connect/2, process_message/2]).

connect(Addr, Port) ->
	case inet:parse_address(Addr) of
		{error, X} ->
			io:format("Error ~p parsing address ~p~n", [X, Addr]);	
		{ok, Address} ->
		case gen_tcp:connect(Address, Port, [binary, {active,true}]) of
			{ok, Socket} ->
				{ok, Socket};
			{error, X} ->
				io:format("Error on connection to ~p on port ~p for reason ~p~n", [Addr, Port, X]),
				{error, X}
		end
	end.

loop(Socket) ->
	process_message(Socket, io:get_line("Chat>")),
	loop(Socket).

start() ->
	{Status, Conn} = connect("127.0.0.1", 8888),	
	case Status of
		ok -> 
				loop(Conn);
		error ->
			"Terminating program..."
	end.

process_message(Socket, Message) ->
	gen_tcp:send(Socket, Message),
	Message.

