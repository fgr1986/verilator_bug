#include "Vtb_top.h"
#include "verilated.h"
int main(int argc, char **argv) {
  VerilatedContext *m_contextp = new VerilatedContext; // Context
  // VerilatedVcdC *m_tracep = new VerilatedVcdC;         // Trace
  // Vtb_top *m_duvp = new Vtb_top;                 // Design
  // Trace configuration
  m_contextp->traceEverOn(true); // Turn on trace switch in context
  m_contextp->commandArgs(argc, argv);
  Vtb_top *top = new Vtb_top{m_contextp};
  while (!m_contextp->gotFinish()) {
    top->eval();
    // Increase simulation time
    m_contextp->timeInc(1);
  }
  delete top;
  delete m_contextp;
  return 0;
}
