--
-- Uwe R. Zimmer, Australia, 2013
--

with Ada.Text_IO;          use Ada.Text_IO;
with Queue_Pack_Protected; use Queue_Pack_Protected;

procedure Queue_Test_Protected is

   Queue : Protected_Queue;

   task Producer is end Producer;
   task Consumer is end Consumer;

   task body Producer is

      subtype Lower is Character range 'a' .. 'z';

   begin
      for Ch in Lower loop
         Queue.Enqueue (Ch);
      end loop;
   end Producer;

   task body Consumer is

      Item  : Element;

   begin
      loop
         select
            Queue.Dequeue (Item); -- task might be blocked here!
            Put ("Received: "); Put (Item); Put_Line ("!");
         or delay 0.001;
            exit; -- main task loop
         end select;
      end loop;
   end Consumer;

begin
   null;
end Queue_Test_Protected;
