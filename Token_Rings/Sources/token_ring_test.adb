--
-- Peter Marshall, Australia, 2015
--
with Ada.Text_IO; use Ada.Text_IO;
with Token_Ring;

procedure Token_Ring_Test is
   -- Our Token Ring type, here we just use a
   -- Character as the token.
   package Token_Ring_Character is
     new Token_Ring (Data_Token_Type => Character,
                     Status_Token_Type => Character);
   use Token_Ring_Character;

   type Node_Index is mod 8;
   Nodes : array (Node_Index) of Token_Task_Access;

begin
   -- Initialise each Node
   for ix in Node_Index loop
     Nodes(ix) := new Token_Task;
   end loop;
   -- Set up our ring, using modulo type to handle the edge case
   for ix in Node_Index loop
     Nodes(ix).Set_Next_Node (Nodes(Node_Index'Succ (ix)));
   end loop;
   -- Insert the tokens into our network
   Nodes(0).ReceiveStatus ('s');
   Nodes(0).ReceiveData ('d');
end Token_Ring_Test;
