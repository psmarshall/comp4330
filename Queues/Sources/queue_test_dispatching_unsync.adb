--
-- Uwe R. Zimmer, Australia, 2013
--

with Ada.Text_IO;                use Ada.Text_IO;
with Queue_Pack_Abstract_Unsync;
with Queue_Pack_Concrete_Unsync;

procedure Queue_Test_Dispatching_Unsync is

   package Queue_Pack_Abstract_Character is new Queue_Pack_Abstract_Unsync (Character);
   use Queue_Pack_Abstract_Character;

   package Queue_Pack_Character is new Queue_Pack_Concrete_Unsync (Queue_Pack_Abstract_Character, 10);
   use Queue_Pack_Character;

   type Queue_Class is access all Queue_Type'class;

   task Queue_Holder is -- could be on an individual partition / separate computer
      entry Queue_Filled; -- rendezvous entry (synchronous message passing)
   end Queue_Holder;

   task Queue_User is   -- could be on an individual partition / separate computer
      entry Send_Queue (Remote_Queue : Queue_Class); -- rendezvous entry (synchronous message passing)
   end Queue_User;

   task body Queue_Holder is

      Local_Queue : constant Queue_Class := new Real_Queue; -- could be a different implementation!
      Item        : Character;

   begin
      Queue_User.Send_Queue (Local_Queue);
      accept Queue_Filled do
         Dequeue (Item, Local_Queue.all); -- Item will be 'r'
         Put_Line ("Local dequeue (Holder): " & Character'Image (Item));
      end Queue_Filled;
   end Queue_Holder;

   task body Queue_User is

      Local_Queue : constant Queue_Class := new Real_Queue; -- could be a different implementation!;
      Item        : Character;

   begin
      accept Send_Queue (Remote_Queue : Queue_Class) do
         Enqueue ('r', Remote_Queue.all); -- potentially a remote procedure call!
         Enqueue ('l', Local_Queue.all);
      end Send_Queue;
      Queue_Holder.Queue_Filled;
      Dequeue (Item, Local_Queue.all); -- Item will be 'l'
      Put_Line ("Local dequeue (User): " & Character'Image (Item));
   end Queue_User;

begin
   null;
end Queue_Test_Dispatching_Unsync;
