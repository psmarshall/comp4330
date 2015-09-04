--
-- Uwe R. Zimmer, Australia, 2013
--

-- This generic monitor synchronizes the concurrent parts of
-- an atomic action and distributes a failure signal to all.
-- This monitor is used in conjunction with Generic_Atomic_Action.

generic
   type Task_Ids is (<>);

package Atomic_Controller is

   type Atomic_State is (Waiting,
                         Checking_In,
                         All_Checked_In,
                         Checking_Out,
                         Final);

   type Atomic_Condition is (Succeeded,
                             Late_Condition,
                             Time_Out_Condition,
                             Other_Exception);

   type Check_Out_State is (Normal_Check_Out, Failed_Check_Out);

   type Task_State is (Is_In, Is_Out);

   type Task_List is array (Task_Ids) of Task_State;

   Check_List_All_In      : constant Task_List := (others => Is_In);
   Check_List_All_Out     : constant Task_List := (others => Is_Out);

   protected Monitor is

      entry Activate;

      entry Check_In      (Task_Id   :     Task_Ids);

      entry Fail          (Condition :     Atomic_Condition);
      entry Failed;

      entry Check_Out (Check_Out_State) (Task_Id : Task_Ids);

      entry Action_Result (Condition : out Atomic_Condition);

   private
      Check_List      : Task_List        := Check_List_All_Out;
      State           : Atomic_State     := Waiting;
      Final_Condition : Atomic_Condition := Succeeded;
      Id_Counter      : Task_Ids         := Task_Ids'First;

   end Monitor;

   Repeated_Check_In : exception;

end Atomic_Controller;
