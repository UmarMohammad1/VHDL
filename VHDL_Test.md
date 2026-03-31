# VHDL Test – Fragenkatalog mit Lösungen

> **Lernmaterialien:** VHDL-Skript (VHDLVers0.0063.pdf, Prof. Edmund Coersmeier, HS Bochum) und Übungsblätter 1–8.
> Lösungsquelle wird jeweils angegeben:
> - **AUS SKRIPT** = Lösung direkt aus dem Vorlesungsskript
> - **AUS DEM INTERNET** = Lösung aus zuverlässigen VHDL-Quellen (IEEE-Standard, VHDL-Whiz, All About Circuits, u.ä.)

---

## Kapitel 1 – Grundlagen und Eigenschaften von VHDL

---

### Frage 1.1
**Was ist VHDL und wozu wird es eingesetzt?**

> **AUS SKRIPT**
>
> VHDL steht für **Very High Speed Integrated Circuit Hardware Description Language**. Es ist eine Hardwarebeschreibungssprache, die zum Entwurf synthesefähiger Digitalschaltungen verwendet wird. Im Gegensatz zu normalen Programmiersprachen (wie C oder Python) entsteht durch VHDL-Code kein direkt ausführbares Programm. Eine VHDL-Beschreibung ist nur im Zusammenhang mit einem Logiksimulator (Testumgebung) verifizierbar und mit einem Synthese-Tool und FPGA-Hardware realisierbar.

---

### Frage 1.2
**Welche besonderen Eigenschaften hat VHDL im Vergleich zu herkömmlichen Programmiersprachen?**

> **AUS SKRIPT**
>
> VHDL enthält neben den aus normalen Programmiersprachen bekannten Konzepten (Datentypen, Kontrollstrukturen, Prozeduren) auch Konzepte, die die speziellen Eigenschaften von Hardware reflektieren. Die Syntax ist ähnlich zu ADA. VHDL kann **Parallelität** sehr gut darstellen – mehrere Prozesse laufen gleichzeitig ab, was dem realen Verhalten von Hardware entspricht.

---

### Frage 1.3
**Was ist der Unterschied zwischen ASIC und FPGA?**

> **AUS SKRIPT**
>
> - **ASIC** (Application-Specific Integrated Circuit): Schaltkreis, der für eine spezifische Anwendung hergestellt wird. Einmal gefertigt, nicht mehr veränderbar. Höhere Performance, geringere Kosten bei großen Stückzahlen.
> - **FPGA** (Field-Programmable Gate Array): Programmierbarer Logikbaustein, der nach der Fertigung konfiguriert werden kann. Flexibel, ideal für Prototypen und kleine Serien. In der Vorlesung wird Xilinx Vivado als Entwicklungstool verwendet.

---

## Kapitel 2 – Entity und Architecture

---

### Frage 2.1
**Was ist eine Entity in VHDL und was beschreibt sie?**

> **AUS SKRIPT**
>
> Die **Entity** beschreibt die Schnittstelle eines VHDL-Designs nach außen (vergleichbar mit einer Black-Box). Sie definiert die Ein- und Ausgangsports des Designs. Ein reales System verfügt über:
> - Schnittstellen nach außen → **Entity**
> - interne Realisierung → **Architecture**

---

### Frage 2.2
**Schreiben Sie die VHDL-Syntax einer Entity mit folgenden Ports:**
- `Clk`, `Reset`: IN, std_logic
- `A`, `B`: IN, std_logic
- `SigOut`: OUT, std_logic

> **AUS SKRIPT**
>
> ```vhdl
> library IEEE;
> use IEEE.std_logic_1164.all;
>
> entity mein_design is
>     port (
>         Clk    : in  std_logic;
>         Reset  : in  std_logic;
>         A      : in  std_logic;
>         B      : in  std_logic;
>         SigOut : out std_logic
>     );
> end entity mein_design;
> ```

---

### Frage 2.3
**Was ist eine Architecture in VHDL und wie ist ihre Syntax aufgebaut?**

> **AUS SKRIPT**
>
> Die **Architecture** ist die eigentliche Realisierung der Entity (interne Implementierung). Zu jeder Architecture gehört genau eine Entity. Beispiel für ein NOR-Gatter:
>
> ```vhdl
> architecture a of mnor2 is
> begin
>     r <= not (a or b);
> end architecture a;
> ```
>
> Aufbau:
> 1. `architecture <Name> of <Entity-Name> is` – Kopf mit optionalen Signaldeklarationen
> 2. `begin` – Start des Architektur-Körpers
> 3. Concurrent-Statements und Prozesse
> 4. `end architecture <Name>;`

---

### Frage 2.4
**Welche Port-Modi gibt es in VHDL und was bedeuten sie?**

> **AUS SKRIPT** (reservierte Wörter)
>
> | Modus   | Bedeutung                                      |
> |---------|------------------------------------------------|
> | `in`    | Eingabeparameter, wird nur gelesen             |
> | `out`   | Ausgabeparameter, wird berechnet/ausgegeben    |
> | `inout` | Bidirektional: Eingang und Ausgang             |

---

### Frage 2.5
**Welche Bibliotheken müssen in der Regel in einem VHDL-Design eingebunden werden?**

> **AUS SKRIPT**
>
> Für die Verwendung von `std_logic` und `std_logic_vector` muss folgendes eingebunden werden:
> ```vhdl
> library IEEE;
> use IEEE.std_logic_1164.all;
> use IEEE.std_logic_unsigned.all;   -- oder besser:
> use IEEE.NUMERIC_STD.ALL;          -- IEEE-standardisiert
> ```
> Es gibt zwei Standardbibliotheken:
> - **WORK**: Default-Bibliothek des Benutzers
> - **STD**: enthält die Packages STANDARD und TEXTIO mit vordefinierten Datentypen und Funktionen

---

## Kapitel 3 – Datentypen

---

### Frage 3.1
**Welche Datentypen sind synthesefähig und welche nur für die Simulation?**

> **AUS SKRIPT**
>
> **Synthesefähig:**
> - `integer`
> - `std_logic`
> - `std_logic_vector`
> - `time` (nur eingeschränkt)
>
> **Nicht synthesefähig (nur Simulation):**
> - `real`
> - `string`

---

### Frage 3.2
**Was ist der Unterschied zwischen `bit`/`bit_vector` und `std_logic`/`std_logic_vector`?**

> **AUS SKRIPT**
>
> - `bit` ist **zweiwertig** (0 oder 1)
> - `std_logic` ist **neunwertig** (nach IEEE 1164) und heute faktisch Industrie-Standard
> - In der Vorlesung wird **immer** `std_logic` und `std_logic_vector` verwendet, niemals `bit`/`bit_vector`
>
> Die 9 Zustände von `std_logic` (IEEE 1164):
> | Kürzel | Bedeutung         |
> |--------|-------------------|
> | `U`    | Uninitialized     |
> | `X`    | Forcing Unknown   |
> | `0`    | Forcing 0         |
> | `1`    | Forcing 1         |
> | `Z`    | High Impedance    |
> | `W`    | Weak Unknown      |
> | `L`    | Weak 0            |
> | `H`    | Weak 1            |
> | `D`    | Don't Care        |

---

### Frage 3.3
**Wie wird der Datentyp `integer` in VHDL deklariert und wofür wird er verwendet?**

