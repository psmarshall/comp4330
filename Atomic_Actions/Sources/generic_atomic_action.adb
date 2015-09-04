--
-- Uwe R. Zimmer, Australia, 2013
--

with Ada.Real_Time;             use Ada.Real_Time;
with Atomic_Actions_Exceptions; use Atomic_Actions_Exceptions;
with Atomic_Controller;

package body Generic_Atomic_Action is

   use Atomic_Action_Types;

   package Atomic_Action is
     new Atomic_Controller (Task_Ids => Parts_Enum);
   use Atomic_Action;

   task type Action_Task is
      entry Identify (Id : Parts_Enum);
   end Action_Task;

   Tasks : array (Parts_Enum) of Action_Task;

   task body Action_Task is

      Task_Id : Parts_Enum;

   begin
      accept Identify (Id : Parts_Enum) do
         Task_Id := Id;
      end Identify;

      loop
         select
            Monitor.Failed;

            -- Abort and clean up in case of a global Failed state
            Actions (Task_Id).Cleanup.all;
            Atomic_Action.Monitor.Check_Out (Failed_Check_Out) (Task_Id);

         then abort

            Monitor.Check_In (Task_Id);

            begin

               declare
                  Min_Delay_Deadline : constant Time := Clock + Actions (Task_Id).Scope.Start_Delay_Min;
                  Max_Delay_Deadline : constant Time := Clock + Actions (Task_Id).Scope.Start_Delay_Max;
               begin

                  -- Observe required startup delays.
                  select
                     delay until Max_Delay_Deadline;
                     raise Late_Activation;
                  then abort
                     delay until Min_Delay_Deadline;
                  end select;
               end;

               declare
                  function Time_Min (t_1, t_2 : Time) return Time is (if t_1 < t_2 then t_1 else t_2);

                  Relative_Deadline : constant Time := (if Actions (Task_Id).Scope.Max_Elapse = Time_Span_Last then
                                                        Time_Last else Clock + Actions (Task_Id).Scope.Max_Elapse);
                  Absolute_Deadline : constant Time := Actions (Task_Id).Scope.Deadline;
                  Closer_Deadline   : constant Time := Time_Min (Relative_Deadline, Absolute_Deadline);
               begin

                  -- Execute this action part while observing the required deadline.
                  select
                     delay until Closer_Deadline;
                     raise Time_Out;
                  then abort
                     Actions (Task_Id).Action.all;
                  end select;
               end;

               Atomic_Action.Monitor.Check_Out (Normal_Check_Out) (Task_Id);

            exception
                  -- All exceptions in all parts are caught
                  -- and the central atomic action monitor is informed.
               when Time_Out        => Monitor.Fail (Time_Out_Condition);
               when Late_Activation => Monitor.Fail (Late_Condition);
               when others          => Monitor.Fail (Other_Exception);
            end;
         end select;
      end loop;
   end Action_Task;

   procedure Perform is

   begin
      for Id in Parts_Enum loop
         Tasks (Id).Identify (Id);
      end loop;

      declare
         Condition : Atomic_Condition;
      begin
         Atomic_Action.Monitor.Action_Result (Condition);

         case Condition is
            when Succeeded          => null;
               -- Conditions which lead to an abort of the atomic action
               -- are re-raised here again to inform the outer process.
            when Late_Condition     => raise Late_Activation;
            when Time_Out_Condition => raise Time_Out;
            when Other_Exception    => raise Uncaught_Exception;
         end case;
      end;
   end Perform;

end Generic_Atomic_Action;
