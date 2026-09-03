onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group {write_data & full_flag} -color {Dark Orchid} /ASYNC_FIFO_TEST/DUT/W_CLK
add wave -noupdate -expand -group {write_data & full_flag} -color {Dark Orchid} /ASYNC_FIFO_TEST/DUT/W_RST
add wave -noupdate -expand -group {write_data & full_flag} /ASYNC_FIFO_TEST/DUT/W_inc
add wave -noupdate -expand -group {write_data & full_flag} -color Cyan -radix hexadecimal /ASYNC_FIFO_TEST/DUT/W_data
add wave -noupdate -expand -group {write_data & full_flag} -color Green /ASYNC_FIFO_TEST/DUT/W_addr
add wave -noupdate -expand -group {write_data & full_flag} -color Green /ASYNC_FIFO_TEST/DUT/W_ptr
add wave -noupdate -expand -group {write_data & full_flag} -color Green /ASYNC_FIFO_TEST/DUT/wq2_rptr
add wave -noupdate -expand -group {write_data & full_flag} -color Cyan /ASYNC_FIFO_TEST/DUT/W_full
add wave -noupdate -expand -group memory_buffer -radix hexadecimal -childformat {{{/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[7]} -radix hexadecimal} {{/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[6]} -radix hexadecimal} {{/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[5]} -radix hexadecimal} {{/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[4]} -radix hexadecimal} {{/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[3]} -radix hexadecimal} {{/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[2]} -radix hexadecimal} {{/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[1]} -radix hexadecimal} {{/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[0]} -radix hexadecimal}} -expand -subitemconfig {{/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[7]} {-height 15 -radix hexadecimal} {/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[6]} {-height 15 -radix hexadecimal} {/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[5]} {-height 15 -radix hexadecimal} {/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[4]} {-height 15 -radix hexadecimal} {/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[3]} {-height 15 -radix hexadecimal} {/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[2]} {-height 15 -radix hexadecimal} {/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[1]} {-height 15 -radix hexadecimal} {/ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem[0]} {-height 15 -radix hexadecimal}} /ASYNC_FIFO_TEST/DUT/FIFO_MEM_CNTRL/mem
add wave -noupdate -expand -group {read_data & empty_flag} -color {Dark Orchid} /ASYNC_FIFO_TEST/DUT/R_CLK
add wave -noupdate -expand -group {read_data & empty_flag} -color {Dark Orchid} /ASYNC_FIFO_TEST/DUT/R_RST
add wave -noupdate -expand -group {read_data & empty_flag} /ASYNC_FIFO_TEST/DUT/R_inc
add wave -noupdate -expand -group {read_data & empty_flag} -color Green /ASYNC_FIFO_TEST/DUT/R_addr
add wave -noupdate -expand -group {read_data & empty_flag} -color Green /ASYNC_FIFO_TEST/DUT/R_ptr
add wave -noupdate -expand -group {read_data & empty_flag} -color Green /ASYNC_FIFO_TEST/DUT/rq2_wptr
add wave -noupdate -expand -group {read_data & empty_flag} -color Cyan /ASYNC_FIFO_TEST/DUT/R_empty
add wave -noupdate -expand -group {read_data & empty_flag} -color Cyan -radix hexadecimal /ASYNC_FIFO_TEST/DUT/R_data
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {104624 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 230
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {83833 ps} {322937 ps}
