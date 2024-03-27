with Ada.Strings.Unbounded; use Ada.Strings.Unbounded;
with Interfaces.C.Strings; use Interfaces.C.Strings;

package body Message is
    type Message_Array is array (Message_Kind) of Unbounded_String;

    Messages: constant Message_Array := [
       Who     => To_Unbounded_String("Who are you?" & ASCII.CR & ASCII.LF),
       Hello   => To_Unbounded_String("Hello from Ada, %s" & ASCII.CR & ASCII.LF),
       Goodbye => To_Unbounded_String("Goodbye, %s" & ASCII.CR & ASCII.LF)
    ];

    function Get_Message(Kind : Message_Kind) return Char_Array is
    begin
        return To_C(To_String(Messages(Kind)));
    end;

    procedure C_Puts(Str: Chars_Ptr)
      with
        Import        => True,
        Convention    => C,
        External_Name => "c_puts";

    function C_Int_Str(Value: int) return Chars_Ptr
      with
        Import        => True,
        Convention    => C,
        External_Name => "c_int_str";

    function C_UInt_Str(Value: unsigned) return Chars_Ptr
      with
        Import        => True,
        Convention    => C,
        External_Name => "c_uint_str";

    type Color is record
        r: unsigned_char;
        g: unsigned_char;
        b: unsigned_char;
        a: unsigned_char;
    end record
        with Convention => C_Pass_By_Copy;

    function Get_Color(hexValue: unsigned) return Color
        with
            Import => True,
            Convention => C,
            External_Name => "GetColor";
    function Color_To_Int(C: Color) return unsigned
        with
            Import => True,
            Convention => C,
            External_Name => "ColorToInt";

    type Addr is mod 2 ** Standard'Address_Size;
    type Image is record
        Data: Addr;
        Width: int;
        Height: int;
        Mipmaps: int;
        Format: int;
    end record
        with Convention => C_Pass_By_Copy;
    function Load_Image(File_Name: Char_Array) return Image
        with
            Import => True,
            Convention => C,
            External_Name => "LoadImage";

    procedure DoStuff is
        C: constant Color := Get_Color(16#12345678#);
        S: Chars_Ptr := New_String(C'Image);
        I: unsigned := Color_To_Int(C);
        U: Chars_Ptr := C_UInt_Str(I);
        T: Chars_Ptr := New_String(Get_Color(I)'Image);
        K: Chars_Ptr := New_String(Load_Image(To_C("image.png"))'Image);
    begin
        C_Puts(U);
        C_Puts(S);
        C_Puts(T);
        C_Puts(K);
        Free(S);
        Free(T);
        Free(K);
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
