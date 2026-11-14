# Practical Work 1 — Setting Up Your Assembly Language Environment & GitHub Workflow

**Computer Architecture · UEF31 · Semester 3**
University Chahid Hamma Lakhdar — El Oued
Instructor: **Saci Medileh**

| | |
|---|---|
| **Level** | Easy — first contact with assembly |
| **Marks** | 4 points out of 20 (continuous assessment) |
| **Work mode** | Group of 2 students, on Classroom50 |
| **Duration** | 1 to 2 weeks |
| **Tools** | EMU8086 · NASM · MASM + Irvine32 |
| **Submission** | This repository (push your work to `main`) |

---

## Start here (5 minutes)

1. **Student 1** (the first to open the lab link) accepts the assignment, creates the group, and adds **Student 2** under *Manage my group* on Classroom50. **Student 2** then opens the same link and clicks *Open repository*. Do not create a second group.
2. **Both students:** clone this repository to your computer.
3. **Open `GROUP_INFO.md` first.** Fill in Part 1 (registration number, last name, first name, study group, GitHub username) and Part 2, then commit and push. Do not edit Part 3: it is reserved for the instructor.
4. Do the lab below. Commit and push regularly, and respect the deadline shown on Classroom50 for this lab.

> **Working as a pair:** run `git pull` before you start. If `git push` is rejected (*non-fast-forward*), run `git pull` and then `git push` again. Never use `git push --force`.

The full student guide (English and Arabic) is available in the `docs/` folder of this repository.

> **Cannot work on your computer, or `git push` keeps failing?** You can work directly **online on GitHub**: open your repository on github.com, open a file and click the pencil icon (*Edit*), then *Commit changes*. To add files use *Add file → Upload files*. Pressing the `.` key on the repository page opens a full online editor (github.dev) where you can edit several files and commit them. No installation is needed.

## 1. Introduction & Objectives

This is the first practical work of the Computer Architecture module. Its purpose is not yet to write clever assembly — that begins once Chapter 3 covers the Intel 8086 in depth. Instead, this lab prepares your development environment, teaches you the source-formatting conventions every later program will follow, and gets you comfortable submitting work through GitHub. Every program here is short and meant simply to prove that your tools work and that you can read a register.

By the end of this lab you will be able to:

- Install and verify EMU8086, NASM, and the MASM + Irvine32 toolchain.
- Write assembly source that follows professional formatting conventions: a header block, one instruction per line, and aligned explanatory comments.
- Assemble and run programs in both a 16-bit emulator and a 32-bit command-line toolchain.
- Read the registers, flags, and memory windows in EMU8086 and interpret a register dump.
- Work through Git and GitHub the way a professional developer does.

## 2. Prerequisites

- A Windows machine (native or virtual) for EMU8086 and MASM. macOS and Linux users, see section 4.2.
- Basic comfort with a file explorer and a command-line terminal.
- No prior assembly experience — that is exactly what this practical sequence builds.

## 3. Timeline

| Week | Focus | Expected outcome |
|---|---|---|
| Week 1 | Install the tools. Clone this repository. | Tools verified; first commit pushed. |
| Week 2 | Complete the four trial programs. | Each program assembled, run, and pushed with its own commit. |

## 4. Required Tools

| Tool | Role in this lab | Where to get it |
|---|---|---|
| **EMU8086** | 16-bit 8086 emulator. Single-step programs while watching registers, flags and memory. Our tool for Chapter 3. | emu8086.com (free trial) |
| **NASM** | Command-line assembler. Turns `.asm` source into machine code the way assembly is built outside a teaching tool. | nasm.us (free, open source) |
| **MASM + Irvine32** | Microsoft Macro Assembler with the Irvine32 link library. Our 32-bit track, matching the course textbook and Chapter 4. | Bundled with Visual Studio; library ships with the textbook |
| **Text editor** | For writing `.asm` files outside an emulator. | code.visualstudio.com (free) |
| **Git + GitHub** | Version control and the platform where your work is tracked and reviewed. | git-scm.com · github.com |

### 4.1 Why three tools instead of one?

