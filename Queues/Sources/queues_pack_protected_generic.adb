--
-- Uwe R. Zimmer, Australia, 2013
--

package body Queues_Pack_Protected_Generic is

   protected body Protected_Queue is

      entry Enqueue (Item : Element) when not Is_Full is

      begin
         Queue.Elements (Queue.Free) := (Elem => Item, Reads => None_Read);
         Queue.Free := (Queue.Free + 1) mod Queue_Size;
      end Enqueue;

      entry Dequeue (for Q in Queue_Enum) (Item : out Element)
      when not Is_Empty (Q) and then (Enqueue'Count = 0 or else Is_Full) is

      begin
         Item := Queue.Elements (Queue.Readers (Q)).Elem;
         Queue.Elements (Queue.Readers (Q)).Reads (Q) := True;
         Queue.Readers (Q) := (Queue.Readers (Q) + 1) mod Queue_Size;
      end Dequeue;

      function Is_Empty (Q : Queue_Enum) return Boolean is
        (Queue.Elements (Queue.Readers (Q)).Reads (Q));

      function Is_Full return Boolean is
        (Queue.Elements (Queue.Free).Reads /= All_Read);

   end Protected_Queue;
end Queues_Pack_Protected_Generic;
