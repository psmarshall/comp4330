--
-- Uwe R. Zimmer, Australia, 2013
--

with Ada.Text_IO;        use Ada.Text_IO;
with Queue_Pack_Generic;

procedure Queue_Test_Generic is

   package Queue_Pack_Character is
      new Queue_Pack_Generic (Element => Character, Queue_Size => 20);
   use Queue_Pack_Character;

   Queue : Queue_Type;
   Current_Item  : Character;

begin
   Enqueue (Item => 'x', Queue => Queue);
   Enqueue (Item => 'y', Queue => Queue);
   Enqueue (Item => 'z', Queue => Queue);

   Dequeue (Current_Item, Queue);
   Put_Line ("Current_Item: " & Current_Item);

   Put_Line ("Queue is " & (if Is_Empty (Queue) then "" else "not ") & "empty on exit");

exception
   when Queue_underflow => Put ("Queue underflow");
   when Queue_overflow  => Put ("Queue overflow");
end Queue_Test_Generic;
