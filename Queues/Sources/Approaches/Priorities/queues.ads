--
-- Uwe R. Zimmer, Australia, 2014
--

pragma Initialize_Scalars;

generic

   type Element is private;
   type Index   is mod <>;  -- Modulo defines size of the queue.

   type Queue_Enum is (<>); -- Allows for multiple readers without loosing items.

package Queues is

   type Queue_Type is limited private;

   protected type Protected_Queue is

      --------------------------------------------------------------------------
      --
      -- Order of processing:
      --
      -- 1. Enqueue takes priority over Dequeue.
      -- 2. Dequeues with higher Queue_Enum values take priority over
      --    Dequeues with lower Queue_Enum values.
      -- 3. Internal progress first rule guarantees fairness
      --    (no task is served twice while another servicable task is blocked).
      --
      --------------------------------------------------------------------------

      entry Enqueue_For_All (Item :     Element);

      entry Dequeue_For_All (Item : out Element);

      entry Dequeue (Queue_Enum) (Item : out Element);

      function Is_Empty                       return Boolean;
      function Is_Empty  (Q     : Queue_Enum) return Boolean;
      function Is_Full                        return Boolean;
      function Length                         return Natural;
      function Length    (Q     : Queue_Enum) return Natural;
      function Lookahead (Depth : Index)      return Element;
      function Lookahead (Q     : Queue_Enum;
                          Depth : Index)      return Element;

   private

      Queue : Queue_Type;

   end Protected_Queue;

private
   type Markers is array (Queue_Enum) of Index;

   type Readouts is array (Queue_Enum) of Boolean;
   All_Read  : constant Readouts := (others => True);
   None_Read : constant Readouts := (others => False);

   type Element_and_Readouts is record
      Elem  : Element; -- Initialized to invalids
      Reads : Readouts := All_Read;
   end record;
   type List is array (Index) of Element_and_Readouts;

   type Queue_Type is record
      Free,
      Top      : Index   := Index'First;
      Readers  : Markers := (others => Index'First);
      Elements : List;
   end record;

end Queues;
