--
-- Uwe R. Zimmer, Australia, 2013
--

package body Queue_Pack_Object is

   overriding procedure Enqueue (Item : Element; Queue : in out Ext_Queue_Type) is

   begin
      Enqueue (Item, Queue_Type (Queue));
      Queue.Reader_Is_Empty := False;
   end Enqueue;

   procedure Read_Queue (Item : out Element; Queue : in out Ext_Queue_Type) is

   begin
      if Queue.Reader_Is_Empty then
         raise Queue_underflow;
      end if;
      Item                  := Queue.Elements (Queue.Reader);
      Queue.Reader          := Queue.Reader + 1;
      Queue.Reader_Is_Empty := Queue.Reader = Queue.Free;
   end Read_Queue;

end Queue_Pack_Object;
