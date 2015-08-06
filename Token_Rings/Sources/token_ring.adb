--
-- Peter Marshall, Australia, 2015
--
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Task_Identification; use Ada.Task_Identification;

package body Token_Ring is
   task body Token_Task is
      Next : Token_Task_Access;
   begin
      -- In a token ring, we need to know who our neighbour in the ring is.
      -- Accept a pointer to the next task and store it. Note that this must be
      -- called before any tokens can be received.
      accept Set_Next_Node (Node : in Token_Task_Access) do
         Next := Node;
      end Set_Next_Node;
      loop
         select
            accept ReceiveStatus (Token : in Status_Token_Type) do
               Local_Status_Token := Token;
               Put_Line ("Task" & Image (Current_Task) &
                         " received status token");
            end ReceiveStatus;
            -- Delay here to simulate doing something with the status token

            -- Pass on the status token to the next node
            Next.all.ReceiveStatus (Local_Status_Token);
            Put_Line ("Task" & Image (Current_Task) & " passed status token");
         or
            accept ReceiveData (Token : in Data_Token_Type) do
               Local_Data_Token := Token;
               Put_Line ("Task" & Image (Current_Task) &
                         " received data token");
            end ReceiveData;

            delay 0.1; --simulate processing the data

            -- Because we had to process data for so long, our status token
            -- might have arrived. If it has, grab it and send it on ahead,
            -- otherwise it will stay stuck behind the data token at the next
            -- node, and so on.
            if ReceiveStatus'Count > 0 then
               accept ReceiveStatus (Token : in Status_Token_Type) do
                  Local_Status_Token := Token;
                  Put_Line ("Task" & Image (Current_Task) &
                            " received status token AFTER processing data");
               end ReceiveStatus;
               -- Delay here to simulate doing something with the status token

               -- Pass on the status token to the next node
               Next.all.ReceiveStatus (Local_Status_Token);
            end if;
            -- Pass on the data token to the next node
            Next.all.ReceiveData (Local_Data_Token);
            Put_Line ("Task" & Image (Current_Task) & " passed data token");
         end select;
      end loop;
   end Token_Task;

end Token_Ring;