> **AUS SKRIPT**
>
> Integer-Typen verarbeiten nur **ganze Zahlen**. Mit einem Range-Constraint wird der Wertebereich festgelegt:
> ```vhdl
> type short_int    is range 0 to 7;
> type day_of_month is range 0 to 31;
> type liste        is range 15 downto -16;
> ```
>
> Operatoren auf Integer-Typen: `+`, `-`, `*`, `/`, `mod`, `rem`, `abs`
>
> **Empfehlung aus dem Skript:** Für mathematische Berechnungen in VHDL sollte **vornehmlich mit Integers** gerechnet werden. `std_logic` und `std_logic_vector` sind für Ports und digitale Bussysteme gedacht, nicht für Berechnungen.

---

### Frage 3.4
**Wie konvertiert man einen `integer` in einen `std_logic_vector` und umgekehrt?**

> **AUS SKRIPT**
>
> Mit dem Package `IEEE.NUMERIC_STD.ALL`:
>
> **INTEGER → STD_LOGIC_VECTOR (unsigned):**
> ```vhdl
> signal input_1   : integer;
> signal output_1a : std_logic_vector(3 downto 0);
> output_1a <= std_logic_vector(to_unsigned(input_1, output_1a'length));
> ```
>
> **INTEGER → STD_LOGIC_VECTOR (signed):**
> ```vhdl
> output_1b <= std_logic_vector(to_signed(input_1, output_1b'length));
> ```
>
> **STD_LOGIC_VECTOR → INTEGER (unsigned):**
> ```vhdl
> signal input_4   : std_logic_vector(3 downto 0);
> signal output_4a : integer;
> output_4a <= to_integer(unsigned(input_4));
> ```
>
> **STD_LOGIC_VECTOR → INTEGER (signed):**
> ```vhdl
> output_4b <= to_integer(signed(input_4));
> ```

---

### Frage 3.5
**Welche Konvertierungsfunktionen gibt es für `integer`, `signed`, `unsigned` und `std_logic_vector`?**

> **AUS SKRIPT**
>
> | Von → Nach                        | Funktion                                         |
> |-----------------------------------|--------------------------------------------------|
> | `integer` → `signed`              | `to_signed(input, output'length)`                |
> | `integer` → `unsigned`            | `to_unsigned(input, output'length)`              |
> | `std_logic_vector` → `signed`     | `signed(input)`                                  |
> | `std_logic_vector` → `unsigned`   | `unsigned(input)`                                |
> | `signed` → `integer`              | `to_integer(input)`                              |
> | `signed` → `std_logic_vector`     | `std_logic_vector(input)`                        |
> | `integer` → `std_logic_vector`    | `std_logic_vector(to_unsigned(input, length))`   |
> | `std_logic_vector` → `integer`    | `to_integer(unsigned(input))`                    |

---

## Kapitel 4 – Signale und Variablen

---

### Frage 4.1
**Was ist der Unterschied zwischen einem Signal und einer Variable in VHDL?**

> **AUS SKRIPT**
>
> | Eigenschaft              | Signal                                           | Variable                                  |
> |--------------------------|--------------------------------------------------|-------------------------------------------|
> | Zuweisungsoperator       | `<=`                                             | `:=`                                      |
> | Gültigkeitsbereich       | Zwischen Prozessen, global in der Architecture   | Nur prozessintern (lokaler Speicher)      |
> | Wertübernahme            | Am Ende des Prozesses (gleichzeitig)             | Sofort (unmittelbar)                      |
> | FlipFlop-Erzeugung       | In synchronem Prozess: immer ein FF/Register     | Typischerweise kombinatorische Logik      |
>
> **Wichtige Regel:** Variablen erzeugen **typischerweise keine Register/FlipFlops**. Falls eine Variable vor der ersten Zuweisung auf der rechten Seite verwendet wird, entsteht ein Latch/Register (unerwünschtes Verhalten!).

---

### Frage 4.2
**Wann und warum sollten Variablen in VHDL verwendet werden?**

> **AUS SKRIPT**
>
> Variablen sind sinnvoll, wenn:
> - Komplexe Berechnungen Schritt für Schritt durchgeführt werden sollen, ohne für jeden Zwischenschritt ein separates Signal anlegen zu müssen
> - Unübersichtlichkeit bei langen Klammerausdrücken vermieden werden soll
> - Am Schluss wird das Ergebnis auf ein Signal (das dann das Register bildet) zugewiesen
>
> **Tipp aus dem Skript:** Versuche zuerst, die Aufgabe mit Signalen zu lösen. Wenn Variablen notwendig sind, so verwende sie. Was mit Signalen nicht synthetisierbar ist, geht auch mit Variablen nicht.

---

### Frage 4.3
**Wie unterscheiden sich Signale innerhalb und außerhalb eines synchronen Prozesses?**

> **AUS SKRIPT**
>
> - **Im synchronen Prozess:** Jede Signalzuweisung erzeugt ein FlipFlop/Register
> - **Außerhalb des synchronen Prozesses (oder in asynchronem Prozess):** Signale dienen als elektrische Verbindungen (kombinatorische Logik), es entstehen **keine** FlipFlops
>
> Um die Anzahl der Register zu reduzieren, können Zwischenberechnungen in einem **asynchronen Prozess** oder mit **Variablen** im synchronen Prozess durchgeführt werden.

---

### Frage 4.4
**Was ist der Unterschied zwischen einem synchronen und einem asynchronen Reset?**

> **AUS SKRIPT**
>
> | Reset-Typ        | Beschreibung                                           | Sensitivity-Liste    |
> |------------------|--------------------------------------------------------|----------------------|
> | Asynchroner Reset| Reset wird sofort ausgeführt, unabhängig vom Takt      | `Reset, Clk`         |
> | Synchroner Reset | Reset wird erst nach der nächsten Taktflanke wirksam   | nur `Clk`            |
>
> **Empfehlung aus dem Skript:** In der Vorlesung wird ausschließlich der **asynchrone Reset** favorisiert, da er immer funktioniert und **nie** die kombinatorische Logik beeinflusst.

---

### Frage 4.5
**Wie schreibt man einen synchronen Prozess mit asynchronem Reset in VHDL (mit `rising_edge`)?**

> **AUS SKRIPT**
>
> ```vhdl
> process(Reset, Clk)
> begin
>     if Reset = '0' then           -- asynchroner Reset, aktiv low
>         DataOut <= (others => '0');
>     elsif rising_edge(Clk) then   -- steigende Taktflanke
>         DataOut <= DataIn;
>     end if;
> end process;
> ```
>
> **Hinweis:** Es gibt zwei Schreibweisen für die steigende Taktflanke:
> - `Clk'event and Clk = '1'` → traditionell (seit den 1990ern)
> - `rising_edge(Clk)` → modern (seit ca. VHDL-2002), wird in der Vorlesung bevorzugt

---

### Frage 4.6
**Wie viele FlipFlops erzeugt ein synchroner Prozess mit 3 Signalzuweisungen?**

> **AUS SKRIPT**
>
> Jede **Signalzuweisung** in einem synchronen Prozess erzeugt genau **ein FlipFlop/Register** (bei 1 Bit) bzw. ein n-Bit-Register (bei einem `std_logic_vector(n-1 downto 0)`).
>
> Beispiel:
> ```vhdl
> process(Reset, Clk)
> begin
>     if Reset = '0' then
>         E1 <= '0'; E2 <= '0'; DataOut <= '0';
>     elsif rising_edge(Clk) then
>         E1 <= A xor B;        -- erzeugt 1 FlipFlop
>         E2 <= E1 and (A or B); -- erzeugt 1 FlipFlop
>         DataOut <= E2;        -- erzeugt 1 FlipFlop
>     end if;
> end process;
> ```
> → 3 FlipFlops werden erzeugt