EMU8086 is a teaching tool: it single-steps a 16-bit program while showing every register and flag change, which is ideal for building intuition and matches the 8086 case study in Chapter 3. NASM introduces the command-line assemble-and-link workflow used in production. MASM with the Irvine32 library is the 32-bit environment used throughout the course textbook, and it gives you a small library of input/output procedures so your programs can talk to the user without writing raw system calls.

### 4.2 A note for macOS / Linux users

EMU8086 and MASM run natively only on Windows. Either run a free virtualization tool (such as VirtualBox) with a Windows installation, or use a lab machine for the Windows-only trial programs while doing your NASM work locally. DOSBox is a lightweight alternative for running 16-bit `.com` output on all three platforms.

## 5. Installing the Tools

### 5.1 EMU8086

1. Download the installer from emu8086.com and run it, accepting the defaults.
2. Launch EMU8086 and choose **New** to open a blank source editor.
3. Make sure the CPU Registers window and the Memory window are visible (View menu).

> **Tip:** the single-step button (**F8**) is the most useful feature in this course. Step through every program at least once rather than only running it to completion.

### 5.2 NASM

On Windows, download the installer from nasm.us, accept the defaults, and make sure NASM is added to your system PATH. Then confirm it works:

```bash
nasm -v
# expected: NASM version 2.16.xx  (any recent 2.x version is fine)
```

On a Debian or Ubuntu system:

```bash
sudo apt update
sudo apt install nasm
nasm -v
```

### 5.3 MASM and the Irvine32 library

MASM ships with Visual Studio (the free Community edition is enough — install the *Desktop development with C++* workload). The Irvine32 link library and its include file accompany the course textbook.

1. Install Visual Studio Community with the C++ desktop workload.
2. Place `Irvine32.inc` in your assembler INCLUDE directory and `Irvine32.lib` in the library directory, following the paths your instructor provides.
3. Confirm the setup by assembling Trial Program 4. If it assembles and links, your 32-bit track is ready.

## 6. Source Code Conventions

From this lab onward, every program you submit must follow the same formatting conventions used by the course textbook. Readable source is not decoration — in assembly, where a single line does very little, comments and alignment are what make a program understandable a week later.

- Begin every file with a `TITLE` line and a short header comment saying what the program does.
- Write one instruction per line, indented inside the procedure body.
- Align end-of-line comments in a single column.
- Comment the **intent**, not the obvious: what a line accomplishes, not a restatement of its mnemonic.
- Use meaningful label and variable names (`total`, `counter`, `prompt`), never single letters.
- Keep directives (`.data`, `.code`, `PROC`, `ENDP`, `END`) at the left margin.

**Not acceptable:**

```asm
; Poor - no header, no alignment, comments restate the mnemonic
mov eax,5   ; move 5 to eax
add eax,3   ; add 3
mov ebx,eax ; move eax to ebx
```

**Expected from this lab onward:**

```asm
TITLE Running Total Example              (Total.asm)
; Accumulates a running total and keeps a copy of the result.

    mov  eax, 5                          ; start the total at 5
    add  eax, 3                          ; total is now 8
    mov  ebx, eax                        ; keep a copy for later use
```

## 7. Trial Programs

Four starter files are waiting for you in `src/`. Each one contains the header block and a `TODO` marker showing what to complete. Work through them in order — each is short on purpose.

| File | Tool | What it teaches |
|---|---|---|
| `src/trial1_registers.asm` | EMU8086 (16-bit) | Data transfer and arithmetic between registers; reading the flags |
| `src/trial2_message.asm` | EMU8086 (16-bit) | Displaying a string with DOS interrupt `21h`; the `DS` setup |
| `src/trial3_hello_nasm.asm` | NASM | The command-line assemble workflow and NASM syntax |
| `src/trial4_sum_irvine32.asm` | MASM + Irvine32 (32-bit) | Keyboard input, screen output, and a counted `loop` |

### Assembling Trial Program 3

```bash
nasm -f bin src/trial3_hello_nasm.asm -o hello.com
```

Load the resulting `hello.com` in EMU8086 (**File → Load**) to single-step it, or run it under DOSBox.

