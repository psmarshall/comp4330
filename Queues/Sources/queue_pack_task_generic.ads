--
-- Uwe R. Zimmer, Australia, 2013
--

with Queue_Pack_Abstract;

generic
   with package Queue_Instance is new Queue_Pack_Abstract (<>);
   Queue_Size : Positive := 10;

package Queue_Pack_Task_Generic is

   use Queue_Instance;

   task type Queue_Task is new Queue_Interface with

      entry Enqueue (Item :     Element);
      entry Dequeue (Item : out Element);

      entry Is_Empty (Result : out Boolean);
      entry Is_Full  (Result : out Boolean);

   end Queue_Task;

end Queue_Pack_Task_Generic;
