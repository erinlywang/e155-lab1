-L work
-reflib pmi_work
-reflib ovi_ice40up


"C:/Users/erinwang/Desktop/E155_lab1/E155_lab1/lab1_ew/source/impl_1/top.sv" 
"C:/Users/erinwang/Desktop/E155_lab1/E155_lab1/lab1_ew/source/impl_1/sevensegment.sv" 
"C:/Users/erinwang/Desktop/E155_lab1/E155_lab1/lab1_ew/source/impl_1/clk_div.sv" 
"C:/Users/erinwang/Desktop/E155_lab1/E155_lab1/lab1_ew/source/impl_1/tb_top.sv" 
"C:/Users/erinwang/Desktop/E155_lab1/E155_lab1/lab1_ew/source/impl_1/tb_sevseg.sv" 
"C:/Users/erinwang/Desktop/E155_lab1/E155_lab1/lab1_ew/source/impl_1/tb_clkdiv.sv" 
-sv
-optionset VOPTDEBUG
+noacc+pmi_work.*
+noacc+ovi_ice40up.*

-vopt.options
  -suppress vopt-7033
-end

-gui
-top tb_top
-vsim.options
  -suppress vsim-7033,vsim-8630,3009,3389
-end

-do "view wave"
-do "add wave /*"
-do "run 100 ns"
