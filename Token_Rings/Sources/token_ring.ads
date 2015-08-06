--
-- Peter Marshall, Australia, 2015
--
generic
   type Data_Token_Type is private;
   type Status_Token_Type is private;
package Token_Ring is
   type Token_Task; --forward declare task type
   type Token_Task_Access is access Token_Task; -- pointer to task

   -- Finish declaring task type.
   -- Each task has a pointer to the next task, with the final task pointing
   -- back to the first (circular linked-list).
   task type Token_Task is
      entry ReceiveData   (Token : in Data_Token_Type);
      entry ReceiveStatus (Token : in Status_Token_Type);
      entry Set_Next_Node (Node  : in Token_Task_Access);
   end Token_Task;
end Token_Ring;
