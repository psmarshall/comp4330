--
-- Uwe R. Zimmer, Australia, 2015
--

with Ada.Text_IO;           use Ada.Text_IO;
with Queue_Pack_Exceptions; use Queue_Pack_Exceptions;

procedure Queue_Test_Exceptions is

   Queue : Queue_Type;

begin
   declare
      Written_Item : Element := Element'First;
   begin
      for i in 1 .. Queue_Size loop
         Enqueue (Written_Item, Queue);
         Written_Item := Element'Succ (Written_Item);
      end loop;
   end;

   Put_Line ("Correct: Queue accepted 10 elements");

   begin
      Enqueue (Element'First, Queue);
      raise Program_Error with "Queue accepted 11 elements";
   exception
      when Queue_overflow => Put_Line ("Correct: Queue rejected to enqueue an 11th element");
   end;

   if Is_Empty (Queue) then
      raise Program_Error with "Queue should not be empty after adding 10 elements";
   elsif not Is_Full (Queue) then
      raise Program_Error with "Queue should be full after adding 10 elements";
   else
      Put_Line ("Correct: Queue is full after adding 10 elements");
   end if;

   declare
      Written_Item : Element := Element'First;
      Read_Item    : Element;
   begin

      for i in 1 .. Queue_Size loop
         Dequeue (Read_Item, Queue);
         if Read_Item /= Written_Item then
            raise Program_Error with "The elements are dequeing incorrectly";
         end if;
         Written_Item := Element'Succ (Written_Item);
      end loop;
   end;

   Put_Line ("Correct: Queue re-produced 10 elements in the correct order");

   declare
      Read_Item    : Element;
   begin
      Dequeue (Read_Item, Queue);
      raise Program_Error with "Queue dequeued an element from an empty queue";
   exception
      when Queue_underflow => Put_Line ("Correct: Queue rejected to dequeue from an empty queue");
   end;

   if not Is_Empty (Queue) then
      raise Program_Error with "Queue should be empty after adding and removing 10 elements";
   elsif Is_Full (Queue) then
      raise Program_Error with "Queue should not be full after adding and removing 10 elements";
   else
      Put_Line ("Correct: Queue is empty after adding and removing 10 elements");
   end if;

   Put_Line ("All cool - all tests passed");

exception
   when Queue_underflow => Put ("Queue underflow");
   when Queue_overflow  => Put ("Queue overflow");

--     Queue : Queue_Type;
--     Item  : Element;
--
--  begin
--     Enqueue (Turn, Queue);
--
--     Dequeue (Item, Queue); Put (Element'Image (Item));
--
--     Dequeue (Item, Queue); -- will produce a 'Queue underflow'
--     Put (Element'Image (Item));
--
--     Put ("Queue is empty on exit: "); Put (Boolean'Image (Is_Empty (Queue)));
--
--  exception
--     when Queue_underflow => Put ("Queue underflow");
--     when Queue_overflow  => Put ("Queue overflow");

end Queue_Test_Exceptions;
