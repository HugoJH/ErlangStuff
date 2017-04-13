-module(client).
-export([connect/2]).

connect(Addr, Port) ->
	{ok, Address} = inet:parse_address(Addr),
	{ok, Socket} = gen_tcp:connect(Address, Port, [binary, {active,true}]),
	gen_tcp:send(Socket, "Hey there first shell!").