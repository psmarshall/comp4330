--
-- Peter Marshall, Australia, 2015
--
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Task_Identification; use Ada.Task_Identification;
with Ada.Real_Time; use Ada.Real_Time;
with Ada.Calendar.Formatting;

package body Token_Ring is
   task body Token_Task is
      Next : Token_Task_Access;
      -- We can store our own copy of each token
      Local_Data_Token : Data_Token_Type;
      Local_Status_Token : Status_Token_Type;

      Local_Data_Task : Data_Processing_Task;
      Start, Finish : Time;
   begin
      -- In a token ring, we need to know who our neighbour in the ring is.
      -- Accept a pointer to the next task and store it. Note that this must be
      -- called before any tokens can be received.
      accept Set_Next_Node (This, Node : in Token_Task_Access) do
         Next := Node;
         Local_Data_Task.Set_Token_Task (This);
      end Set_Next_Node;

      loop
         select
            accept ReceiveStatus (Token : in Status_Token_Type) do
               Local_Status_Token := Token;
               Put_Line ("Task" & Image (Current_Task) &
                         " received status token");
            end ReceiveStatus;
            -- Delay here to simulate doing something with the status token
            Start := Clock;
            delay 0.1;
            Finish := Clock;
            Put_Line ("Task" & Image (Current_Task) & " took " & Duration'Image (To_Duration (Finish - Start)));
            -- Pass on the status token to the next node
            Next.all.ReceiveStatus (Local_Status_Token);
            Put_Line ("Task" & Image (Current_Task) & " passed status token");
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
               Put_Line ("Task" & Image (Current_Task) &
                         " received data back from worker");
            end Send_Data;

            -- We are finally done processing our data in our worker thread
            -- and we've gotten it back. Time to send it off to the next node.
            Next.all.ReceiveData (Local_Data_Token);
            Put_Line ("Task" & Image (Current_Task) & " passed data token");
         end select;
      end loop;
   end Token_Task;

   task body Data_Processing_Task is
      Local_Data_Token : Data_Token_Type;
      My_Token_Task : Token_Task_Access;
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
         delay 1.0;

         My_Token_Task.all.Send_Data (Local_Data_Token);
      end loop;
   end Data_Processing_Task;

end Token_Ring;
