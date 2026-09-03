vlib work
vlog *.*v
vsim -voptargs=+acc work.ASYNC_FIFO_TEST
do wave.do
run -all