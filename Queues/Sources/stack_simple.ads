--
-- Peter Marshall, Australia, 2015
--

pragma Initialize_Scalars;

package Stack_Simple is

   Stack_Size : constant Positive := 10;
   type Element is new Positive range 1_000 .. 40_000;
   type Marker is mod Stack_Size;
   type List is array (Marker) of Element;
   type Stack_Type is record
      Top, Free : Marker  := Marker'First;
      Is_Empty  : Boolean := True;
      Elements  : List; -- will be initialized to invalids
   end record;

   procedure Push (Item :     Element; Stack : in out Stack_Type);
   procedure Pop  (Item : out Element; Stack : in out Stack_Type);

   function Is_Empty (Stack : Stack_Type) return Boolean is
     (Stack.Is_Empty);

   function Is_Full (Stack : Stack_Type) return Boolean is
     (not Stack.Is_Empty and then Stack.Top = Stack.Free);

end Stack_Simple;
