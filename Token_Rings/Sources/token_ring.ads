--
-- Peter Marshall, Australia, 2015
--

with System; use System;

generic
   type Data_Token_Type is private;
   type Status_Token_Type is private;
package Token_Ring is
   type Token_Task; --forward declare task type
   type Token_Task_Access is access all Token_Task; -- pointer to task

   -- Finish declaring task type.
   -- Each task has a pointer to the next task, with the final task pointing
   -- back to the first (circular linked-list).
   task type Token_Task is
      pragma Priority (Priority'Last);
      entry ReceiveData   (Token : in Data_Token_Type);
      entry Send_Data     (Token : in Data_Token_Type);
      entry ReceiveStatus (Token : in Status_Token_Type);
      entry Set_Next_Node (This, Node : in Token_Task_Access);
   end Token_Task;

   task type Data_Processing_Task is
      pragma Priority (Priority'First);
      entry Process_Data   (Token : in Data_Token_Type);
      entry Set_Token_Task (Node  : in Token_Task_Access);
   end Data_Processing_Task;

   task type Burger_Flipping_Task is
      pragma Priority (Priority'First);
      entry Flip_Burgers;
   end Burger_Flipping_Task;

end Token_Ring;
