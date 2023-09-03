import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, Timer, ClockCycles
#import numpy as np

#h_n = [1, 1, 1, 1]
#y_n = np.convolve(x_n, h_n)

@cocotb.test()
async def test_fir(dut):
    x_n = [ 6, 16, 9, 7, 2, 19, 14, 7, 17, 13 ]
    y_n = [24,  82,  96,  93,  63, 105, 124, 110, 136, 131,  80,  43, 13]



    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # reset
    dut._log.info("reset")
    dut.rst_n.value = 0
    dut.ena.value = 0
    dut.uio_in.value = 0
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    

    await ClockCycles(dut.clk, 5)
    dut.ena.value = 1
    dut._log.info("Enabling design")
    await ClockCycles(dut.clk, 5)
    await FallingEdge(dut.clk)
    for i in range(4):
        
        dut.ui_in.value = (((4-i << 2) + i) <<1) + 1
        #dut.ui_in[0].value = 1
        #dut.ui_in[1:2].value = i
        #dut.ui_in[3:7].value = 4-i
        await FallingEdge(dut.clk)

   
    dut.ui_in.value = 0
    dut._log.info("Sending x_n values")
    # Input the  x_n values
    await FallingEdge(dut.clk) 
    for i in range(len(x_n)):
        
        dut._log.info(f"Input value x_n: {i}:{dut.uio_in.value} ")
        dut.uio_in.value = x_n[i]
        await FallingEdge(dut.clk)

        assert int(dut.uio_out.value) == y_n[i]

    # reset
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 40)


@cocotb.test()
async def test_fir_1s(dut):
    x_n = [ 6, 16, 9, 7, 2, 19, 14, 7, 17, 13 ]
    y_n = [6, 22, 31, 38, 34, 37, 42, 42, 57, 51, 37, 30, 13]

    dut._log.info("start")
    clock = Clock(dut.clk, 10, units="ns")
    cocotb.start_soon(clock.start())

    # reset
    dut._log.info("reset")
    dut.rst_n.value = 0
    dut.ena.value = 0
    dut.uio_in.value = 0
    dut.ui_in.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1


    await ClockCycles(dut.clk, 5)
    dut.ena.value = 1
    dut._log.info("Enabling design")
    await ClockCycles(dut.clk, 5)

    dut._log.info("Sending x_n values")
    # Input the  x_n values
    await FallingEdge(dut.clk)
    for i in range(len(x_n)):

        dut._log.info(f"Input value x_n: {i}:{dut.uio_in.value} ")
        dut.uio_in.value = x_n[i]
        await FallingEdge(dut.clk)

        assert int(dut.uio_out.value) == y_n[i]

    # reset
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 40)
