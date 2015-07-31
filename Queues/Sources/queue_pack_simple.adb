--
-- Uwe R. Zimmer, Australia, 2013
--

package body Queue_Pack_Simple is

   procedure Enqueue (Item : Element; Queue : in out Queue_Type) is

   begin
      Queue.Elements (Queue.Free) := Item;
      Queue.Free                  := Queue.Free + 1;
      Queue.Is_Empty              := False;
   end Enqueue;

   procedure Dequeue (Item : out Element; Queue : in out Queue_Type) is

   begin
      Item           := Queue.Elements (Queue.Top);
      Queue.Top      := Queue.Top + 1;
      Queue.Is_Empty := Queue.Top = Queue.Free;
   end Dequeue;

end Queue_Pack_Simple;
