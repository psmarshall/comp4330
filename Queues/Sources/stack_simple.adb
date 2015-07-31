--
-- Peter Marshall, Australia, 2015
--

package body Stack_Simple is

   procedure Push (Item :     Element; Stack : in out Stack_Type) is

   begin
      Stack.Elements (Stack.Free) := Item;
      Stack.Free := Stack.Free + 1;
      Stack.Is_Empty := False;
   end Push;

   procedure Pop  (Item : out Element; Stack : in out Stack_Type) is

   begin
      Item := Stack.Elements (Stack.Free - 1);
      Stack.Free := Stack.Free - 1;
   end Pop;

end Stack_Simple;
