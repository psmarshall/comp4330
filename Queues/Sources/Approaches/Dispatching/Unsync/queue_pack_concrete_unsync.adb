--
-- Uwe R. Zimmer, Australia, 2013
--

package body Queue_Pack_Concrete_Unsync is

   overriding procedure Enqueue (Item : Element; Queue : in out Real_Queue) is

   begin
      if Is_Full (Queue) then
         raise Queueoverflow;
      end if;
      Queue.Elements (Queue.Free) := Item;
      Queue.Free     := (Queue.Free + 1) mod Queue_Size;
      Queue.Is_Empty := False;
   end Enqueue;

   overriding procedure Dequeue (Item : out Element; Queue : in out Real_Queue) is

   begin
      if Is_Empty (Queue) then
         raise Queueunderflow;
      end if;
      Item           := Queue.Elements (Queue.Top);
      Queue.Top      := (Queue.Top + 1) mod Queue_Size;
      Queue.Is_Empty := Queue.Top = Queue.Free;
   end Dequeue;

   function Is_Empty (Queue : Real_Queue) return Boolean is
     (Queue.Is_Empty);

   function Is_Full (Queue : Real_Queue) return Boolean is
     (not Queue.Is_Empty and then Queue.Top = Queue.Free);

end Queue_Pack_Concrete_Unsync;