---

## Kapitel 5 – Prozesse und RTL-Design

---

### Frage 5.1
**Was ist RTL-Design (Register Transfer Level)?**

> **AUS SKRIPT**
>
> RTL steht für **Register Transfer Level**. Es beschreibt den Entwurf kombinatorischer und sequentieller Logik für die Synthese in ASIC- oder FPGA-Bausteinen. Das Prinzip:
>
> `Sequentielle Logik` → `Kombinatorische Logik` → `Sequentielle Logik`
>
> (Register → kombinatorische Verknüpfungen → Register)

---

### Frage 5.2
**Was ist eine Sensitivity-List und welche Signale gehören hinein?**

> **AUS SKRIPT**
>
> Die Sensitivity-List legt fest, welche Signale den Prozess aktivieren (triggern). Bei einer **Änderung** eines Signals in der Sensitivity-List wird der gesamte Prozess ausgeführt.
>
> **Regeln:**
> - **Synchroner Prozess:** Sensitivity-List enthält `Reset` und `Clk` (bei asynchronem Reset)
> - **Synchroner Prozess (synchroner Reset):** Nur `Clk` in der Sensitivity-List
> - **Asynchroner Prozess:** Alle Signale, die auf der **rechten Seite** der Zuweisungen vorkommen (außer Clk und Reset)
>
> Die Reihenfolge der Signale in der Sensitivity-List ist irrelevant.

---

### Frage 5.3
**Was ist der Unterschied zwischen einem synchronen und einem asynchronen Prozess?**

> **AUS SKRIPT**
>
> | Eigenschaft            | Synchroner Prozess                         | Asynchroner Prozess                         |
> |------------------------|--------------------------------------------|---------------------------------------------|
> | Aktivierung            | Durch Taktflanke (rising_edge)             | Durch Änderung beliebiger Eingangssignale   |
> | Register-Erzeugung     | Ja, für jede Signalzuweisung               | Nein, erzeugt kombinatorische Logik         |
> | Sensitivity-List       | `Reset, Clk` (oder nur `Clk`)              | Alle rechts verwendeten Signale             |
> | Reset-Wert             | Ja, im Reset-Zweig definiert               | Kein Reset-Wert notwendig                   |

---

### Frage 5.4
**Was ist der Unterschied zwischen `wait until rising_edge(Clk)` und einer Sensitivity-List?**

> **AUS SKRIPT**
>
> - **Sensitivity-List:** wird in RTL-Designs verwendet (`process(Reset, Clk)`)
> - **WAIT-Anweisungen:** gerne in **Testbenches** verwenden
>
> In RTL-Designs (synthesefähiger Code) sollte **immer die Sensitivity-List** verwendet werden, nie `wait`-Anweisungen im Synthesepfad.

---

### Frage 5.5
**Welche VHDL-Codezeilen aus Übungsblatt 1 implementieren einen synchronen Prozess mit 4 Registerstufen?**

> **AUS SKRIPT** (aus Übungsblatt 1)
>
> Gegeben ist eine Entity mit `Clk`, `Reset`, `A`, `B` (IN std_logic) und `SigOut` (OUT std_logic):
>
> ```vhdl
> library IEEE;
> use IEEE.std_logic_1164.all;
>
> entity ueb1 is
>     port (
>         Clk    : in  std_logic;
>         Reset  : in  std_logic;
>         A      : in  std_logic;
>         B      : in  std_logic;
>         SigOut : out std_logic
>     );
> end entity ueb1;
>
> architecture rtl of ueb1 is
>     signal E1, E2, E3, DataOut : std_logic;
> begin
>     process(Reset, Clk)
>     begin
>         if Reset = '0' then
>             E1      <= '0';
>             E2      <= '0';
>             E3      <= '0';
>             DataOut <= '0';
>         elsif rising_edge(Clk) then
>             E1      <= A xor B;            -- Registerstufe 1
>             E2      <= E1 and (A or B);    -- Registerstufe 2
>             E3      <= E1 or E2 xor B;     -- Registerstufe 3
>             DataOut <= E3;                 -- Registerstufe 4
>         end if;
>     end process;
>     SigOut <= DataOut;
> end architecture rtl;
> ```

---

## Kapitel 6 – Kontrollstrukturen und Operatoren

---

### Frage 6.1
**Welche logischen Operatoren gibt es in VHDL?**

> **AUS SKRIPT** (reservierte Wörter)
>
> | Operator | Bedeutung                               |
> |----------|-----------------------------------------|
> | `and`    | Logisches UND                           |
> | `or`     | Logisches ODER                          |
> | `not`    | Komplement (Negation)                   |
> | `nand`   | Negiertes UND                           |
> | `nor`    | Negiertes ODER                          |
> | `xor`    | Exklusiv-ODER                           |
> | `xnor`   | Exklusiv-NOR                            |

---

### Frage 6.2
**Wie funktioniert die `if`/`elsif`/`else`-Anweisung in VHDL? Geben Sie ein Beispiel.**

> **AUS DEM INTERNET** (IEEE VHDL Standard)
>
> Die `if`-Anweisung ist eine sequentielle Anweisung und kann nur **innerhalb eines Prozesses** verwendet werden.
>
> ```vhdl
> process(Reset, Clk)
> begin
>     if Reset = '0' then
>         DataOut <= (others => '0');
>     elsif rising_edge(Clk) then
>         if SelectIn = '1' then
>             DataOut <= DataIn1;
>         elsif SelectIn = '0' then
>             DataOut <= DataIn2;
>         else
>             DataOut <= (others => '0');
>         end if;
>     end if;
> end process;
> ```

---

### Frage 6.3
**Wie funktioniert die `case`/`when`-Anweisung in VHDL? Implementieren Sie einen 4:1-Multiplexer.**

> **AUS SKRIPT**
>
> Die `case`-Anweisung ist eine Mehrfach-Verzweigung (wie in Programmiersprachen) und wird für die Decodierung komplexer Codes bei der Hardwareumsetzung eingesetzt.
>
> ```vhdl
> process(Sel, A, B, C, D)
> begin
>     case Sel is
>         when "00"   => DataOut <= A;
>         when "01"   => DataOut <= B;
>         when "10"   => DataOut <= C;
>         when "11"   => DataOut <= D;
>         when others => DataOut <= '0';
>     end case;
> end process;
> ```

---

### Frage 6.4
**Was ist eine selektive Signalzuweisung (`with`/`select`/`when`) in VHDL?**

> **AUS SKRIPT**
>
> Die selektive Signalzuweisung ist eine **nebenläufige** (concurrent) Anweisung und steht außerhalb von Prozessen. Sie wird aktiviert, wenn sich eines der Signale der Auswahlbedingung oder der Ausdrücke auf der rechten Seite ändert.
>
> Beispiel (4:1-Mux):
> ```vhdl
> with Sel select
>     DataOut <= A when "00",
>                B when "01",
>                C when "10",
>                D when "11",
>                '0' when others;
> ```

---

