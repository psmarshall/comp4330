--
-- Uwe R. Zimmer, Australia, 2015
--

with Queue_Pack_Abstract;

generic

   with package Queue_Instance is new Queue_Pack_Abstract (<>);
   type Index is mod <>; -- Modulo defines size of the queue.

package Queue_Pack_Concrete is

   use Queue_Instance;

   type Queue_Type is limited private;

   protected type Protected_Queue is new Queue_Interface with

      overriding entry Enqueue (Item :     Element);
      overriding entry Dequeue (Item : out Element);

      procedure Empty_Queue;

      function Is_Empty return Boolean;
      function Is_Full  return Boolean;

   private
      Queue : Queue_Type;

   end Protected_Queue;

private
   type List is array (Index) of Element;
   type Queue_Type is record
      Top, Free : Index   := Index'First;
      Is_Empty  : Boolean := True;
      Elements  : List;
   end record;
end Queue_Pack_Concrete;
