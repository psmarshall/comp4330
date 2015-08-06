--
-- Uwe R. Zimmer, Australia, 2014
--

pragma Initialize_Scalars;

-- Not all policies need to be supported when executing on top of a desktop-operating system
pragma Task_Dispatching_Policy (FIFO_Within_Priorities); -- default policy
--  pragma Task_Dispatching_Policy (Non_Preemptive_Within_Priorities);
--  pragma Task_Dispatching_Policy (EDF_Across_Priorities);
--  pragma Task_Dispatching_Policy (Round_Robin_Within_Priorities);

pragma Queuing_Policy (FIFO_Queuing); -- default policy
--  pragma Queuing_Policy (Priority_Queuing); -- does this change the behaviour of this program?

with Ada.Dynamic_Priorities;                use Ada.Dynamic_Priorities;
with Ada.Text_IO;                           use Ada.Text_IO;
with Exceptions;                            use Exceptions;
with Queues;
with System;                                use System;

procedure Queues_Test is
   pragma Priority (Priority'Last);

   type Sequence         is (Ready, Set, Go);
   type Modules          is (Startup, Taxi, Takeoff, Climb, Cruise, Avoid,
                             Acrobatics, Looping, Inverted, Glidepath, Landing);

   type Queue_Size is mod 2;

   package Avionics_Queue is
     new Queues (Element => Sequence, Queue_Enum => Modules, Index => Queue_Size);
   use Avionics_Queue;

   Queue : Protected_Queue;

   task type Avionics_Module is
      entry Provide_Id (Id : Modules);
   end Avionics_Module;

   Avionics : array (Modules) of Avionics_Module;

   protected type Synchronizer (No_of_tasks : Positive) is
      -- holds all tasks before letting them proceed
      -- and prints out their reported priorities on release.
      entry Wait_for_all (P : Priority);
   private
      Everybody_ready : Boolean := False;
   end Synchronizer;

   protected body Synchronizer is

      entry Wait_for_all  (P : Priority)
         when Wait_for_all'Count = No_of_tasks or else Everybody_ready is

      begin
         Put_Line ("Some task released on priority: " & Priority'Image (P));
         Everybody_ready := Wait_for_all'Count /= 0;
      end Wait_for_all;

   end Synchronizer;

   Avionics_Synchronizer : Synchronizer (Avionics'Length + 1);
   -- "+ 1" in order to synchronize the main task too.

   task body Avionics_Module is

      Module : Modules;

   begin
      accept Provide_Id (Id : Modules) do
         Module := Id;
      end Provide_Id;
      -- Spread the available priorities over the defined modules
      Set_Priority (Priority => Priority (Priority'First + Priority (Float (Modules'Pos (Module) - Modules'Pos (Modules'First))
                    * Float (Priority'Last - Priority'First) / Float (Modules'Pos (Modules'Last) - Modules'Pos (Modules'First)))));

      Avionics_Synchronizer.Wait_for_all (Get_Priority);

      declare
         Accumulator : Natural := Natural (Get_Priority);
      begin
         for i in 1 .. 10_000 loop -- burn some CPU time here by incrementing by one
            for j in 1 .. 10_000 loop -- in a slightly clumsy way.
               Accumulator := Accumulator + Natural'Min (i / 10_000, j / 10_000);
            end loop;
         end loop;
         Put_Line ("Task " & Modules'Image (Module) & " on priority: " & Priority'Image (Get_Priority)
                   & " accumulates: " & Natural'Image (Accumulator));
      end;

      declare
         Item : Sequence;
      begin
         for Order in Sequence loop
            Queue.Dequeue (Module) (Item);
            Put_Line (Modules'Image (Module) & " on priority: " & Priority'Image (Get_Priority) & " removed " & Sequence'Image (Item) & " from queue.");
         end loop;
      end;

      Avionics_Synchronizer.Wait_for_all (Get_Priority);

   exception
      when Exception_Id : others => Show_Exception (Exception_Id);
   end Avionics_Module;

begin
   for Module in Modules loop
--     for Module in reverse Modules loop -- will starting the tasks in reverse will have an effect?
      Avionics (Module).Provide_Id (Module);
   end loop;

   Avionics_Synchronizer.Wait_for_all (Get_Priority);

   declare
      Accumulator : Natural := Natural (Get_Priority);
   begin
      for i in 1 .. 10_000 loop -- burn some CPU time here by incrementing by one
         for j in 1 .. 10_000 loop -- in a slightly clumsy way.
            Accumulator := Accumulator + Natural'Min (i / 10_000, j / 10_000);
         end loop;
      end loop;
      Put_Line ("Main task on priority: " & Priority'Image (Get_Priority)
                & " accumulates: " & Natural'Image (Accumulator));
   end;

   for Order in Sequence loop
      Queue.Enqueue_For_All (Order);
      Put_Line (Sequence'Image (Order) & " added to queue.");
   end loop;

   Avionics_Synchronizer.Wait_for_all (Get_Priority);

exception
   when Exception_Id : others => Show_Exception (Exception_Id);
end Queues_Test;
