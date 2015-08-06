--
-- Uwe R. Zimmer, Australia, 2013
--

with Queues_Pack_Protected_Generic;
with Ada.Text_IO; use Ada.Text_IO;

procedure Queues_Test_Protected_Generic is

   type Sequence      is (Ready, Set, Go);
   type Flight_States is (Take_Off, Cruising, Landing);

   package Avionics_Queue_Pack is
     new Queues_Pack_Protected_Generic
       (Element => Sequence, Queue_Enum => Flight_States, Queue_Size => 2);
   use Avionics_Queue_Pack;

   Queue : Protected_Queue;

   task type Avionics_Module is
      entry Provide_State (State : Flight_States);
   end Avionics_Module;

   Avionics : array (Flight_States) of Avionics_Module;

   task body Avionics_Module is

      Local_State : Flight_States;
      Item        : Sequence;

   begin
      accept Provide_State (State : Flight_States) do
         Local_State := State;
      end Provide_State;
      for Order in Sequence loop
         Queue.Dequeue (Local_State) (Item);
         Put_Line (Flight_States'Image (Local_State) & " says: " & Sequence'Image (Item));
      end loop;
      Put_Line (Flight_States'Image (Local_State) & " queue is empty on exit: " & Boolean'Image (Queue.Is_Empty (Local_State)));
   end Avionics_Module;

begin
   for State in Flight_States loop
      Avionics (State).Provide_State (State);
   end loop;
   for Order in Sequence loop
      Queue.Enqueue (Order);
      Put_Line ("Item added to queue: " & Sequence'Image (Order));
   end loop;
end Queues_Test_Protected_Generic;
