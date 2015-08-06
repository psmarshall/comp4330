--
-- Peter Marshall, Australia, 2015
--
generic
   type Token_Type is private;
package Token_Ring is
   type Token_Task;
   type Token_Task_Access is access Token_Task;
   task type Token_Task is
      entry Receive       (Token : in  Token_Type);
      entry Set_Next_Node (Node : in Token_Task_Access);
   end Token_Task;

private
   Local_Token : Token_Type;
end Token_Ring;