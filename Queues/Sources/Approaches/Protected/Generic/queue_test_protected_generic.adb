--
-- Uwe R. Zimmer, Australia, 2015
--

with Ada.Task_Identification;      use Ada.Task_Identification;
with Ada.Text_IO;                  use Ada.Text_IO;
with Queue_Pack_Protected_Generic;

procedure Queue_Test_Protected_Generic is

   type Queue_Size is mod 3;

   package Queue_Pack_Protected_Character is
      new Queue_Pack_Protected_Generic (Element => Character, Index => Queue_Size);
   use Queue_Pack_Protected_Character;

   subtype Some_Characters is Character range 'a' .. 'f';

   Queue : Protected_Queue;

   type Task_Index is range 1 .. 3;

   task type Producer;
   task type Consumer;

   Producers : array (Task_Index) of Producer; pragma Unreferenced (Producers);
   Consumers : array (Task_Index) of Consumer; pragma Unreferenced (Consumers);

   task body Producer is

   begin
      for Ch in Some_Characters loop
         Put_Line ("Task " & Image (Current_Task) & " finds the queue to be " &
                   (if Queue.Is_Empty then "EMPTY" else "not empty") &
                     " and " &
                   (if Queue.Is_Full  then "FULL" else "not full") &
                     " and prepares to add: " & Character'Image (Ch) &
                     " to the queue.");
         Queue.Enqueue (Ch); -- task might be blocked here!
      end loop;
      Put_Line ("<---- Task " & Image (Current_Task) & " terminates.");
   end Producer;

   task body Consumer is

      Item    : Character;
      Counter : Natural := 0;

   begin
      loop
         Queue.Dequeue (Item); -- task might be blocked here!
         Counter := Natural'Succ (Counter);
         Put_Line ("Task " & Image (Current_Task) &
                     " received: " & Character'Image (Item) &
                     " and the queue appears to be " &
                   (if Queue.Is_Empty then "EMPTY" else "not empty") &
                     " and " &
                   (if Queue.Is_Full  then "FULL" else "not full") &
                     " afterwards.");
         exit when Item = Some_Characters'Last;
      end loop;
      Put_Line ("<---- Task " & Image (Current_Task) &
                  " terminates and received" & Natural'Image (Counter) & " items.");
   end Consumer;

begin
   null;
end Queue_Test_Protected_Generic;
