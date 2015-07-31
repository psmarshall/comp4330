--
-- Uwe R. Zimmer, Australia, 2013
--

package body Queue_Pack_Object_Private is

   procedure Look_Ahead (Item :  out Element;
                         Depth :     Depth_Type; Queue : in out Ext_Queue_Type) is

      Storage    : Queue_Type;
      ShuffleItem : Element;

   begin
      for I in 1 .. Depth - 1 loop
         Dequeue (ShuffleItem, Queue);
         Enqueue (ShuffleItem, Storage);
      end loop;
      Dequeue (Item, Queue);
      Enqueue (Item, Storage);
      Read_The_Rest : begin
         for I in 1 .. Queue_Size - Depth loop
            Dequeue (ShuffleItem, Queue);
            Enqueue (ShuffleItem, Storage);
         end loop;
      exception
         when Queueunderflow => null; -- read the rest is done
      end Read_The_Rest;
      Restore_The_Queue : begin
         for I in 1 .. Queue_Size loop
            Dequeue (ShuffleItem, Storage);
            Enqueue (ShuffleItem, Queue);
         end loop;
      exception
         when Queueunderflow => null; -- restore is done
      end Restore_The_Queue;

   end Look_Ahead;

end Queue_Pack_Object_Private;
