--
-- Uwe R. Zimmer, Australia, 2013
--

with Queue_Pack_Abstract_Unsync;

generic

   with package Queue_Pack_Abstract_Instantiated is new Queue_Pack_Abstract_Unsync (<>);

   Queue_Size : Positive := 10;

package Queue_Pack_Concrete_Unsync is

   use Queue_Pack_Abstract_Instantiated;

   type Real_Queue is new Queue_Type with private;

   overriding procedure Enqueue (Item :     Element; Queue : in out Real_Queue);
   overriding procedure Dequeue (Item : out Element; Queue : in out Real_Queue);

   function Is_Empty (Queue : Real_Queue) return Boolean;
   function Is_Full  (Queue : Real_Queue) return Boolean;

   Queueoverflow, Queueunderflow : exception;

private
   subtype Marker is Natural range 0 .. Queue_Size - 1;
   type List is array (Marker) of Element;
   type Real_Queue is new Queue_Type with record
      Top, Free : Marker  := Marker'First;
      Is_Empty  : Boolean := True;
      Elements  : List; --
   end record;
end Queue_Pack_Concrete_Unsync;
