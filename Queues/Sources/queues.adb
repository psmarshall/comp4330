--
-- Uwe R. Zimmer, Australia, 2014
--

package body Queues is

   protected body Protected_Queue is

      entry Enqueue_For_All (Item : Element) when not Is_Full is

      begin
         Queue.Elements (Queue.Free) := (Elem => Item, Reads => None_Read);
         Queue.Free := Queue.Free + 1;
      end Enqueue_For_All;

      entry Dequeue_For_All (Item : out Element)
        when not Is_Empty
        and then (Enqueue_For_All'Count = 0 or else Is_Full) is

      begin
         Item := Queue.Elements (Queue.Top).Elem;
         Queue.Elements (Queue.Top).Reads := All_Read;
         for Q in Queue_Enum loop
            if Queue.Readers (Q) = Queue.Top then
               Queue.Readers (Q) := Queue.Readers (Q) + 1;
            end if;
         end loop;
         Queue.Top := Queue.Top + 1;
      end Dequeue_For_All;

      entry Dequeue (for Q in Queue_Enum) (Item : out Element)
      when not Is_Empty (Q)
        and then (Q = Queue_Enum'Last
                  or else (for all Higher in Queue_Enum'Succ (Q) .. Queue_Enum'Last
                            => Dequeue (Higher)'Count = 0 or else Is_Empty (Higher)))
        and then (Enqueue_For_All'Count = 0 or else Is_Full)
        and then (Dequeue_For_All'Count = 0) is

      begin
         Item := Queue.Elements (Queue.Readers (Q)).Elem;
         Queue.Elements (Queue.Readers (Q)).Reads (Q) := True;
         Queue.Readers (Q) := Queue.Readers (Q) + 1;
         if Queue.Elements (Queue.Readers (Q)).Reads = All_Read then
            Queue.Top := Queue.Top + 1;
         end if;
      end Dequeue;

      function Is_Empty return Boolean is
         (for all Q in Queue_Enum => Is_Empty (Q));

      function Is_Empty (Q : Queue_Enum) return Boolean is
        (Queue.Elements (Queue.Readers (Q)).Reads (Q));

      function Is_Full return Boolean is
        (Queue.Elements (Queue.Free).Reads /= All_Read);

      function Length return Natural is
         (if Is_Full then Natural (Index'Last) + 1 else Natural (Queue.Free - Queue.Top));

      function Length (Q : Queue_Enum) return Natural is
         (if Is_Full then Natural (Index'Last) + 1 else Natural (Queue.Free - Queue.Readers (Q)));

      function Lookahead (Depth : Index) return Element is
        (Queue.Elements (Queue.Top + Depth).Elem);

      function Lookahead (Q : Queue_Enum; Depth : Index) return Element is
        (Queue.Elements (Queue.Readers (Q) + Depth).Elem);

   end Protected_Queue;
end Queues;
