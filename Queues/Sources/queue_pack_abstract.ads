--
-- Uwe R. Zimmer, Australia, 2015
--

generic

   type Element is private;

package Queue_Pack_Abstract is

   type Queue_Interface is synchronized interface;

   procedure Enqueue (Q : in out Queue_Interface; Item :     Element) is abstract;
   procedure Dequeue (Q : in out Queue_Interface; Item : out Element) is abstract;

end Queue_Pack_Abstract;
