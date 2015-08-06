--
-- Uwe R. Zimmer, Australia, 2013
--

with Ada.Text_IO;         use Ada.Text_IO;
with Exceptions;          use Exceptions;
with Queue_Pack_Contract; use Queue_Pack_Contract;
with System.Assertions;   use System.Assertions;

procedure Queue_Test_Contract is

   Queue : Queue_Type;
   Item  : Element;

begin
   Enqueue (Item => 1, Q => Queue);
   Enqueue (Item => 2, Q => Queue);
   Enqueue (Item => 3, Q => Queue);

   Dequeue (Item, Queue); Put (Element'Image (Item));
   Dequeue (Item, Queue); Put (Element'Image (Item));
   Dequeue (Item, Queue); Put (Element'Image (Item));

   Dequeue (Item, Queue); -- will produce an Assert_Failure
   Put (Element'Image (Item));

   Put ("Queue is empty on exit: "); Put (Boolean'Image (Is_Empty (Queue)));

exception
   when Exception_Id : Assert_Failure => Show_Exception (Exception_Id);
end Queue_Test_Contract;
