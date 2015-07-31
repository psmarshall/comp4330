--
-- Uwe R. Zimmer, Australia, 2013
--

with Ada.Text_IO;           use Ada.Text_IO;
with Queue_Pack_Exceptions; use Queue_Pack_Exceptions;

procedure Queue_Test_Exceptions is

   Queue : Queue_Type;
   Item  : Element;

begin
   Enqueue (Turn, Queue);

   Dequeue (Item, Queue); Put (Element'Image (Item));

   Dequeue (Item, Queue); -- will produce a 'Queue underflow'
   Put (Element'Image (Item));

   Put ("Queue is empty on exit: "); Put (Boolean'Image (Is_Empty (Queue)));

exception
   when Queue_underflow => Put ("Queue underflow");
   when Queue_overflow  => Put ("Queue overflow");

end Queue_Test_Exceptions;
