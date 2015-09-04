--
-- Uwe R. Zimmer, Australia, 2013
--
--
-- Synopsis: Bundles individual atomic action parts
--           and provides a single procedure to perform the atomic action.
--
--
-- Atomic actions are indivisible and and instantaneous. In case of
-- an atomic action, which consists itself of multiple concurrent parts,
-- some support for these conditions are provided here:
-- Either
--     - the full set of concurrent parts is completing their
--       action-part fully and without timing violations or other exceptions
--    or
--     - all parts of the action are executing a cleanup procedure to
--       restore the initial state (in case that any part of the action
--       was not able to complete fully) - regardless whether they completed
--       their action-part fully or to some extend, or whether they have
--       not even started executing it.
--
-- Each concurrent part of the atomic action is defined by:
--
--  (see also the definitions in atomic_action_types.ads)
--
--   1. A minimal and maximal delay after which this part
--      of the atomic action is started. First this part is delayed
--      by the minimal delay time. Then, if the action-part is not active
--      after the maximal delay time, the whole action is stopped.
--
--   2. This local action-part is started.
--
--   3. If this action-part is not completed before the maximal elapse time
--      (starting with the actual activation of the task, after the delay)
--      and before the absolute deadline, the whole action is stopped.
--
--   4. If this action-part is exiting with any exception, the whole
--      action is stopped.
--
--   5. If the whole action is stopped, each part excecutes its 'cleanup'
--      procedure, in order to fully restore the initial state.
--
-- All parts are blocked until either every part has completed its
-- action-part or every part (in case of a stopped action) has completed
-- its 'cleanup' procedure. Therefore the atomic action can only be completed
-- with all part successfully completed, or reset to the initial state.
--
-- The final state of the atomic action is determined and exceptions are
-- propagated in case the atomic action was not successfully completed.
-- Timing violations are indicated with specific exceptions. All other
-- exceptions are propagated as the 'Failure_State' exception.
--
------------------------------------------------------------------

with Generic_Atomic_Action_Types;

generic
   with package Atomic_Action_Types is new Generic_Atomic_Action_Types (<>);

   Actions : Atomic_Action_Types.Action_Parts;

package Generic_Atomic_Action is

   --
   -- Perform the atomic action
   --

   procedure Perform;

   procedure Init_Tasks;

end Generic_Atomic_Action;