### Frage 6.5
**Welche arithmetischen Operatoren sind in VHDL für Integer verfügbar?**

> **AUS SKRIPT**
>
> | Operator | Bedeutung                        |
> |----------|----------------------------------|
> | `+`      | Addition                         |
> | `-`      | Subtraktion                      |
> | `*`      | Multiplikation                   |
> | `/`      | Division (nur ganze Zahlen)      |
> | `mod`    | Modulo                           |
> | `rem`    | Remainder (Rest der Division)    |
> | `abs`    | Absolutwert                      |

---

## Kapitel 7 – Funktionen und Prozeduren

---

### Frage 7.1
**Was ist eine Funktion in VHDL und welche Eigenschaften hat sie?**

> **AUS SKRIPT**
>
> Funktionen haben in VHDL die Aufgabe, immer wiederkehrende Berechnungen, Zuweisungen und Algorithmen zur Verfügung zu stellen. Eigenschaften:
> - Können keine, eine oder mehrere Übergabeparameter haben
> - Eine Funktion gibt **immer** einen Wert zurück
> - Eine Funktion **kann keine WAIT-Anweisungen** verarbeiten
> - In der Simulation konsumiert eine Funktion keine Simulationszeit
> - Wird in die Architecture integriert, ideal für arithmetische Berechnungen

---

### Frage 7.2
**Wie ist die Syntax einer Funktion in VHDL aufgebaut?**

> **AUS SKRIPT**
>
> ```vhdl
> function <funktionsname> (<parameter1> : <typ1>; <parameter2> : <typ2>)
>     return <rückgabetyp> is
>     -- Konstanten und Variablen
>     variable result : integer;
> begin
>     -- Implementierung
>     result := parameter1 + parameter2;
>     return result;
> end function <funktionsname>;
> ```
>
> Die Funktion wird in den **deklarativen Teil** der Architecture (zwischen `is` und `begin`) geschrieben.

---

### Frage 7.3
**Implementieren Sie eine Funktion in VHDL, die Multiply-and-Add für einen FIR-Filter berechnet (aus Übungsblatt 4).**

> **AUS SKRIPT** (aus Übungsblatt 4)
>
> ```vhdl
> function mac(DataIn : integer; Coeff : integer) return integer is
>     variable result : integer;
> begin
>     result := DataIn * Coeff;
>     return result;
> end function mac;
> ```
>
> Verwendung im synchronen Prozess:
> ```vhdl
> FaltSum <= mac(DataIn_d0, Coeff1) + mac(DataIn_d1, Coeff2)
>          + mac(DataIn_d2, Coeff3) + mac(DataIn_d3, Coeff4)
>          + mac(DataIn_d4, Coeff5);
> ```

---

## Kapitel 8 – Testbench

---

### Frage 8.1
**Was ist eine Testbench und welche Eigenschaften hat sie?**

> **AUS SKRIPT**
>
> Eine **Testbench** dient zur Überprüfung der VHDL-Code-Funktionen. Eigenschaften:
> - Eine Testbench hat **keine Ein- oder Ausgangsports** (leere Entity)
> - Es werden Stimuli-Signale erzeugt, die auf die Eingänge des **DUT** (Device Under Test) gelegt werden
> - Die Codes werden simuliert und die Ergebnisse im Simulator betrachtet
> - Alternativ können zur grafischen Auswertung die erwarteten Ergebnisse mit den tatsächlichen Werten verglichen werden
> - `assert`-Befehl hilft bei der Ausgabe von Ergebnissen

---

### Frage 8.2
**Wie ist der Aufbau einer Testbench in VHDL?**

> **AUS SKRIPT**
>
> ```vhdl
> library IEEE;
> use IEEE.std_logic_1164.all;
>
> entity tb_mein_design is
>     -- leere Entity, keine Ports!
> end entity tb_mein_design;
>
> architecture sim of tb_mein_design is
>     -- Signaldeklarationen (gleiche Namen wie Ports des DUT)
>     signal Clk    : std_logic := '0';
>     signal Reset  : std_logic := '0';
>     signal A      : std_logic := '0';
>     signal B      : std_logic := '0';
>     signal SigOut : std_logic;
>
>     -- Component-Deklaration des DUT
>     component mein_design is
>         port (
>             Clk    : in  std_logic;
>             Reset  : in  std_logic;
>             A      : in  std_logic;
>             B      : in  std_logic;
>             SigOut : out std_logic
>         );
>     end component;
>
> begin
>     -- DUT instanziieren (Port-Map)
>     DUT: mein_design port map (
>         Clk    => Clk,
>         Reset  => Reset,
>         A      => A,
>         B      => B,
>         SigOut => SigOut
>     );
>
>     -- Taktgenerator
>     Clk <= not Clk after 10 ns;
>
>     -- Stimuli-Prozess
>     stim_proc: process
>     begin
>         Reset <= '0';
>         wait for 20 ns;
>         Reset <= '1';
>         A <= '1'; B <= '0';
>         wait for 50 ns;
>         A <= '1'; B <= '1';
>         wait for 50 ns;
>         wait;
>     end process;
> end architecture sim;
> ```

---

### Frage 8.3
**Wozu dient der `assert`-Befehl in einer Testbench?**

> **AUS SKRIPT**
>
> Der `assert`-Befehl hilft bei der **Ausgabe von Ergebnissen** und kann erwartete Ausgaben mit tatsächlichen Werten vergleichen. Bei einer Fehlerübereinstimmung wird eine Meldung ausgegeben.

> **AUS DEM INTERNET** (IEEE VHDL Standard)
>
> Syntax:
> ```vhdl
> assert <bedingung>
>     report "Fehlermeldung"
>     severity <level>;
> ```
> Severity-Level: `note`, `warning`, `error`, `failure`
>
> Beispiel:
> ```vhdl
> assert (SigOut = '1')
>     report "Fehler: Erwartetes Ergebnis war '1'"
>     severity error;
> ```

---

## Kapitel 9 – Zähler

---

### Frage 9.1
**Was ist der Unterschied zwischen synchronen und asynchronen Zählern?**

> **AUS SKRIPT**
>
> | Eigenschaft       | Synchroner Zähler                              | Asynchroner Zähler                              |
> |-------------------|------------------------------------------------|-------------------------------------------------|
> | Takt              | Alle FF erhalten denselben Taktimpuls          | Nur das 1. FF wird von externem Takt gesteuert  |
> | Folgezustände     | Alle FF schalten gleichzeitig                  | FF werden kaskadiert getaktet                   |
> | Geschwindigkeit   | Schneller                                      | Langsamer                                       |
> | Zuverlässigkeit   | Zuverlässiger                                  | Schwerer zu testen                              |
> | Stromverbrauch    | Höherer Designaufwand                          | Ggf. weniger Strom                              |

---

### Frage 9.2
**Wie viele FlipFlops benötigt man für einen Zähler von 0 bis 15 (4-Bit Zähler)?**

> **AUS SKRIPT**
>
> Mit n FlipFlops kann man 2^n verschiedene Ausgangszustände haben. Für 0 bis 15 (16 Zustände) werden **4 FlipFlops** (n=4) benötigt, da 2^4 = 16.

---

### Frage 9.3
**Implementieren Sie einen synchronen Vorwärts-/Rückwärtszähler von 0 bis 15 in VHDL (aus Übungsblatt 5).**

