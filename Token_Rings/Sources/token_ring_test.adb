--
-- Peter Marshall, Australia, 2015
--
with Ada.Text_IO; use Ada.Text_IO;
with Token_Ring;
with Linked_List; use Linked_List;

procedure Token_Ring_Test is
   package Token_Ring_Character is
     new Token_Ring (Character);
   use Token_Ring_Character;

   Node_1 : Token_Task_Access := new Token_Task;
   Node_2 : Token_Task_Access := new Token_Task;
   Node_3 : Token_Task_Access := new Token_Task;
   -- Node_List : Linked_List.Node_List := new Task_Node;

begin
   Node_1.Set_Next_Node (Node_2);
   Node_2.Set_Next_Node (Node_3);
   Node_3.Set_Next_Node (Node_1);
   Node_1.Receive ('a');
   --Node_List.Next := new Task_Node;
   --Node_List.Next.Next := new Task_Node;
   --Node_List.Next.Next.Next := Node_List;
   -- Node_1.Receive ('a');
end Token_Ring_Test;
