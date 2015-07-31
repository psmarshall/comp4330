--
-- Uwe R. Zimmer, Australia, 2013
--

pragma Initialize_Scalars;

package Queue_Pack_Contract is

   Queue_Size : constant Positive := 10;
   type Element is new Positive range 1 .. 1000;

   type Queue_Type is private;

   procedure Enqueue (Item :     Element; Q : in out Queue_Type) with
     Pre  => not Is_Full (Q),
     Post => not Is_Empty (Q) and then Length (Q) = Length (Q'Old) + 1
                and then Lookahead (Q, Length (Q)) = Item
                and then (for all ix in 1 .. Length (Q'Old) => Lookahead (Q, ix) = Lookahead (Q'Old, ix));

   procedure Dequeue (Item : out Element; Q : in out Queue_Type) with
     Pre  => not Is_Empty (Q),
     Post => not Is_Full (Q) and then Length (Q) = Length (Q'Old) - 1
                and then (for all ix in 1 .. Length (Q) => Lookahead (Q, ix) = Lookahead (Q'Old, ix + 1));

   function Is_Empty  (Q : Queue_Type) return Boolean;
   function Is_Full   (Q : Queue_Type) return Boolean;
   function Length    (Q : Queue_Type) return Natural;
   function Lookahead (Q : Queue_Type; Depth : Positive) return Element;

private
   type Marker is mod Queue_Size;
   type List is array (Marker) of Element;
   type Queue_Type is record
      Top, Free : Marker  := Marker'First;
      Is_Empty  : Boolean := True;
      Elements  : List; -- will be initialized to invalids
   end record with Type_Invariant => (not Queue_Type.Is_Empty or else Queue_Type.Top = Queue_Type.Free)
     and then (for all ix in 1 .. Length (Queue_Type) => Lookahead (Queue_Type, ix)'Valid);

   function Is_Empty (Q : Queue_Type) return Boolean is
     (Q.Is_Empty);

   function Is_Full (Q : Queue_Type) return Boolean is
     (not Q.Is_Empty and then Q.Top = Q.Free);

   function Length (Q : Queue_Type) return Natural is
     (if Is_Full (Q) then Queue_Size else Natural (Q.Free - Q.Top));

   function Lookahead (Q : Queue_Type; Depth : Positive) return Element is
     (Q.Elements (Q.Top + Marker (Depth - 1)));

end Queue_Pack_Contract;
