--
-- Uwe R. Zimmer, Australia, 2013
--

with Queue_Pack_Object_Base; use Queue_Pack_Object_Base;

package Queue_Pack_Object is

   type Ext_Queue_Type is new Queue_Type with record
      Reader          : Marker  := Marker'First;
      Reader_Is_Empty : Boolean := True;
   end record;

   overriding procedure Enqueue    (Item :     Element; Queue : in out Ext_Queue_Type);
   procedure            Read_Queue (Item : out Element; Queue : in out Ext_Queue_Type);

end Queue_Pack_Object;
