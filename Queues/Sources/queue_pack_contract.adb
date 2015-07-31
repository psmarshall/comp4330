--
-- Uwe R. Zimmer, Australia, 2013
--

package body Queue_Pack_Contract is

   procedure Enqueue (Item : Element; Q : in out Queue_Type) is

   begin
      Q.Elements (Q.Free) := Item;
      Q.Free              := Q.Free + 1;
      Q.Is_Empty          := False;
   end Enqueue;

   procedure Dequeue (Item : out Element; Q : in out Queue_Type) is

   begin
      Item       := Q.Elements (Q.Top);
      Q.Top      := Q.Top + 1;
      Q.Is_Empty := Q.Top = Q.Free;
   end Dequeue;

end Queue_Pack_Contract;
