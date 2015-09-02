--
-- Uwe R. Zimmer, Australia, 2013
--

-- Simple example for an atomic action.
--
-- Three flight control surfaces are to be moved in synchrony
-- and under real-time constraints.
--
-- In case of an overall failure, all surfaces move automatically to their
-- failsafe positions.
--

with Ada.Real_Time;               use Ada.Real_Time;
with Ada.Text_IO;                 use Ada.Text_IO;
with Ada.Float_Text_IO;           use Ada.Float_Text_IO;
with Exceptions;                  use Exceptions;
with Generic_Atomic_Action;
with Generic_Atomic_Action_Types;

procedure Atomic_Action is

   type Flight_Surfaces is (Elevator, Rudder, Ailerons);

   package Atomic_Action_Types is new Generic_Atomic_Action_Types (Flight_Surfaces);
   use Atomic_Action_Types;

   subtype Degrees    is Float   range -180.0 .. +180.0;
   subtype Deflection is Degrees range  -45.0 ..  +45.0;

   type Deflection_Set is array (Flight_Surfaces) of Deflection;

   protected Target_Deflections is

      procedure Write (Set : Deflection_Set);
      function Read_Surface (Surface : Flight_Surfaces) return Deflection;

   private
      Current_Set : Deflection_Set;
   end Target_Deflections;

   protected body Target_Deflections is

      procedure Write (Set : Deflection_Set) is

      begin
         Current_Set := Set;
      end Write;

      function Read_Surface (Surface : Flight_Surfaces) return Deflection is
         (Current_Set (Surface));

   end Target_Deflections;

   ------------------------
   --  Actions Parts
   ------------------------

   procedure Elevator_Action is

      Target : constant Deflection :=  Target_Deflections.Read_Surface (Elevator);

   begin
      Put ("Elevator starts moving to: ");
      Put (Item => Target, Fore => 1, Aft  => 2, Exp  => 0);
      Put (" degrees"); New_Line;
--        raise Constraint_Error;
      delay 1.0;
--        delay 3.0;
--        raise Constraint_Error;
      Put_Line ("Elevator arrived");
   end Elevator_Action;

   procedure Rudder_Action is

      Target : constant Deflection :=  Target_Deflections.Read_Surface (Rudder);

   begin
      Put ("Rudder starts moving to: ");
      Put (Item => Target, Fore => 1, Aft  => 2, Exp  => 0);
      Put (" degrees"); New_Line;
--        raise Constraint_Error;
      delay 2.0;
--        delay 4.0;
--        raise Constraint_Error;
      Put_Line ("Rudder arrived");
   end Rudder_Action;

   procedure Ailerons_Action is

      Target : constant Deflection :=  Target_Deflections.Read_Surface (Ailerons);

   begin
      Put ("Ailerons starts moving to: ");
      Put (Item => Target, Fore => 1, Aft  => 2, Exp  => 0);
      Put (" degrees"); New_Line;
--        raise Constraint_Error;
      delay 3.0;
--        delay 5.0;
--        raise Constraint_Error;
      Put_Line ("Ailerons arrived");
   end Ailerons_Action;

   ------------------------
   --  Cleanup Parts
   ------------------------

   procedure Elevator_Failsafe is

   begin
      Put_Line ("Elevator moving to failsafe positions");
   end Elevator_Failsafe;

   procedure Rudder_Failsafe is

   begin
      Put_Line ("Rudder moving to failsafe positions");
   end Rudder_Failsafe;

   procedure Ailerons_Failsafe is

   begin
      Put_Line ("Ailerons moving to failsafe positions");
   end Ailerons_Failsafe;

   --------------------------------------------------------
   --  Building whole atomic action
   --
   -- Experiment with these settings
   -- to see what happens under different circumstances.
   --
   --------------------------------------------------------

   Actions : constant Action_Parts :=
     (Elevator =>
        (Action  => Elevator_Action'Access,
         Cleanup => Elevator_Failsafe'Access,
         Scope   => (Start_Delay_Min => Milliseconds (11),
                     Start_Delay_Max => Milliseconds (20),
                     Max_Elapse      => Milliseconds (2000),
                     Deadline        => Time_Last)
           ),
      Rudder =>
        (Action  => Rudder_Action'Access,
         Cleanup => Rudder_Failsafe'Access,
         Scope   => (Start_Delay_Min => Milliseconds (13),
                     Start_Delay_Max => Milliseconds (20),
                     Max_Elapse      => Milliseconds (3000),
                     Deadline        => Time_Last)
        ),
      Ailerons =>
        (Action  => Ailerons_Action'Access,
         Cleanup => Ailerons_Failsafe'Access,
         Scope   => (Start_Delay_Min => Milliseconds (12),
                     Start_Delay_Max => Milliseconds (20),
                     Max_Elapse      => Milliseconds (4000),
                     Deadline        => Time_Last)
        ));

   package Atomic_Action_Package is new Generic_Atomic_Action (Atomic_Action_Types, Actions);
   use Atomic_Action_Package;

begin
   Target_Deflections.Write (Set => (Elevator => 2.0, Rudder => -1.2, Ailerons => 0.3));

   Atomic_Action_Package.Perform;

   Put_Line ("The surfaces moved in time and without error.");
exception
   when Exception_Id : others => Show_Exception (Exception_Id);
end Atomic_Action;
