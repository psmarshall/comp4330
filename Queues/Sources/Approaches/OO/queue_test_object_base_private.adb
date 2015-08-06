--
-- Uwe R. Zimmer, Australia, 2013
--

with Queue_Pack_Object_Base_Private; use Queue_Pack_Object_Base_Private;
with Ada.Text_IO;                    use Ada.Text_IO;

procedure Queue_Test_Object_Base_Private is

   Queue             : Queue_Type;
   Existing_item,
   Non_existing_item : Element;

begin
   Enqueue (Item => 1, Queue => Queue);

   Dequeue (Existing_item,     Queue);
   Put (Element'Image (Existing_item));

   Dequeue (Non_existing_item, Queue); -- will produce a 'Queue underflow'
   Put (Element'Image (Non_existing_item));

   if Is_Empty (Queue) then
      Put ("Queue is empty on exit");
   else
      Put ("Queue is not empty on exit");
   end if;

exception
   when Queueunderflow => Put ("Queue underflow");
   when Queueoverflow  => Put ("Queue overflow");
end Queue_Test_Object_Base_Private;
