--
-- Uwe R. Zimmer, Australia, 2013
--

-- This generic monitor synchronizes the concurrent parts of
-- an atomic action and distributes a failure signal to all.
-- This monitor is used in conjunction with Generic_Atomic_Action.

package body Atomic_Controller is

   protected body Monitor is

      entry Activate when State = Waiting is

      begin
         State := Checking_In;
      end Activate;

      entry Check_In (Task_Id : Task_Ids) when State = Checking_In is

      begin
         if Check_List (Task_Id) = Is_In then
            raise Repeated_Check_In;
         else
            Check_List (Task_Id) := Is_In;
            if Check_List = Check_List_All_In then
               State := All_Checked_In;
            end if;
         end if;
      end Check_In;

      entry Fail (Condition : Atomic_Condition) when State = All_Checked_In is

      begin
         Final_Condition := Condition;
      end Fail;

      entry Failed when Final_Condition /= Succeeded is

      begin
         null;
      end Failed;

      entry Check_Out (for Check_Out_Queue in Check_Out_State) (Task_Id : Task_Ids)
      when State = Checking_Out
        or else Check_Out (Check_Out_Queue)'Count = Task_List'Length is

      begin
         State := Checking_Out;
         Check_List (Task_Id) := Is_Out;
         if Check_List = Check_List_All_Out then
            State := Final;
         end if;
      end Check_Out;

      entry Action_Result (Condition : out Atomic_Condition) when State = Final is

      begin
         Condition       := Final_Condition;
         State           := Waiting;
         Final_Condition := Succeeded;
      end Action_Result;

   end Monitor;

end Atomic_Controller;
