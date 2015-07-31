--
-- Uwe R. Zimmer, Australia, 2013
--

with Ada.Text_IO;         use Ada.Text_IO;
with Queue_Pack_Abstract;
with Queue_Pack_Concrete;

procedure Queue_Test_Dispatching is

   package Queue_Pack_Abstract_Character is
     new Queue_Pack_Abstract (Character);
   use Queue_Pack_Abstract_Character;

   type Queue_Size is mod 3;

   package Queue_Pack_Character is
     new Queue_Pack_Concrete (Queue_Pack_Abstract_Character, Queue_Size);
   use Queue_Pack_Character;

   type Queue_Class is access all Queue_Interface'class;

   task Queue_Holder; -- could be on an individual partition / separate computer

   task Queue_User is -- could be on an individual partition / separate computer
      entry Send_Queue (Remote_Queue : Queue_Class);
   end Queue_User;

   task body Queue_Holder is

      Local_Queue : constant Queue_Class := new Protected_Queue;
      Item        : Character;

   begin
      Queue_User.Send_Queue (Local_Queue);
      Local_Queue.all.Dequeue (Item);
      Put_Line ("Local dequeue (Holder): " & Character'Image (Item));
   end Queue_Holder;

   task body Queue_User is

      Local_Queue : constant Queue_Class := new Protected_Queue;
      Item        : Character;

   begin
      accept Send_Queue (Remote_Queue : Queue_Class) do
         Remote_Queue.all.Enqueue ('r'); -- potentially a remote procedure call!
         Local_Queue.all.Enqueue  ('l');
      end Send_Queue;
      Local_Queue.all.Dequeue (Item);
      Put_Line ("Local dequeue (User)  : " & Character'Image (Item));
   end Queue_User;

begin
   null;
end Queue_Test_Dispatching;
