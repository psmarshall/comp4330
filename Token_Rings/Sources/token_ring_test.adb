--
-- Peter Marshall, Australia, 2015
--
with Ada.Text_IO; use Ada.Text_IO;
with Token_Ring;
with Linked_List; use Linked_List;

procedure Token_Ring_Test is
   -- Our Token Ring type, here we just use a
   -- Character as the token.
   package Token_Ring_Character is
     new Token_Ring (Character);
   use Token_Ring_Character;

   type Node_Index is mod 10;
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
   -- Insert the token into our network
   Nodes(0).ReceiveStatus ('s');
   Nodes(0).ReceiveData ('d');
end Token_Ring_Test;