> **Checkpoint:** if all four trial programs assemble and run, your environment is ready for Lab 2. If something fails, check section 10 before asking for help.

## 8. Git Workflow

You will repeat this cycle constantly for the rest of the semester:

```bash
git add .
git commit -m "Lab1: add trial program 1 (registers and flags)"
git push
```

**Commit message guidelines**

- Start with the lab number so history stays easy to scan: `Lab1: ...`
- Describe what changed, not how you felt: *add NASM hello-world program*, not *finally works!!*
- Keep it to one line under about 70 characters; put longer explanations in `notes.md`.

> **Good habit:** commit after each meaningful step, not once at the very end. Frequent, small, well-described commits are what a professional workflow looks like, and part of what is graded.

### First-time Git setup

```bash
git config --global user.name  "Your Full Name"
git config --global user.email "your.email@example.com"
```

If `git push` asks for a password and rejects it: GitHub no longer accepts account passwords over HTTPS. Create a Personal Access Token (*Settings → Developer settings → Personal access tokens*) and use it in place of your password, or set up SSH keys.

## 9. Deliverables & Submission Checklist

- [ ] `GROUP_INFO.md` completed by both members (Part 1 and Part 2).
- [ ] EMU8086, NASM, and MASM + Irvine32 installed and verified.
- [ ] `src/trial1_registers.asm` completed, assembling and running.
- [ ] `src/trial2_message.asm` completed, with your own message text.
- [ ] `src/trial3_hello_nasm.asm` completed and assembled with NASM.
- [ ] `src/trial4_sum_irvine32.asm` completed, reading and summing integers.
- [ ] All four programs follow the conventions in section 6.
- [ ] `notes.md` filled in, including the flag observations from Trial Program 1.
- [ ] Each program committed separately with a descriptive message, and pushed.

Run the structure check locally at any time:

```bash
bash scripts/check_submission.sh
```

It also runs automatically on every push — see the **Actions** tab. A green check means every required file exists and contains work; it does **not** mean your programs are correct. Correctness is reviewed by your instructor.

## 10. Evaluation Criteria

| Criterion | What it looks like |
|---|---|
| Environment works | All three toolchains installed; all four trial programs assemble and run. |
| Source formatting | Header block, one instruction per line, aligned comments explaining intent. |
| Repository quality | Meaningful commit messages and sensible frequency rather than one final commit. |
| Understanding shown | `notes.md` reflects genuine understanding, especially the flag observations. |
| Timeliness | Work pushed within the two- to three-week window so Lab 2 starts on schedule. |

## 11. Troubleshooting

| Problem | Likely fix |
|---|---|
| `nasm is not recognized` | NASM is not on your PATH. Reinstall with the PATH option enabled, or add the NASM folder manually. |
| Trial 2 runs but prints nothing readable | Almost always the `DS` setup or a missing `$` at the end of the string. Check both. |
| MASM cannot find `Irvine32.inc` / `.lib` | Include and library paths are not configured. Confirm the files sit where your instructor specified. |
| `ReadInt` accepts nothing or crashes | Confirm you included `Irvine32.inc` and that the program is assembled as 32-bit. |
| No Windows machine available | See section 4.2 — virtual machine or lab computer, DOSBox for 16-bit output locally. |

## 12. Reference

Kip R. Irvine, *Assembly Language for Intel-Based Computers*, 4th edition, Prentice Hall, 2002 — chapters 3 to 5 cover program structure, the Irvine32 library, and data transfer instructions.

## 13. Course documents (`docs/`)

| File | Content |
|---|---|
| `docs/Student_Guide_EN_AR.pdf` (and `.docx`) | Student guide in English and Arabic: marks, groups of two, GitHub and Classroom50 steps, deadlines, working online. |
| `docs/REFERENCE.md` + `docs/Irvine_4th_Edition_Cover.jpg` | Reference of the course textbook (Kip R. Irvine, *Assembly Language for Intel-Based Computers*, 4th ed.) with its cover. The book itself is not in the repository: ask the instructor by email if you cannot find a copy. |
