--
-- Uwe R. Zimmer, Australia, 2013
--

generic
   type Element is private;
   Queue_Size : Positive := 10;

package Queue_Pack_Generic is

   type Queue_Type is limited private;

   procedure Enqueue (Item :     Element; Queue : in out Queue_Type);
   procedure Dequeue (Item : out Element; Queue : in out Queue_Type);

   function Is_Empty (Queue : Queue_Type) return Boolean;
   function Is_Full  (Queue : Queue_Type) return Boolean;

   Queue_overflow, Queue_underflow : exception;

private
   subtype Marker is Natural range 0 .. Queue_Size - 1;
   -- bounds chosen such that modulo arithmetic can be used
   type List is array (Marker) of Element;
   type Queue_Type is record
      Top, Free : Marker  := Marker'First;
      Is_Empty  : Boolean := True;
      Elements  : List;
   end record;
end Queue_Pack_Generic;
