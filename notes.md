# Lab 1 — Notes

**Group 2:** Mouhammed Al-Bachir Youmbai · Moulay Saaid Reggani

## Environment

| Tool | Status |
|---|---|
| EMU8086 | Installed. Used for Trial 1 and Trial 2. |
| NASM | Installed (version 3.02). Trial 3 is assembled with `nasm -f bin src/trial3_hello_nasm.asm -o hello.com`. |
| MASM + Irvine32 | Setup in progress: Visual Studio Community (C++ desktop workload) and the Irvine32 files. |

## Trial 1 — Registers and flags

Predicted values before running, then checked by single-stepping in EMU8086:

| After instruction | AX | BX | CX |
|---|---|---|---|
| `mov ax, 0005h` | 0005h | — | — |
| `mov bx, 0003h` | 0005h | 0003h | — |
| `add ax, bx` | 0008h | 0003h | — |
| `mov cx, ax` | 0008h | 0003h | 0008h |
| `sub cx, bx` | 0008h | 0003h | 0005h |

Flags after the two arithmetic instructions (1 = set, 0 = clear):

| Instruction | Result | CF | ZF | SF | OF | PF | AF |
|---|---|---|---|---|---|---|---|
| `add ax, bx` (5 + 3) | 0008h | 0 | 0 | 0 | 0 | 0 | 0 |
| `sub cx, bx` (8 − 3) | 0005h | 0 | 0 | 0 | 0 | 1 | 0 |

**Explanation**

- **CF = 0** in both cases: the ADD produced no carry out of the top bit, and the SUB needed no borrow because 8 ≥ 3.
- **ZF = 0**: neither result is zero.
- **SF = 0**: the most significant bit of both results is 0, so both are positive.
- **OF = 0**: the signed results (+8 and +5) fit in 16 bits.
- **PF** depends only on the low byte of the result. 08h = `0000 1000` has one bit set (odd) → PF = 0. 05h = `0000 0101` has two bits set (even) → PF = 1. PF is the only flag that changed between the two instructions.
- **AF = 0**: no carry (5 + 3 = 8) or borrow (8 − 3) between bit 3 and bit 4.
- The `mov` instructions did not change any flag: only arithmetic and logic instructions update them.

## Trial 2

The message is printed with `INT 21h`, function `09h`. Two things are required: `DS` must be loaded with `@DATA` (through AX, because a segment register cannot be loaded with an immediate value), and the string must end with `$`, otherwise DOS keeps printing whatever bytes follow it in memory. `LEA DX, message` puts the offset of the string in DX.

## Trial 3

NASM uses `ORG 0x100` because a `.COM` program is loaded at offset 100h of its segment, right after the 256-byte PSP. In NASM, `mov dx, message` already loads the address of the label; MASM needs `OFFSET` (or `LEA`) for the same thing.

## Trial 4

`LOOP` decrements ECX and jumps back while ECX is not zero, so ECX is set to 3 before the loop and EBX holds the running total. The Irvine32 procedures (`WriteString`, `ReadInt`, `WriteInt`, `Crlf`) preserve ECX and EBX, so the counter and the total are not disturbed inside the loop.

**Extension:** to read five integers instead of three, only `mov ecx, 3` has to change, to `mov ecx, 5`.
