--
-- Uwe R. Zimmer, Australia, 2013
--

with Queue_Pack_Object_Base_Private; use Queue_Pack_Object_Base_Private;
with Queue_Pack_Object_Private;      use Queue_Pack_Object_Private;
with Ada.Text_IO;                    use Ada.Text_IO;

procedure Queue_Test_Object_Private is

   Queue             : Ext_Queue_Type;
   Item_inside_queue,
   First_item,
   Second_item,
   Third_item,
   Non_existing_item : Element;

begin
   Enqueue (Item => 1, Queue => Queue);
   Enqueue (Item => 3, Queue => Queue);

   Look_Ahead (Item => Item_inside_queue, Depth => 2, Queue => Queue);
   Put (Element'Image (Item_inside_queue));

   Enqueue (Item => 5, Queue => Queue);

   Dequeue (First_item,  Queue);
   Put (Element'Image (First_item));

   Dequeue (Second_item, Queue);
   Put (Element'Image (Second_item));

   Dequeue (Third_item,  Queue);
   Put (Element'Image (Third_item));

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
end Queue_Test_Object_Private;
