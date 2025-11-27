tui new-layout dbgasm {-horizontal asm 1 regs 1} 2 cmd 1
layout source
handle SIGSEGV stop print
handle SIGABRT stop print
handle SIGBUS stop print
