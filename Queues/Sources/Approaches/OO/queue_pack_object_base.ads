--
-- Uwe R. Zimmer, Australia, 2013
--

package Queue_Pack_Object_Base is

   Queue_Size : constant Positive := 10;
   type Element is new Positive range 1 .. 1000;
   type Marker is mod Queue_Size;
   type List is array (Marker) of Element;
   type Queue_Type is tagged record
      Top, Free : Marker  := Marker'First;
      Is_Empty  : Boolean := True;
      Elements  : List;
   end record;

   procedure Enqueue (Item :     Element; Queue : in out Queue_Type);
   procedure Dequeue (Item : out Element; Queue : in out Queue_Type);

   function Is_Empty (Queue : Queue_Type) return Boolean;
   function Is_Full  (Queue : Queue_Type) return Boolean;

   Queue_overflow, Queue_underflow : exception;

end Queue_Pack_Object_Base;
