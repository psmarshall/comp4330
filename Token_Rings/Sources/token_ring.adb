--
-- Peter Marshall, Australia, 2015
--
with Ada.Text_IO; use Ada.Text_IO;
with Ada.Task_Identification; use Ada.Task_Identification;

package body Token_Ring is
   task body Token_Task is
      Next : Token_Task_Access;
   begin
      accept Set_Next_Node (Node : in Token_Task_Access) do
         Next := Node;
      end Set_Next_Node;
      loop
         select
            when ReceiveStatus'Count > 0 =>
               accept ReceiveStatus (Token : in Token_Type) do
                  Local_Status_Token := Token;
                  Have_Status_Token := True;
                  Put_Line ("Task" & Image (Current_Task) & " received status token");
               end ReceiveStatus;
               Next.all.ReceiveStatus (Local_Status_Token);
               Have_Status_Token := False;
               Put_Line ("Task" & Image (Current_Task) & " passed status token");
         or
            when ReceiveData'Count > 0 =>
               accept ReceiveData (Token : in Token_Type) do
                  Local_Data_Token := Token;
                  Have_Data_Token := True;
                  Put_Line ("Task" & Image (Current_Task) & " received data token");
               end ReceiveData;
               delay 0.1; --simulate processing the data
               -- Because we had to process data for so long, our status token
               -- might have arrived. If it has, grab it and send it on ahead.
               if ReceiveStatus'Count > 0 then
                  accept ReceiveStatus (Token : in Token_Type) do
                     Local_Status_Token := Token;
                     Have_Status_Token := True;
                     Put_Line ("Task" & Image (Current_Task) & " received status token AFTER processing data");
                  end ReceiveStatus;
                  Next.all.ReceiveStatus (Local_Status_Token);
                  Have_Status_Token := False;
               end if;
               Next.all.ReceiveData (Local_Data_Token);
               Have_Data_Token := False;
               Put_Line ("Task" & Image (Current_Task) & " passed data token");
         or delay 0.001;
         end select;
      end loop;
   end Token_Task;

end Token_Ring;
