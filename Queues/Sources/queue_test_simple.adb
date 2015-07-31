--
-- Uwe R. Zimmer, Australia, 2013
--

with Ada.Text_IO;       use Ada.Text_IO;
with Queue_Pack_Simple; use Queue_Pack_Simple;

procedure Queue_Test_Simple is

   Queue : Queue_Type;
   Item  : Element;

begin
   Enqueue (2000, Queue);

   Dequeue (Item, Queue); Put (Element'Image (Item));

   -- Dequeue (Item, Queue); -- will raise an 'invalid data' exception!
   Put (Element'Image (Item));

   Put ("Queue is empty on exit: "); Put (Boolean'Image (Is_Empty (Queue)));

end Queue_Test_Simple;
