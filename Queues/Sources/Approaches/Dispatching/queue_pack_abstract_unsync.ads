--
-- Uwe R. Zimmer, Australia, 2013
--

generic

   type Element is private;

package Queue_Pack_Abstract_Unsync is

   type Queue_Type is limited interface;
--     type Queue_Type is abstract tagged limited null record;
--     type Queue_Type is abstract tagged limited private;

   procedure Enqueue (Item :     Element; Queue : in out Queue_Type) is abstract;
   procedure Dequeue (Item : out Element; Queue : in out Queue_Type) is abstract;

--  private
--     type Queue_Type is abstract tagged limited null record;
end Queue_Pack_Abstract_Unsync;
