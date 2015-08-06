--
-- Uwe R. Zimmer, Australia, 2013
--

package body Queue_Pack_Task_Generic is

   task body Queue_Task is

      subtype Marker is Natural range 0 .. Queue_Size - 1;
      -- bounds chosen such that modulo arithmetic can be used
      type List is array (Marker) of Element;
      type Queue_Type is record
         Top, Free : Marker  := Marker'First;
         Is_Empty  : Boolean := True;
         Elements  : List;
      end record;

      Queue : Queue_Type;

      function Is_Empty return Boolean is
        (Queue.Is_Empty);

      function Is_Full return Boolean is
        (not Queue.Is_Empty and then Queue.Top = Queue.Free);

   begin
      loop
         select
            when not Is_Full =>
               accept Enqueue (Item :     Element) do
                  Queue.Elements (Queue.Free) := Item;
               end Enqueue;
               Queue.Free     := (Queue.Free + 1) mod Queue_Size;
               Queue.Is_Empty := False;
         or
            when not Is_Empty =>
               accept Dequeue (Item : out Element) do
                  Item := Queue.Elements (Queue.Top);
               end Dequeue;
               Queue.Top      := (Queue.Top + 1) mod Queue_Size;
               Queue.Is_Empty := Queue.Top = Queue.Free;
         or
            accept Is_Empty (Result : out Boolean) do
               Result := Is_Empty;
            end Is_Empty;
         or
            accept Is_Full  (Result : out Boolean) do
               Result := Is_Full;
            end Is_Full;
         or
            terminate;
         end select;
      end loop;
   end Queue_Task;

end Queue_Pack_Task_Generic;