> **AUS SKRIPT** (aus Übungsblatt 5)
>
> ```vhdl
> library IEEE;
> use IEEE.std_logic_1164.all;
> use IEEE.NUMERIC_STD.ALL;
>
> entity counter is
>     port (
>         Clk      : in  std_logic;
>         Reset    : in  std_logic;
>         Dir      : in  std_logic;   -- '1' = aufwärts, '0' = abwärts
>         CountOut : out std_logic_vector(3 downto 0)
>     );
> end entity counter;
>
> architecture rtl of counter is
>     signal cnt : integer range 0 to 15;
> begin
>     process(Reset, Clk)
>     begin
>         if Reset = '0' then
>             cnt <= 0;
>         elsif rising_edge(Clk) then
>             if Dir = '1' then
>                 if cnt = 15 then
>                     cnt <= 0;
>                 else
>                     cnt <= cnt + 1;
>                 end if;
>             else
>                 if cnt = 0 then
>                     cnt <= 15;
>                 else
>                     cnt <= cnt - 1;
>                 end if;
>             end if;
>         end if;
>     end process;
>
>     CountOut <= std_logic_vector(to_unsigned(cnt, CountOut'length));
> end architecture rtl;
> ```

---

### Frage 9.4
**Was ist ein Johnson-Zähler und wie funktioniert er?**

> **AUS SKRIPT**
>
> Ein Johnson-Zähler ist ein modifizierter Ringzähler, bei dem der **invertierte Ausgang** des letzten FlipFlops auf den Eingang des ersten zurückgekoppelt wird. Eigenschaften:
> - Bei n FlipFlops entstehen 2·n verschiedene Zustände (nicht 2^n)
> - Beispiel: 3 FlipFlops → 6 Zustände → kann als Frequenzteiler 1:6 verwendet werden
> - In der Vorlesung als **Frequenzteiler** (1:2, 1:6) eingesetzt

---

### Frage 9.5
**Was ist ein Schieberegister und welche Arten gibt es?**

> **AUS SKRIPT**
>
> Ein **Schieberegister** ist ein Register, bei dem die gespeicherte Information mit jeder Taktflanke um eine Position verschoben wird.
>
> Typen:
> | Typ                           | Beschreibung                                                     |
> |-------------------------------|------------------------------------------------------------------|
> | Seriell-Ein / Seriell-Aus     | Daten werden seriell eingegeben und seriell ausgegeben           |
> | Seriell-Ein / Parallel-Aus    | Daten werden seriell eingegeben, parallel abgelesen              |
> | Parallel-Ein / Seriell-Aus    | Parallele Eingabe, serielle Ausgabe                              |
> | Universal-Schieberegister     | Alle vier Modi (plus Halten) über Steuersignale wählbar          |
>
> Typische Bitbreiten: 4, 8, 16, 32, 64, 128 Bit (auch nicht-potenz-Werte wie 158 Bit kommen in spezialisierten industriellen Designs vor, laut Skript).

---

### Frage 9.6
**Was ist ein 3-Bit-Zähler mit Integer-Speicher (aus Übungsblatt 2.5)?**

> **AUS SKRIPT** (aus Übungsblatt 2.5)
>
> ```vhdl
> library IEEE;
> use IEEE.std_logic_1164.all;
> use IEEE.NUMERIC_STD.ALL;
>
> entity counter_3bit is
>     port (
>         Clk     : in  std_logic;
>         Reset   : in  std_logic;
>         DataIn  : in  std_logic;
>         DataOut : out std_logic_vector(2 downto 0)
>     );
> end entity counter_3bit;
>
> architecture rtl of counter_3bit is
>     signal cnt : integer range 0 to 7;
> begin
>     process(Reset, Clk)
>     begin
>         if Reset = '0' then
>             cnt <= 0;
>         elsif rising_edge(Clk) then
>             if DataIn = '1' then
>                 if cnt = 7 then
>                     cnt <= 0;    -- wrap around
>                 else
>                     cnt <= cnt + 1;
>                 end if;
>             end if;
>         end if;
>     end process;
>
>     DataOut <= std_logic_vector(to_unsigned(cnt, DataOut'length));
> end architecture rtl;
> ```

---

## Kapitel 10 – Endliche Automaten (FSM)

---

### Frage 10.1
**Welche zwei Typen von Zustandsautomaten werden in der Vorlesung behandelt?**

> **AUS SKRIPT**
>
> In der Praxis haben sich zwei Automatentypen durchgesetzt:
> 1. **Moore-Automat:** Ausgang hängt **nur vom aktuellen Zustand** ab: `A = μ(Z)`
> 2. **Mealy-Automat:** Ausgang hängt vom aktuellen Zustand **und** vom Eingang ab: `A = ω(E, Z)`
> 3. **Medvedev-Automat:** Sonderfall des Moore-Automaten, bei dem kein Ausgangsschaltnetz vorhanden ist → der Zustand Z ist gleich dem Ausgang A

---

### Frage 10.2
**Was ist der Unterschied zwischen einem klassischen Zähler und einem Automaten?**

> **AUS SKRIPT**
>
> - **Klassischer Zähler:** Der nächste Zustand ist **nur** vom aktuellen Zustand abhängig. Daher werden Zähler auch als **autonome Automaten** bezeichnet.
> - **Automat:** Der nächste Zustand hängt vom **aktuellen Zustand** und von der **Eingangsgröße** ab.

---

### Frage 10.3
**Beschreiben Sie die Zustandsübergangsfunktion und die Ausgangslogik eines Moore-Automaten.**

> **AUS SKRIPT**
>
> **Zustandsübergangsfunktion δ (Delta):**
> ```
> Zt+1 = δ(Zt, Et)
> ```
> Der neue Zustand (Zt+1) ist abhängig vom aktuellen Zustand (Zt) und der aktuellen Eingangsgröße (Et).
>
> **Ausgangslogik μ (Mu):**
> ```
> At = μ(Zt)
> ```
> Die aktuellen Ausgangsgrößen sind **nur vom aktuellen Zustand** abhängig (nicht vom Eingang).

---

### Frage 10.4
**Wie wird ein Moore-Automat in VHDL implementiert? Beschreiben Sie die typische Struktur.**

> **AUS SKRIPT**
>
> Ein Moore-Automat in VHDL besteht typischerweise aus **zwei Prozessen**:
>
> 1. **Synchroner Prozess** (Zustandsspeicher): Speichert den aktuellen Zustand
> 2. **Asynchroner Prozess** (Kombinatorische Logik): Berechnet Folgezustand und Ausgabe
>
> ```vhdl
> architecture rtl of moore_fsm is
>     type state_type is (S_IDLE, S_A, S_B, S_C);
>     signal current_state, next_state : state_type;
> begin
>     -- Prozess 1: Synchroner Zustandsspeicher
>     state_reg: process(Reset, Clk)
>     begin
>         if Reset = '0' then
>             current_state <= S_IDLE;
>         elsif rising_edge(Clk) then
>             current_state <= next_state;
>         end if;
>     end process;
>
>     -- Prozess 2: Kombinatorische Zustandsübergangslogik
>     next_state_logic: process(current_state, E)
>     begin
>         case current_state is
>             when S_IDLE =>
>                 if E = '1' then next_state <= S_A;
>                 else next_state <= S_IDLE; end if;
>             when S_A =>
>                 next_state <= S_B;
>             when S_B =>
>                 next_state <= S_C;
>             when S_C =>
>                 next_state <= S_IDLE;
>             when others =>
>                 next_state <= S_IDLE;
>         end case;
>     end process;
>
>     -- Ausgangslogik (nur vom Zustand abhängig)
>     DataOut <= '1' when current_state = S_B else '0';
> end architecture rtl;
> ```

