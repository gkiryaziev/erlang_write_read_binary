-module(main).

-export([write_data/0, read_data/0]).

write_data() ->
  Term = [{name, "John"}, {sname, "Doe"}, {age, 32}],
  Bin = term_to_binary(Term),
  {ok, Out} = file:open('D:\\test.dat', [raw, write, binary]),
  file:pwrite(Out, 0, integer_to_binary(20)),
  file:pwrite(Out, 4, integer_to_binary(size(Bin))),
  file:pwrite(Out, 20, Bin),
  file:close(Out).

read_data() ->
  {ok, In} = file:open('D:\\test.dat', [raw, read, binary]),
  {ok, Start} = file:pread(In, 0, 2),
  {ok, Size} = file:pread(In, 4, 2),
  {ok, File} = file:pread(In, binary_to_integer(Start), binary_to_integer(Size)),
  Result = binary_to_term(File),
  file:close(In),
  io:format("~p ~n", [Result]).