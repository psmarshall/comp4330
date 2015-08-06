--
-- Uwe R. Zimmer, Australia, 2014
--

generic

   Modulo : Positive;

package Modulo_Type_Generic is

   subtype Mod_Type is Natural range 0 .. Modulo - 1;

   function Add_Mod (Left, Right : Mod_Type)           return Mod_Type is ((Left +  Right) mod Modulo);
   function Sub_Mod (Left, Right : Mod_Type)           return Mod_Type is ((Left -  Right) mod Modulo);
   function Mul_Mod (Left, Right : Mod_Type)           return Mod_Type is ((Left *  Right) mod Modulo);
   function Div_Mod (Left, Right : Mod_Type)           return Mod_Type is ((Left /  Right) mod Modulo);
   function Pow_Mod (Left : Mod_Type; Right : Natural) return Mod_Type is ((Left ** Right) mod Modulo);

   function "+"  (Left, Right : Mod_Type)           return Mod_Type renames Add_Mod;
   function "-"  (Left, Right : Mod_Type)           return Mod_Type renames Sub_Mod;
   function "*"  (Left, Right : Mod_Type)           return Mod_Type renames Mul_Mod;
   function "/"  (Left, Right : Mod_Type)           return Mod_Type renames Div_Mod;
   function "**" (Left : Mod_Type; Right : Natural) return Mod_Type renames Pow_Mod;

end Modulo_Type_Generic;
