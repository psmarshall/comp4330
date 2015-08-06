--
-- Peter Marshall, Australia, 2015
--
with Token_Ring;

package Linked_List is
   package Token_Ring_Character is
     new Token_Ring (Character);
   use Token_Ring_Character;

   type Task_Node;
   type Node_List is access Task_Node;
   type Task_Node is record
      Node : Token_Task;
      Next : Node_List := Null;
   end record;
end Linked_List;
