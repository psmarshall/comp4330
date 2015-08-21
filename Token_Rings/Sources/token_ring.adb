--
-- Peter Marshall, Australia, 2015
--
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Real_Time; use Ada.Real_Time;
with System; use System;
with Ada.Dispatching; use Ada.Dispatching;

package body Token_Ring is
   task body Token_Task is
      Next : Token_Task_Access;
      -- We can store our own copy of each token
      Local_Data_Token : Data_Token_Type;
      Local_Status_Token : Status_Token_Type;

      Local_Data_Task : Data_Processing_Task;
      Local_Burger_Task : Burger_Flipping_Task;
      Start, Finish : Time;
   begin
      -- In a token ring, we need to know who our neighbour in the ring is.
      -- Accept a pointer to the next task and store it. Note that this must be
      -- called before any tokens can be received.
      accept Set_Next_Node (This, Node : in Token_Task_Access) do
         Next := Node;
         Local_Data_Task.Set_Token_Task (This);
         Local_Burger_Task.Flip_Burgers; -- We are hungry
      end Set_Next_Node;

      loop
         select
            accept ReceiveStatus (Token : in Status_Token_Type) do
               Local_Status_Token := Token;
               Put_Line ("Task" & Image (Current_Task) &
                         " received status token");
            end ReceiveStatus;
            Start := Clock;
            -- Delay here to simulate doing something with the status token
            for ix in 1..100_000_000 loop
               null;
            end loop;
            Finish := Clock;
            Put_Line ("Task" & Image (Current_Task) & " status processing took " & Duration'Image (To_Duration (Finish - Start)));

            -- Pass on the status token to the next node
            Next.all.ReceiveStatus (Local_Status_Token);
         or
            accept ReceiveData (Token : in Data_Token_Type) do
               Local_Data_Token := Token;
               Put_Line ("Task" & Image (Current_Task) &
                         " received data token");
            end ReceiveData;

            -- Pass to our data processing task to process the data
            Local_Data_Task.Process_Data (Local_Data_Token);
         or
            accept Send_Data (Token : in Data_Token_Type) do
               Local_Data_Token := Token;
            end Send_Data;

            -- We are finally done processing our data in our worker thread
            -- and we've gotten it back. Time to send it off to the next node.
            Next.all.ReceiveData (Local_Data_Token);
         end select;
      end loop;
   end Token_Task;

   task body Data_Processing_Task is
      Local_Data_Token : Data_Token_Type;
      My_Token_Task : Token_Task_Access;
      Magic_Number : Long_Long_Integer := 0;
      Start, Finish, Target_Finish : Time;
   begin
      -- We need a pointer back to the task that handles the network entries,
      -- so accept and set it here.
      accept Set_Token_Task (Node : in Token_Task_Access) do
         My_Token_Task := Node;
      end Set_Token_Task;

      loop
         accept Process_Data (Token : in Data_Token_Type) do
            Local_Data_Token := Token;
            Put_Line ("Data Processing Task" & Image (Current_Task) &
                            " received some data to process");
         end Process_Data;

         -- Delay here to simulate doing something with the data.
         -- This would normally change the Local_Data_Token, for example,
         -- to stick some data in it for another node.

         Start := Clock;
         Target_Finish := Start + Milliseconds (1000);
         select
            delay until Target_Finish;
            Finish := Clock;
         then abort
            for ix in 1..100_000_000 loop
               Magic_Number := Magic_Number + 1;
               delay 0.00;-- Allow us to actually be interrupted
            end loop;
            Magic_Number := 0;
            Finish := Clock;
         end select;

         Put_Line ("Task" & Image (Current_Task) & " data processing took "
                   & Duration'Image (To_Duration (Finish - Start)));

         My_Token_Task.all.Send_Data (Local_Data_Token);
      end loop;
   end Data_Processing_Task;

   -- Passing tokens is tough work. Flip some burger patties
   -- while we wait.
   task body Burger_Flipping_Task is
      type Bit is new Natural range 0..1;
      Burger : Bit := 0;
   begin
      accept Flip_Burgers do
         null;
      end Flip_Burgers;
      while True loop
         if Burger = 0 then
            Burger := 1;
         else
            Burger := 0;
         end if;
      end loop;
   end Burger_Flipping_Task;

end Token_Ring;
