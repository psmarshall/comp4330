--
-- Uwe R. Zimmer, Australia, 2013
--

package Queue_Pack_Protected is

   Queue_Size : constant Positive := 10;
   subtype Element is Character;
   type Queue_Type is limited private;

   protected type Protected_Queue is

      entry Enqueue (Item :     Element);
      entry Dequeue (Item : out Element);

      function Is_Empty return Boolean;
      function Is_Full  return Boolean;

   private
      Queue : Queue_Type;

   end Protected_Queue;

private
   type Marker is mod Queue_Size;
   type List is array (Marker) of Element;
   type Queue_Type is record
      Top, Free : Marker  := Marker'First;
      Is_Empty  : Boolean := True;
      Elements  : List;
   end record;
end Queue_Pack_Protected;
