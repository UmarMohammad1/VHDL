# VHDL – RTL Design für synthesefähige Digitalschaltungen

Dieses Repository enthält Lehr- und Übungsmaterialien zur Vorlesung **VHDL – Very High Speed Integrated Circuit Hardware Description Language** (RTL – Register Transfer Level Design für synthesefähige Digitalschaltungen) von **Prof. Edmund Coersmeier**, Hochschule Bochum, Wintersemester 2025/2026.

> **Antwort zur gestellten Frage:** Ja – alle PDF-Dokumente in diesem Repository sind sichtbar und lesbar. Eine Übersicht der Inhalte finden Sie weiter unten.

---

## Inhalt des Repositories

### 📘 Skript

| Datei | Beschreibung |
|---|---|
| [VHDLVers0.0063.pdf](VHDLVers0.0063.pdf) | Vollständiges Vorlesungsskript (Version 0.0063). Umfasst 14 Kapitel: Einleitung, ASIC/FPGA-Bausteine & Xilinx Vivado, VHDL-Grundlagen (Entity, Architecture, Datentypen, Signale, Packages), Kontrollstrukturen & Operatoren, RTL-Design (synchrone/asynchrone Prozesse), Testbench & Simulation, Zähler & Endliche Automaten, CORDIC, FIR/IIR-Filter, Künstliche Neuronale Netze, stromeffizienter VHDL-Code, UART, ADC. |

### 📝 Übungsblätter

| Datei | Thema | Kurzbeschreibung |
|---|---|---|
| [Uebungsblatt1_VHDL_Vers1.0.pdf](Uebungsblatt1_VHDL_Vers1.0.pdf) | Grundlagen – Synchrone Prozesse & Registerstufen | Entwurf einer Entity mit `Clk`, `Reset`, `A`, `B` und `SigOut`. Implementierung von vier synchronen Registerstufen mit XOR-, AND- und OR-Verknüpfungen. Synthese unter Vivado, Erstellung eines Constrainfiles. |
| [Uebungsblatt2_VHDL_Vers1.1.pdf](Uebungsblatt2_VHDL_Vers1.1.pdf) | Arithmetik – Addition, Multiplikation, Subtraktion | Entity mit drei Dateneingängen (unsigned 0–15). Implementierung von Additionen, Multiplikation und Subtraktion in synchronen Prozessen; Vergleich verschiedener Architekturen (nur synchrone Signale vs. einzelnes synchrones Ausgangssignal). |
| [Uebungsblatt2.5_VHDL_Vers1.0.pdf](Uebungsblatt2.5_VHDL_Vers1.0.pdf) | Integer-Speicher & Inkrementierung | 3-Bit-Integer-Zähler: Bei `DataIn = '1'` wird ein 3-Bit-Speicher um 1 inkrementiert, sonst bleibt der Wert erhalten. Realisierung als Prozessvariable, Testbench und Simulation. |
| [Uebungsblatt3_VHDL_Vers1.2.pdf](Uebungsblatt3_VHDL_Vers1.2.pdf) | FIR-Filter (Faltung) – 5 Koeffizienten | Implementierung einer 5-Tap-Faltung (FIR-Filter) mit fixen Koeffizienten (33, 11, 54, 11, 33). Verschiedene Architekturvarianten: vollständig synchron, nur synchrones Ausgangssignal, maximaler Variableneinsatz in einem Prozess. |
| [Uebungsblatt4_VHDL_Vers1.1.pdf](Uebungsblatt4_VHDL_Vers1.1.pdf) | Umschaltbarer FIR-Filter – 2 Koeffizientensätze | Erweiterung des FIR-Filters auf zwei wählbare Koeffizientensätze (über `SelectIn`). Entwurf, Synthese und Simulation beider Varianten. |
| [Uebungsblatt5_VHDL_Vers1.1.pdf](Uebungsblatt5_VHDL_Vers1.1.pdf) | Zähler – Vorwärts/Rückwärts & variable Schrittweite | Aufgabe 1: Vorwärts-/Rückwärtszähler 0–15. Aufgabe 2: Zähler 0–26 mit wählbarer Schrittweite (2er oder 3er Schritte). Zustandsübergänge, Architekturskizze, Synthese, Simulation und Dokumentation. |
| [Uebungsblatt6_VHDL_Vers1.0.pdf](Uebungsblatt6_VHDL_Vers1.0.pdf) | Endliche Automaten – Moore-Automat | Entwurf eines Moore-Automaten mit zwei Eingangssignalen, der zwei Zähler (0–15) entgegengesetzt zählen lässt. Zustandsübergänge, VHDL-Implementierung, Synthese, Simulation. |
| [Uebungsblatt7_VHDL_Vers1.0.pdf](Uebungsblatt7_VHDL_Vers1.0.pdf) | CORDIC – Bittrue-Modellierung in C | Schrittweise Bittrue-Modellierung des CORDIC-Algorithmus mittels C-Code: Eingangsbit­breite, Ausgangsbitbreite, vollständige Datenpfad-Modellierung, Konvertierung auf reine Integer-Ebene. |
| [Uebungsblatt8_VHDL_Vers1.0.pdf](Uebungsblatt8_VHDL_Vers1.0.pdf) | CORDIC – VHDL-Implementierung (16 Iterationen) | Implementierung des CORDIC-Algorithmus in VHDL mit 16 Iterationen und 20-Bit-Wortbreite. Zwei Architekturen: Pipeline vs. sequentiell. Handling aller vier Quadranten, Testbench, Synthese und Vergleich. |

---

## Voraussetzungen / Tools

- **Xilinx Vivado** (Design Suite) – für Synthese, Implementierung und Simulation
- **VHDL-Simulator** (z. B. Vivado Simulator / GHDL / ModelSim) – für Testbenches
- **C-Compiler** (z. B. GCC) – für das Bittrue-Modelling in Übungsblatt 7

---

## Lizenz

Copyright © Edmund Coersmeier 2008–2025, Hochschule Bochum.  
Die Materialien sind ausschließlich für den Lehrgebrauch im Rahmen der genannten Vorlesung bestimmt.
