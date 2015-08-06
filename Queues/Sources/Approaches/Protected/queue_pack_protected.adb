--
-- Uwe R. Zimmer, Australia, 2013
--

package body Queue_Pack_Protected is

   protected body Protected_Queue is

      entry Enqueue (Item : Element) when not Is_Full is

      begin
         Queue.Elements (Queue.Free) := Item;
         Queue.Free     := Queue.Free + 1;
         Queue.Is_Empty := False;
      end Enqueue;

      entry Dequeue (Item : out Element) when not Is_Empty is

      begin
         Item      := Queue.Elements (Queue.Top);
         Queue.Top := Queue.Top + 1;
         Queue.Is_Empty := Queue.Top = Queue.Free;
      end Dequeue;

      function Is_Empty return Boolean is
        (Queue.Is_Empty);

      function Is_Full return Boolean is
        (not Queue.Is_Empty and then Queue.Top = Queue.Free);

   end Protected_Queue;
end Queue_Pack_Protected;
