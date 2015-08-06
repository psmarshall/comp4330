--
-- Uwe R. Zimmer, Australia, 2013
--

with Queue_Pack_Object_Base; use Queue_Pack_Object_Base;
with Queue_Pack_Object;      use Queue_Pack_Object;
with Ada.Text_IO;            use Ada.Text_IO;

procedure Queue_Test_Object is

   Queue             : Ext_Queue_Type;
   First_item,
   Second_item,
   Non_existing_item : Element;

begin
   Enqueue (Item => 1, Queue => Queue);

   Read_Queue (First_item, Queue);
   Put (Element'Image (First_item));

   Enqueue (Item => 5, Queue => Queue);

   Dequeue (First_item,        Queue);
   Put (Element'Image (First_item));

   Dequeue (Second_item,       Queue);
   Put (Element'Image (Second_item));

   Dequeue (Non_existing_item, Queue); -- will produce a 'Queue underflow'
   Put (Element'Image (Non_existing_item));

   if Is_Empty (Queue) then
      Put ("Queue is empty on exit");
   else
      Put ("Queue is not empty on exit");
   end if;

exception
   when Queue_underflow => Put ("Queue underflow");
   when Queue_overflow  => Put ("Queue overflow");
end Queue_Test_Object;
