--
-- Uwe R. Zimmer, Australia, 2013
--

pragma Initialize_Scalars;

package Queue_Pack_Simple is

   Queue_Size : constant Positive := 10;
   type Element is new Positive range 1_000 .. 40_000;
   type Marker is mod Queue_Size;
   type List is array (Marker) of Element;
   type Queue_Type is record
      Top, Free : Marker  := Marker'First;
      Is_Empty  : Boolean := True;
      Elements  : List; -- will be initialized to invalids
   end record;

   procedure Enqueue (Item :     Element; Queue : in out Queue_Type);
   procedure Dequeue (Item : out Element; Queue : in out Queue_Type);

   function Is_Empty (Queue : Queue_Type) return Boolean is
     (Queue.Is_Empty);

   function Is_Full (Queue : Queue_Type) return Boolean is
     (not Queue.Is_Empty and then Queue.Top = Queue.Free);

end Queue_Pack_Simple;
