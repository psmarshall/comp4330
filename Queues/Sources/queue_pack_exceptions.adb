--
-- Uwe R. Zimmer, Australia, 2013
--

package body Queue_Pack_Exceptions is

   procedure Enqueue (Item : Element; Queue : in out Queue_Type) is

   begin
      if Is_Full (Queue) then
         raise Queue_overflow;
      end if;
      Queue.Elements (Queue.Free) := Item;
      Queue.Free     := Marker'Succ (Queue.Free);
      Queue.Is_Empty := False;
   end Enqueue;

   procedure Dequeue (Item : out Element; Queue : in out Queue_Type) is

   begin
      if Is_Empty (Queue) then
         raise Queue_underflow;
      end if;
      Item           := Queue.Elements (Queue.Top);
      Queue.Top      := Marker'Succ (Queue.Top);
      Queue.Is_Empty := Queue.Top = Queue.Free;
   end Dequeue;

end Queue_Pack_Exceptions;