---

### Frage 10.5
**Was ist der Unterschied zwischen Moore- und Mealy-Automat beim Zustandsdiagramm?**

> **AUS SKRIPT**
>
> **Moore-Automat:**
> - Kreise enthalten oben den Zustandsnamen, unten die Ausgaben
> - Übergangspfeile enthalten **nur** die Eingangsgrößen
>
> **Mealy-Automat:**
> - Kreise enthalten nur den Zustandsnamen
> - Übergangspfeile enthalten **Eingang / Ausgang** (EINGABE / AUSGABE)
> - Die Ausgaben hängen sowohl vom aktuellen Zustand als auch von den Eingangsgrößen ab

---

### Frage 10.6
**Was bedeuten „parasitäre Zyklen" und „Fixpunkte" in einem Zustandsdiagramm?**

> **AUS SKRIPT**
>
> Ein Zustandsdiagramm darf **weder** parasitäre Zyklen **noch** Fixpunkte enthalten:
> - **Parasitärer Zyklus:** Ein unerwünschter Kreislauf zwischen mehreren Zuständen, aus dem der Automat nicht herauskommt
> - **Fixpunkt:** Ein Zustand, aus dem es keinen Ausgang gibt – der Automat bleibt dauerhaft in diesem Zustand hängen

---

### Frage 10.7
**Implementieren Sie einen Moore-Automaten mit zwei Zählern (aus Übungsblatt 6).**

> **AUS SKRIPT** (Konzept aus Übungsblatt 6)
>
> Übungsblatt 6 verlangt einen Moore-Automaten mit zwei Eingangssignalen, der zwei Zähler von 0 bis 15 entgegengesetzt zählen lässt. Grundstruktur:
>
> ```vhdl
> architecture rtl of moore_dual_counter is
>     type state_type is (S_IDLE, S_COUNT, S_STOP);
>     signal state     : state_type;
>     signal cnt1, cnt2 : integer range 0 to 15;
> begin
>     process(Reset, Clk)
>     begin
>         if Reset = '0' then
>             state <= S_IDLE;
>             cnt1  <= 0;
>             cnt2  <= 15;
>         elsif rising_edge(Clk) then
>             case state is
>                 when S_IDLE =>
>                     if E1 = '1' then state <= S_COUNT; end if;
>                 when S_COUNT =>
>                     if cnt1 < 15 then cnt1 <= cnt1 + 1; end if;
>                     if cnt2 > 0  then cnt2 <= cnt2 - 1; end if;
>                     if E2 = '1' then state <= S_STOP; end if;
>                 when S_STOP =>
>                     state <= S_IDLE;
>                 when others =>
>                     state <= S_IDLE;
>             end case;
>         end if;
>     end process;
> end architecture rtl;
> ```

---

## Kapitel 11 – FIR Filter

---

### Frage 11.1
**Was ist ein FIR-Filter und wie wird er in VHDL implementiert (aus Übungsblatt 3)?**

> **AUS SKRIPT** (aus Übungsblatt 3)
>
> Ein FIR-Filter (Finite Impulse Response) berechnet eine **Faltungssumme** (Convolution). Für Übungsblatt 3 mit 5 Koeffizienten:
>
> ```
> Coeff1 = 33,  Coeff2 = 11,  Coeff3 = 54,  Coeff4 = Coeff2 = 11,  Coeff5 = Coeff1 = 33
> FaltSum = DataIn[0]*Coeff1 + DataIn[1]*Coeff2 + DataIn[2]*Coeff3 + DataIn[3]*Coeff4 + DataIn[4]*Coeff5
> ```
>
> VHDL-Implementierung (nur synchrone Signale):
> ```vhdl
> architecture rtl of fir_filter is
>     signal d0, d1, d2, d3, d4   : integer;
>     signal FaltSum               : integer;
>     signal SigOut_i              : integer;
>
>     constant Coeff1 : integer := 33;
>     constant Coeff2 : integer := 11;
>     constant Coeff3 : integer := 54;
> begin
>     process(Reset, Clk)
>     begin
>         if Reset = '0' then
>             d0 <= 0; d1 <= 0; d2 <= 0; d3 <= 0; d4 <= 0;
>             FaltSum <= 0;
>             SigOut_i <= 0;
>         elsif rising_edge(Clk) then
>             d0 <= to_integer(unsigned(DataIn1));
>             d1 <= d0;
>             d2 <= d1;
>             d3 <= d2;
>             d4 <= d3;
>             FaltSum <= d0*Coeff1 + d1*Coeff2 + d2*Coeff3 + d3*Coeff2 + d4*Coeff1;
>             SigOut_i <= FaltSum;
>         end if;
>     end process;
>
>     SigOut <= std_logic_vector(to_unsigned(SigOut_i, SigOut'length));
> end architecture rtl;
> ```

---

### Frage 11.2
**Wie wird ein FIR-Filter mit zwei Koeffizientensätzen und einem Select-Signal implementiert (aus Übungsblatt 4)?**

> **AUS SKRIPT** (aus Übungsblatt 4)
>
> Übungsblatt 4 verlangt zwei Koeffizientensätze, die über ein `SelectIn`-Signal ausgewählt werden:
>
> ```vhdl
> process(Reset, Clk)
> begin
>     if Reset = '0' then
>         -- Reset aller Register
>         d0 <= 0; d1 <= 0; d2 <= 0; d3 <= 0; d4 <= 0;
>         SigOut_i <= 0;
>     elsif rising_edge(Clk) then
>         d0 <= to_integer(unsigned(DataIn1));
>         d1 <= d0; d2 <= d1; d3 <= d2; d4 <= d3;
>         if SelectIn = '0' then
>             -- Koeffizientensatz 1
>             SigOut_i <= d0*C1_1 + d1*C1_2 + d2*C1_3 + d3*C1_4 + d4*C1_5;
>         else
>             -- Koeffizientensatz 2
>             SigOut_i <= d0*C2_1 + d1*C2_2 + d2*C2_3 + d3*C2_4 + d4*C2_5;
>         end if;
>     end if;
> end process;
> ```

---

## Kapitel 12 – CORDIC Algorithmus

---

### Frage 12.1
**Was ist der CORDIC-Algorithmus und wofür wird er verwendet?**

> **AUS SKRIPT**
>
> **CORDIC** steht für **Coordinate Rotation Digital Computer**. Der Algorithmus wurde 1959 von J. E. Volder entwickelt und 1971 von J. S. Walther erweitert.
>
> CORDIC ermöglicht es, elementare **trigonometrische und hyperbolische Funktionen** unter fast ausschließlicher Verwendung von **schnellen Operationen** effizient zu berechnen. Mit schnellen Operationen sind hier **Additionen (adds)** und **Multiplikationen mit Zweierpotenzen (shifts)** gemeint.
>
> CORDIC beherrscht folgende Rechenarten:
> - Betriebsarten: **Rotating** und **Vectoring**
> - Modus: **linear** (m=0), **zirkular** (m=1), **hyperbolisch** (m=-1)

---

