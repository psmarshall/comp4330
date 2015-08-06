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
      --loop
         accept Receive (Token : in Token_Type) do
            Local_Token := Token;
            Put_Line ("Task" & Image (Current_Task) & " received token");
         end Receive;
         -- Do something to token
         Next.all.Receive (Local_Token);
         Put_Line ("Task" & Image (Current_Task) & " passed token");
      --end loop;
   end Token_Task;

end Token_Ring;
