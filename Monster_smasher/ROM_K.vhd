
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE ieee.numeric_std.ALL;

entity ROM_K is
Port ( 
    Address_in : in std_logic_vector(5 downto 0);
    Data_out : out std_logic_vector(31 downto 0)
);
end ROM_K;

architecture Behavioral of ROM_K is

    --signal Data_int : std_logic_vector(31 downto 0);
    signal Memory : std_logic_vector((32*64)-1 downto 0) := x"c67178f2bef9a3f7a4506ceb90befffa8cc7020884c8781478a5636f748f82ee682e6ff35b9cca4f4ed8aa4a391c0cb334b0bcb52748774c1e376c0819a4c116106aa070f40e3585d6990624d192e819c76c51a3c24b8b70a81a664ba2bfe8a192722c8581c2c92e766a0abb650a735453380d134d2c6dfc2e1b213827b70a851429296706ca6351d5a79147c6e00bf3bf597fc7b00327c8a831c66d983e515276f988da5cb0a9dc4a7484aa2de92c6f240ca1cc0fc19dc6efbe4786e49b69c1c19bf1749bdc06a780deb1fe72be5d74550c7dc3243185be12835b01d807aa98ab1c5ed5923f82a459f111f13956c25be9b5dba5b5c0fbcf71374491428a2f98";

begin

   --Data_out <= Memory(32*to_integer(unsigned(Address_in)+1)-1 downto 32*to_integer(unsigned(Address_in)));
   Data_out <= Memory(32*to_integer(unsigned(Address_in))-1+32 downto 32*to_integer(unsigned(Address_in)));

end Behavioral;
