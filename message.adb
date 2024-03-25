with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;

package body Message is
    type Message_Array is array (Message_Kind) of Unbounded_String;
    
    Messages: constant Message_Array := [
       Who     => To_Unbounded_String("Who are you?" & ASCII.CR & ASCII.LF),
       Hello   => To_Unbounded_String("Hello from Ada, %s" & ASCII.CR & ASCII.LF),
       Goodbye => To_Unbounded_String("Goodbye, %s" & ASCII.CR & ASCII.LF)
    ];    
    
    function Get_Message (Kind : Message_Kind) return Char_Array is 
    begin
        return To_C(To_String(Messages(Kind)));
    end;
    
    package Queue is new
      Ada.Containers.Vectors(Index_Type => Natural, Element_Type => int);
    
    Q: Queue.Vector;
    use Ada.Containers;
      
    procedure Push(Value: int) is
    begin
        Q.Append(Value);
    end;
        
    function Pop return int is
      Value: constant int := Q.Last_Element;
    begin
        Q.Delete_Last;
        return Value;
    end;
    
end Message;
