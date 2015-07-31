--
-- Uwe R. Zimmer, Australia, 2013
--

package body Queue_Pack_Generic is

   procedure Enqueue (Item : Element; Queue : in out Queue_Type) is

   begin
      if Is_Full (Queue) then
         raise Queue_overflow;
      end if;
      Queue.Elements (Queue.Free) := Item;
      Queue.Free     := (Queue.Free + 1) mod Queue_Size;
      Queue.Is_Empty := False;
   end Enqueue;

   procedure Dequeue (Item : out Element; Queue : in out Queue_Type) is

   begin
      if Is_Empty (Queue) then
         raise Queue_underflow;
      end if;
      Item      := Queue.Elements (Queue.Top);
      Queue.Top := (Queue.Top + 1) mod Queue_Size;
      Queue.Is_Empty := Queue.Top = Queue.Free;
   end Dequeue;

   function Is_Empty (Queue : Queue_Type) return Boolean is
     (Queue.Is_Empty);

   function Is_Full (Queue : Queue_Type) return Boolean is
     (not Queue.Is_Empty and then Queue.Top = Queue.Free);

end Queue_Pack_Generic;
