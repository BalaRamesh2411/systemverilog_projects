
vlib work

vlog -sv tb_top.v

vsim -voptargs="+acc" work.tb_top

add wave -r *

run -all