### Frage 12.2
**Erklären Sie das Grundprinzip des CORDIC-Algorithmus.**

> **AUS SKRIPT**
>
> Ausgangspunkt ist die **Drehung eines Vektors** [x₀, y₀]^T um den Winkel φ in einem kartesischen Koordinatensystem. Durch die Drehung wird der Betrag des Vektors nicht verändert.
>
> Die Drehung um den Winkel φ wird durch **mehrere Rotationen** mit bekannten, vorher gespeicherten Teilwinkeln αᵢ realisiert. Durch festzulegende Vorzeichen σᵢ wird die Summe der n Teilwinkel αᵢ dem gesuchten Winkel φ angenähert.
>
> Die Winkel werden als eine Folge von Zweierpotenzen angenommen → Lookup-Table in Grad.
>
> Berechnungsformeln für jede Iteration:
> ```
> x[i+1] = x[i] - σ[i] * y[i] * 2^(-i)
> y[i+1] = y[i] + σ[i] * x[i] * 2^(-i)
> z[i+1] = z[i] - σ[i] * arctan(2^(-i))
> ```

---

### Frage 12.3
**Welche zwei Architekturvarianten für den CORDIC in VHDL gibt es (aus Übungsblatt 8)?**

> **AUS SKRIPT** (aus Übungsblatt 8)
>
> 1. **Pipelining-Variante:** Alle 16 Iterationen werden als separate, hintereinandergeschaltete Stufen implementiert. Hoher Ressourcenverbrauch, aber maximaler Durchsatz (jede Taktflanke ein neues Ergebnis).
>
> 2. **Sequentielle Variante (ein CORDIC-Element):** Ein einzelnes CORDIC-Element wird sequentiell 16 Mal durchlaufen. Geringer Ressourcenverbrauch, aber nur alle 16 Takte ist ein Ergebnis verfügbar. Erfordert einen Zustandsautomaten zur Steuerung der Iteration.

---

### Frage 12.4
**Wie wird ein CORDIC-Algorithmus als Integer in C bittrue modelliert (aus Übungsblatt 7)?**

> **AUS SKRIPT**
>
> Beim **Bittrue-Modelling** werden:
> - Eingabewerte auf den Bereich -256 ... +255 begrenzt (17-Bit Signed)
> - Wortbreiten während der Iterationen auf 19-Bit Signed begrenzt (Wortbreiten wachsen während der Iterationen an)
> - Die Ausgabe erfolgt mit 9-Bit Signed (-256 ... +256 → entspricht -180° bis +180°)
> - Die 16-Bit-unsigned interne Auflösung der Winkel und die 19-Bit-Wortbreite von x, y dienen zur Rechengenauigkeit
> - Winkel werden durch Multiplikation mit 2^Iterations von Float auf Integer konvertiert

---

## Kapitel 13 – Zusammenfassung und Spezialthemen

---

### Frage 13.1
**Welche Signalzustandswerte kann `std_logic` annehmen und was bedeuten sie?**

> **AUS SKRIPT**
>
> Nach IEEE 1164 kann ein Signal (`std_logic`) folgende 9 Zustände annehmen:
>
> | Kürzel | Bedeutung         |
> |--------|-------------------|
> | `U`    | Uninitialized     |
> | `X`    | Forcing Unknown   |
> | `0`    | Forcing 0         |
> | `1`    | Forcing 1         |
> | `Z`    | High Impedance    |
> | `W`    | Weak Unknown      |
> | `L`    | Weak 0            |
> | `H`    | Weak 1            |
> | `D`    | Don't Care        |

---

### Frage 13.2
**Was ist der Unterschied zwischen `downto` und `to` bei Vektoren?**

> **AUS SKRIPT** (reservierte Wörter)
>
> - `downto`: Bereich von hohem zu niedrigem Index, z.B. `std_logic_vector(7 downto 0)` – Bit 7 ist das MSB
> - `to`: Bereich von niedrigem zu hohem Index, z.B. `range 1 to 10` – bei Integers
>
> **Konvention:** Bei `std_logic_vector` wird in der Vorlesung **immer `downto`** verwendet, damit Bit N-1 das MSB ist.

---

### Frage 13.3
**Was ist eine Komponente in VHDL und wie wird sie instanziiert?**

> **AUS SKRIPT** (reservierte Wörter + Bibliotheken)
>
> Eine **Komponente** (`component`) erlaubt die Wiederverwendung eines VHDL-Designs innerhalb einer anderen Architecture.
>
> ```vhdl
> -- Schritt 1: Komponente deklarieren (im deklarativen Teil der Architecture)
> component mein_modul is
>     port (
>         Clk  : in  std_logic;
>         DataIn  : in  std_logic_vector(7 downto 0);
>         DataOut : out std_logic_vector(7 downto 0)
>     );
> end component;
>
> -- Schritt 2: Komponente instanziieren (im Architektur-Körper)
> inst_modul: mein_modul port map (
>     Clk     => Clk,
>     DataIn  => my_data_in,
>     DataOut => my_data_out
> );
> ```

---

### Frage 13.4
**Was ist der Unterschied zwischen `package`, `entity`, `architecture` und `configuration`?**

> **AUS SKRIPT**
>
> Die Entwürfe sind in **Bibliotheken** organisiert. Bibliotheken können vier Teile enthalten:
>
> | Teil             | Beschreibung                                                 |
> |------------------|--------------------------------------------------------------|
> | `package`        | Globale Deklarationen (Typen, Konstanten, Funktionen)        |
> | `entity`         | Design-Sicht von außen (Black Box, Ports)                    |
> | `architecture`   | Design-Implementierung (interne Realisierung)                |
> | `configuration`  | Festlegung einer Design-Version (Zuordnung Architecture ↔ Entity) |

---

### Frage 13.5
**Was sind reservierte VHDL-Wörter? Nennen Sie mindestens 10 davon.**

> **AUS SKRIPT**
>
> Reservierte Wörter dürfen nicht als Bezeichner (Signalnamen, Entitätsnamen, etc.) verwendet werden. Auswahl aus dem Skript:
>
> `architecture`, `begin`, `case`, `component`, `constant`, `downto`, `else`, `elsif`, `end`, `entity`, `function`, `generic`, `if`, `in`, `inout`, `is`, `library`, `not`, `of`, `or`, `out`, `package`, `port`, `process`, `return`, `signal`, `then`, `type`, `use`, `variable`, `when`, `while`, `with`, `xor`, `and`, `or`, `nor`, `nand`, `xnor`, `rising_edge`

---

### Frage 13.6
**Wie funktionieren Synchronisationsschaltungen in VHDL?**

> **AUS SKRIPT**
>
> Automaten bestehen aus **synchron getakteten FlipFlops**. Eingangsgrößen können sich jedoch zu **jedem Zeitpunkt** ändern, da unsere Umwelt grundsätzlich asynchron ist. Fällt ein Eingangswechsel genau auf den Zeitpunkt der aktiven Taktflanke, können unvorhergesehene Zustände eintreten (Metastabilität).
>
> **Lösung:** Die internen Eingangsgrößen des Automaten müssen stabil gehalten werden → **Synchronisierschaltungen**.
>
> Typen von Synchronisationsschaltungen:
> 1. **Synchroner Monoflop:** Auf einen Eingangsimpuls beliebiger Länge wird mit einem Ausgangsimpuls definierter Länge (eine Taktperiode) reagiert
> 2. **Synchroner Änderungsdetektor:** Jede Änderung des Eingangssignals liefert einen synchronen Ausgangsimpuls der Länge einer Taktperiode
> 3. **Modifizierte Impuls-Synchronisierung:** Asynchroner Setzeingang im FlipFlop – geht sofort auf 1 falls Eingang auf 1, geht bei der nächsten Taktflanke auf 0 falls Eingang auf 0

