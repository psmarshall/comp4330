--
-- Peter Marshall, Australia, 2015
--

with Ada.Text_IO;  use Ada.Text_IO;
with Stack_Simple; use Stack_Simple;

procedure Stack_Test_Simple is

   Stack : Stack_Type;
   Item  : Element;

begin
   Push (2000, Stack);

   Pop (Item, Stack); Put (Element'Image (Item));

   Put (Element'Image (Item));

   Put ("Stack is empty on exit: "); Put (Boolean'Image (Is_Empty (Stack)));

end Stack_Test_Simple;
