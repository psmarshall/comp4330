--
-- Uwe R. Zimmer, Australia, 2013
--

------------------------------------------------------------------
-- see Generic_Atomic_Action for a description of
-- these parameters
------------------------------------------------------------------

with Ada.Real_Time; use Ada.Real_Time;

generic
   type Parts_Enum is (<>);

package Generic_Atomic_Action_Types is

   type Action_Part_Time_Scope is record
      Start_Delay_Min : Time_Span := Time_Span_Zero;
      Start_Delay_Max : Time_Span := Time_Span_Last;
      Max_Elapse      : Time_Span := Time_Span_Last;
      Deadline        : Time      := Time_Last;
   end record;

   type Action_Part_Proc is access procedure;

   type Action_Part_Procs is record
      Action,
      Cleanup : Action_Part_Proc;
      Scope   : Action_Part_Time_Scope;
   end record;

   type Action_Parts is array (Parts_Enum) of Action_Part_Procs;

end Generic_Atomic_Action_Types;
