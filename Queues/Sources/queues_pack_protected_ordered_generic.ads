--
-- Uwe R. Zimmer, Australia, 2013
--

generic
   type Element is private;
   type Queue_Enum is (<>);
   Queue_Size : Positive;

package Queues_Pack_Protected_Ordered_Generic is

   type Queue_Type is limited private;

   protected type Protected_Queue is

      entry Enqueue              (Item :     Element);
      entry Dequeue (Queue_Enum) (Item : out Element);

      function Is_Empty (Q : Queue_Enum) return Boolean;
      function Is_Full                   return Boolean;

   private
      Queue : Queue_Type;

   end Protected_Queue;

private
   subtype Marker is Natural range 0 .. Queue_Size - 1;
   type Markers is array (Queue_Enum) of Marker;

   type Readouts is array (Queue_Enum) of Boolean;
   All_Read  : constant Readouts := (others => True);
   None_Read : constant Readouts := (others => False);

   type Element_and_Readouts is record
      Elem  : Element; -- Initialized to invalids
      Reads : Readouts := All_Read;
   end record;
   type List is array (Marker'Range) of Element_and_Readouts;

   type Queue_Type is record
      Free     : Marker  := Marker'First;
      Readers  : Markers := (others => Marker'First);
      Elements : List;
   end record;
end Queues_Pack_Protected_Ordered_Generic;
