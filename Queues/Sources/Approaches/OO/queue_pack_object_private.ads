--
-- Uwe R. Zimmer, Australia, 2013
--

with Queue_Pack_Object_Base_Private; use Queue_Pack_Object_Base_Private;

package Queue_Pack_Object_Private is

   type Ext_Queue_Type is new Queue_Type with private;
   subtype Depth_Type is Positive range 1 .. Queue_Size;

   procedure Look_Ahead (Item  : out Element;
                         Depth :     Depth_Type; Queue : in out Ext_Queue_Type);

private
   type Ext_Queue_Type is new Queue_Type with null record;

end Queue_Pack_Object_Private;
