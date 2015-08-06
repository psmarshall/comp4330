pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__token_ring_test.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__token_ring_test.adb");
pragma Suppress (Overflow_Check);

with System.Restrictions;
with Ada.Exceptions;

package body ada_main is
   pragma Warnings (Off);

   E138 : Short_Integer; pragma Import (Ada, E138, "system__os_lib_E");
   E013 : Short_Integer; pragma Import (Ada, E013, "system__soft_links_E");
   E023 : Short_Integer; pragma Import (Ada, E023, "system__exception_table_E");
   E126 : Short_Integer; pragma Import (Ada, E126, "ada__io_exceptions_E");
   E087 : Short_Integer; pragma Import (Ada, E087, "ada__tags_E");
   E125 : Short_Integer; pragma Import (Ada, E125, "ada__streams_E");
   E052 : Short_Integer; pragma Import (Ada, E052, "interfaces__c_E");
   E025 : Short_Integer; pragma Import (Ada, E025, "system__exceptions_E");
   E141 : Short_Integer; pragma Import (Ada, E141, "system__file_control_block_E");
   E136 : Short_Integer; pragma Import (Ada, E136, "system__file_io_E");
   E128 : Short_Integer; pragma Import (Ada, E128, "system__finalization_root_E");
   E123 : Short_Integer; pragma Import (Ada, E123, "ada__finalization_E");
   E071 : Short_Integer; pragma Import (Ada, E071, "system__task_info_E");
   E017 : Short_Integer; pragma Import (Ada, E017, "system__secondary_stack_E");
   E105 : Short_Integer; pragma Import (Ada, E105, "system__tasking__initialization_E");
   E006 : Short_Integer; pragma Import (Ada, E006, "ada__real_time_E");
   E132 : Short_Integer; pragma Import (Ada, E132, "ada__text_io_E");
   E115 : Short_Integer; pragma Import (Ada, E115, "system__tasking__protected_objects_E");
   E119 : Short_Integer; pragma Import (Ada, E119, "system__tasking__protected_objects__entries_E");
   E113 : Short_Integer; pragma Import (Ada, E113, "system__tasking__queuing_E");
   E150 : Short_Integer; pragma Import (Ada, E150, "system__tasking__stages_E");
   E152 : Short_Integer; pragma Import (Ada, E152, "token_ring_E");
   E142 : Short_Integer; pragma Import (Ada, E142, "linked_list_E");

   Local_Priority_Specific_Dispatching : constant String := "";
   Local_Interrupt_States : constant String := "";

   Is_Elaborated : Boolean := False;

   procedure finalize_library is
   begin
      E119 := E119 - 1;
      declare
         procedure F1;
         pragma Import (Ada, F1, "system__tasking__protected_objects__entries__finalize_spec");
      begin
         F1;
      end;
      E132 := E132 - 1;
      declare
         procedure F2;
         pragma Import (Ada, F2, "ada__text_io__finalize_spec");
      begin
         F2;
      end;
      declare
         procedure F3;
         pragma Import (Ada, F3, "system__file_io__finalize_body");
      begin
         E136 := E136 - 1;
         F3;
      end;
      declare
         procedure Reraise_Library_Exception_If_Any;
            pragma Import (Ada, Reraise_Library_Exception_If_Any, "__gnat_reraise_library_exception_if_any");
      begin
         Reraise_Library_Exception_If_Any;
      end;
   end finalize_library;

   procedure adafinal is
      procedure s_stalib_adafinal;
      pragma Import (C, s_stalib_adafinal, "system__standard_library__adafinal");

      procedure Runtime_Finalize;
      pragma Import (C, Runtime_Finalize, "__gnat_runtime_finalize");

   begin
      if not Is_Elaborated then
         return;
      end if;
      Is_Elaborated := False;
      Runtime_Finalize;
      s_stalib_adafinal;
   end adafinal;

   type No_Param_Proc is access procedure;

   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");
      Time_Slice_Value : Integer;
      pragma Import (C, Time_Slice_Value, "__gl_time_slice_val");
      WC_Encoding : Character;
      pragma Import (C, WC_Encoding, "__gl_wc_encoding");
      Locking_Policy : Character;
      pragma Import (C, Locking_Policy, "__gl_locking_policy");
      Queuing_Policy : Character;
      pragma Import (C, Queuing_Policy, "__gl_queuing_policy");
      Task_Dispatching_Policy : Character;
      pragma Import (C, Task_Dispatching_Policy, "__gl_task_dispatching_policy");
      Priority_Specific_Dispatching : System.Address;
      pragma Import (C, Priority_Specific_Dispatching, "__gl_priority_specific_dispatching");
      Num_Specific_Dispatching : Integer;
      pragma Import (C, Num_Specific_Dispatching, "__gl_num_specific_dispatching");
      Main_CPU : Integer;
      pragma Import (C, Main_CPU, "__gl_main_cpu");
      Interrupt_States : System.Address;
      pragma Import (C, Interrupt_States, "__gl_interrupt_states");
      Num_Interrupt_States : Integer;
      pragma Import (C, Num_Interrupt_States, "__gl_num_interrupt_states");
      Unreserve_All_Interrupts : Integer;
      pragma Import (C, Unreserve_All_Interrupts, "__gl_unreserve_all_interrupts");
      Detect_Blocking : Integer;
      pragma Import (C, Detect_Blocking, "__gl_detect_blocking");
      Default_Stack_Size : Integer;
      pragma Import (C, Default_Stack_Size, "__gl_default_stack_size");
      Leap_Seconds_Support : Integer;
      pragma Import (C, Leap_Seconds_Support, "__gl_leap_seconds_support");

      procedure Runtime_Initialize (Install_Handler : Integer);
      pragma Import (C, Runtime_Initialize, "__gnat_runtime_initialize");

      Finalize_Library_Objects : No_Param_Proc;
      pragma Import (C, Finalize_Library_Objects, "__gnat_finalize_library_objects");
   begin
      if Is_Elaborated then
         return;
      end if;
      Is_Elaborated := True;
      Main_Priority := -1;
      Time_Slice_Value := -1;
      WC_Encoding := 'b';
      Locking_Policy := ' ';
      Queuing_Policy := ' ';
      Task_Dispatching_Policy := ' ';
      System.Restrictions.Run_Time_Restrictions :=
        (Set =>
          (False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           False, False, False, False, False, False, False, False, 
           True, False, False, False, False, False, False, False, 
           False, False, False, False, False, False),
         Value => (0, 0, 0, 0, 0, 0, 0, 0, 0, 0),
         Violated =>
          (False, False, False, True, True, False, False, False, 
           False, False, False, True, True, True, False, False, 
           True, False, False, True, True, False, True, True, 
           False, True, True, True, True, False, False, True, 
           False, True, False, False, True, False, False, False, 
           False, True, False, False, False, True, False, False, 
           True, True, False, False, True, False, True, False, 
           True, False, True, True, True, False, False, True, 
           False, False, True, False, True, True, False, True, 
           True, True, False, True, False, False, False, False, 
           False, True, True, False, False, False),
         Count => (0, 0, 0, 0, 0, 2, 1, 0, 0, 0),
         Unknown => (False, False, False, False, False, False, True, False, False, False));
      Priority_Specific_Dispatching :=
        Local_Priority_Specific_Dispatching'Address;
      Num_Specific_Dispatching := 0;
      Main_CPU := -1;
      Interrupt_States := Local_Interrupt_States'Address;
      Num_Interrupt_States := 0;
      Unreserve_All_Interrupts := 0;
      Detect_Blocking := 0;
      Default_Stack_Size := -1;
      Leap_Seconds_Support := 0;

      Runtime_Initialize (1);

      Finalize_Library_Objects := finalize_library'access;

      System.Soft_Links'Elab_Spec;
      System.Exception_Table'Elab_Body;
      E023 := E023 + 1;
      Ada.Io_Exceptions'Elab_Spec;
      E126 := E126 + 1;
      Ada.Tags'Elab_Spec;
      Ada.Streams'Elab_Spec;
      E125 := E125 + 1;
      Interfaces.C'Elab_Spec;
      System.Exceptions'Elab_Spec;
      E025 := E025 + 1;
      System.File_Control_Block'Elab_Spec;
      E141 := E141 + 1;
      System.Finalization_Root'Elab_Spec;
      E128 := E128 + 1;
      Ada.Finalization'Elab_Spec;
      E123 := E123 + 1;
      System.Task_Info'Elab_Spec;
      E071 := E071 + 1;
      System.File_Io'Elab_Body;
      E136 := E136 + 1;
      E052 := E052 + 1;
      Ada.Tags'Elab_Body;
      E087 := E087 + 1;
      System.Soft_Links'Elab_Body;
      E013 := E013 + 1;
      System.Os_Lib'Elab_Body;
      E138 := E138 + 1;
      System.Secondary_Stack'Elab_Body;
      E017 := E017 + 1;
      System.Tasking.Initialization'Elab_Body;
      E105 := E105 + 1;
      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E006 := E006 + 1;
      Ada.Text_Io'Elab_Spec;
      Ada.Text_Io'Elab_Body;
      E132 := E132 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E115 := E115 + 1;
      System.Tasking.Protected_Objects.Entries'Elab_Spec;
      E119 := E119 + 1;
      System.Tasking.Queuing'Elab_Body;
      E113 := E113 + 1;
      System.Tasking.Stages'Elab_Body;
      E150 := E150 + 1;
      E152 := E152 + 1;
      Linked_List'Elab_Spec;
      E142 := E142 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_token_ring_test");

   function main
     (argc : Integer;
      argv : System.Address;
      envp : System.Address)
      return Integer
   is
      procedure Initialize (Addr : System.Address);
      pragma Import (C, Initialize, "__gnat_initialize");

      procedure Finalize;
      pragma Import (C, Finalize, "__gnat_finalize");
      SEH : aliased array (1 .. 2) of Integer;

      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      gnat_argc := argc;
      gnat_argv := argv;
      gnat_envp := envp;

      Initialize (SEH'Address);
      adainit;
      Ada_Main_Program;
      adafinal;
      Finalize;
      return (gnat_exit_status);
   end;

--  BEGIN Object file/option list
   --   /home/mliyanagamage/Documents/ada/Token_Rings/Objects/token_ring.o
   --   /home/mliyanagamage/Documents/ada/Token_Rings/Objects/linked_list.o
   --   /home/mliyanagamage/Documents/ada/Token_Rings/Objects/token_ring_test.o
   --   -L/home/mliyanagamage/Documents/ada/Token_Rings/Objects/
   --   -L/home/mliyanagamage/Documents/ada/Token_Rings/Objects/
   --   -L/usr/gnat/lib/gcc/x86_64-pc-linux-gnu/4.9.3/adalib/
   --   -static
   --   -lgnarl
   --   -lgnat
   --   -lpthread
   --   -lrt
--  END Object file/option list   

end ada_main;