---

### Frage 13.7
**Wie wird mathematische Berechnung (Add, Mul, Sub) in VHDL mit synchronen und asynchronen Signalen implementiert (aus Übungsblatt 2)?**

> **AUS SKRIPT** (aus Übungsblatt 2)
>
> Gegeben: `DataIn1`, `DataIn2`, `DataIn3` als Integer (0..15). Berechne:
> ```
> Add1 = DataIn1 + DataIn2
> Add2 = DataIn1 + DataIn3
> Mul1 = Add1 * Add2
> Sub1 = Mul1 - Add2
> SigOut = Sub1
> ```
>
> **Variante mit asynchronen Signalen (wenige Register):**
> ```vhdl
> -- Asynchroner Prozess: kombinatorische Berechnung (kein Register)
> async_proc: process(DataIn1, DataIn2, DataIn3, Mul1_async)
> begin
>     Add1_async <= to_integer(unsigned(DataIn1)) + to_integer(unsigned(DataIn2));
>     Add2_async <= to_integer(unsigned(DataIn1)) + to_integer(unsigned(DataIn3));
>     Mul1_async <= Add1_async * Add2_async;
>     Sub1_async <= Mul1_async - Add2_async;
> end process;
>
> -- Synchroner Prozess: nur Ausgangsregister
> sync_proc: process(Reset, Clk)
> begin
>     if Reset = '0' then
>         SigOut_i <= 0;
>     elsif rising_edge(Clk) then
>         SigOut_i <= Sub1_async;  -- nur 1 Register am Ausgang
>     end if;
> end process;
> ```

---

### Frage 13.8
**Wie lautet die Syntax des `generate`-Statements in VHDL?**

> **AUS DEM INTERNET** (IEEE VHDL Standard / VHDL-Whiz)
>
> Das `generate`-Statement dient zur strukturierten Erzeugung von mehreren Instanzen oder bedingter Hardware-Generierung:
>
> **For-Generate:**
> ```vhdl
> gen_label: for i in 0 to N-1 generate
>     instanz_i: mein_modul port map (
>         DataIn  => DataArray(i),
>         DataOut => ResultArray(i)
>     );
> end generate;
> ```
>
> **If-Generate:**
> ```vhdl
> gen_label: if CONDITION generate
>     -- Hardware nur wenn Bedingung wahr
> end generate;
> ```

---

### Frage 13.9
**Was ist ein `generic` in VHDL und wie wird es verwendet?**

> **AUS DEM INTERNET** (IEEE VHDL Standard / VHDL-Whiz)
>
> `generic` erlaubt die Parametrisierung von Designs zur Entwurfszeit. Damit kann z.B. die Bitbreite eines Designs konfigurierbar gemacht werden:
>
> ```vhdl
> entity param_counter is
>     generic (
>         WIDTH : integer := 8   -- Standard: 8 Bit
>     );
>     port (
>         Clk     : in  std_logic;
>         Reset   : in  std_logic;
>         CountOut: out std_logic_vector(WIDTH-1 downto 0)
>     );
> end entity param_counter;
> ```
>
> Bei der Instanziierung:
> ```vhdl
> cnt16: param_counter generic map (WIDTH => 16) port map (...);
> ```

---

### Frage 13.10
**Was ist der Unterschied zwischen einem FlipFlop und einem Register laut Skript?**

> **AUS SKRIPT**
>
> - **FlipFlop:** Bauelement, das **1 Bit** speichern kann
> - **Register:** Typischerweise eine Ansammlung von mehreren (mindestens 2) parallelen FlipFlops, um mehr als 1 Bit gleichzeitig speichern zu können
>
> **Hinweis aus dem Skript:** In der Praxis wird zwischen diesen beiden Begriffen bei 1 Bit Wortbreite **nicht unterschieden**! In der Vorlesung gilt:
> - Ein FlipFlop speichert eine Wortbreite von = 1
> - Ein Register speichert eine Wortbreite von ≥ 2

---

## Bonus: Typische Prüfungsaufgaben

---

### Aufgabe B.1
**Entwerfen Sie in VHDL eine Entity und Architecture für eine 2-Bit-Addition mit synchronem Prozess und asynchronem Reset.**
Eingänge: `A`, `B` (std_logic_vector, 2 Bit), Ausgang: `Sum` (std_logic_vector, 3 Bit)

> **AUS SKRIPT** (Integer Beispiele Kap. 3)
>
> ```vhdl
> library IEEE;
> use IEEE.std_logic_1164.all;
> use IEEE.NUMERIC_STD.ALL;
>
> entity adder_2bit is
>     port (
>         Clk   : in  std_logic;
>         Reset : in  std_logic;
>         A     : in  std_logic_vector(1 downto 0);
>         B     : in  std_logic_vector(1 downto 0);
>         Sum   : out std_logic_vector(2 downto 0)
>     );
> end entity adder_2bit;
>
> architecture rtl of adder_2bit is
>     signal a_int, b_int, sum_int : integer range 0 to 7;
> begin
>     process(Reset, Clk)
>     begin
>         if Reset = '0' then
>             sum_int <= 0;
>         elsif rising_edge(Clk) then
>             a_int   <= to_integer(unsigned(A));
>             b_int   <= to_integer(unsigned(B));
>             sum_int <= a_int + b_int;
>         end if;
>     end process;
>
>     Sum <= std_logic_vector(to_unsigned(sum_int, Sum'length));
> end architecture rtl;
> ```

---

### Aufgabe B.2
**Erklären Sie, warum das Package `IEEE.NUMERIC_STD.ALL` dem Package `IEEE.std_logic_unsigned.all` vorzuziehen ist.**

> **AUS SKRIPT**
>
> `std_logic_unsigned` und `std_logic_signed` sind **nicht in IEEE-standardisierten Packages** enthalten, werden aber häufig von Synthesetools unterstützt. Das Package `IEEE.NUMERIC_STD.ALL` ist:
> - Vollständig IEEE-standardisiert
> - Definiert die Typen `signed` und `unsigned` als Array von `std_logic`
> - Definiert alle gebräuchlichen Arithmetikoperationen auf diesen Typen
> - Portabler und zukunftssicherer

---

### Aufgabe B.3
**Was passiert, wenn ein Zähler in einen „Don't Care"-Zustand fällt (z.B. Dezimalzähler)?**

> **AUS SKRIPT**
>
> Ein Zähler kommt aus einem Don't-Care-Zustand **immer wieder in den gewollten Zustand**. Beim Dezimalzähler (0..9):
> - Zustand 0 = (0,0,0,0): würde in Zustand 1 gehen
> - Zustand 15 = (1,1,1,1): würde in Zustand 0 gehen, danach in Zustand 1
>
> → Einfach den Zähler immer weiter zählen lassen; er findet automatisch in den Hauptzyklus zurück, sofern kein parasitärer Zyklus und kein Fixpunkt vorhanden ist.

---

*Ende des Fragenkatalogs*
