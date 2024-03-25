with Interfaces.C; use Interfaces.C;
with Ada.Containers.Vectors;

package Message is
    type Message_Kind is (Who, Hello, Goodbye)
      with Convention => C;
              
    function Get_Message (Kind : Message_Kind) return Char_Array
      with
        Export        => True,
        Convention    => C,
        External_Name => "get_message";

    procedure Push(Value: int) 
      with
        Export        => True,
        Convention    => C,
        External_Name => "push";
        
    function Pop return int
      with
        Export        => True,
        Convention    => C,
        External_Name => "pop";
end Message;
