-- Der Zuweisungsoperator fuer ein Signal lautet: <=
-- The assignment operator for a signal is: <=
--
-- In VHDL werden Signale mit dem Operator "<=" zugewiesen.
-- Signalzuweisungen sind nebenläufig (concurrent) und werden
-- nach einer Delta-Verzögerung wirksam.

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity signal_assignment is
    port (
        a : in  STD_LOGIC;
        b : in  STD_LOGIC;
        y : out STD_LOGIC
    );
end entity signal_assignment;

architecture Behavioral of signal_assignment is
    signal intern : STD_LOGIC;
begin
    -- Signalzuweisung mit dem Operator <=
    intern <= a AND b;
    y      <= intern;
end architecture Behavioral;
