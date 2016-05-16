
########## Tcl recorder starts at 11/22/15 00:59:26 ##########

set version "2.0"
set proj_dir "D:/Projects/RGBMatrixPanel_CPLD/hardware"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 00:59:26 ###########


########## Tcl recorder starts at 11/22/15 00:59:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 00:59:49 ###########


########## Tcl recorder starts at 11/22/15 01:00:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 01:00:23 ###########


########## Tcl recorder starts at 11/22/15 01:00:32 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 01:00:32 ###########


########## Tcl recorder starts at 11/22/15 01:01:00 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 01:01:00 ###########


########## Tcl recorder starts at 11/22/15 01:01:02 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 01:01:02 ###########


########## Tcl recorder starts at 11/22/15 01:01:54 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 01:01:54 ###########


########## Tcl recorder starts at 11/22/15 01:01:59 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 01:01:59 ###########


########## Tcl recorder starts at 11/22/15 01:02:06 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 01:02:06 ###########


########## Tcl recorder starts at 11/22/15 01:02:20 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/blifstat\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src rgbmatrixpanel_cpld.bl5 -type BLIF -presrc rgbmatrixpanel_cpld.bl3 -crf rgbmatrixpanel_cpld.crf -sif rgbmatrixpanel_cpld.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_32_30.dev\" -lci rgbmatrixpanel_cpld.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 01:02:20 ###########


########## Tcl recorder starts at 11/22/15 01:10:47 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 11/22/15 01:10:47 ###########


########## Tcl recorder starts at 12/17/15 01:46:43 ##########

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src rgbmatrixpanel_cpld.bl5 -type BLIF -presrc rgbmatrixpanel_cpld.bl3 -crf rgbmatrixpanel_cpld.crf -sif rgbmatrixpanel_cpld.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_32_30.dev\" -lci rgbmatrixpanel_cpld.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 12/17/15 01:46:43 ###########


########## Tcl recorder starts at 01/07/16 00:10:13 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:10:14 ###########


########## Tcl recorder starts at 01/07/16 00:11:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:11:06 ###########


########## Tcl recorder starts at 01/07/16 00:11:24 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:11:24 ###########


########## Tcl recorder starts at 01/07/16 00:11:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:11:32 ###########


########## Tcl recorder starts at 01/07/16 00:19:19 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:19:19 ###########


########## Tcl recorder starts at 01/07/16 00:19:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:19:21 ###########


########## Tcl recorder starts at 01/07/16 00:20:38 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:20:38 ###########


########## Tcl recorder starts at 01/07/16 00:20:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:20:49 ###########


########## Tcl recorder starts at 01/07/16 00:21:43 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:21:43 ###########


########## Tcl recorder starts at 01/07/16 00:21:48 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:21:48 ###########


########## Tcl recorder starts at 01/07/16 00:23:18 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:23:18 ###########


########## Tcl recorder starts at 01/07/16 00:23:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:23:35 ###########


########## Tcl recorder starts at 01/07/16 00:23:48 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:23:48 ###########


########## Tcl recorder starts at 01/07/16 00:24:08 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:24:08 ###########


########## Tcl recorder starts at 01/07/16 00:25:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:25:21 ###########


########## Tcl recorder starts at 01/07/16 00:25:23 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:25:23 ###########


########## Tcl recorder starts at 01/07/16 00:25:40 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/07/16 00:25:40 ###########


########## Tcl recorder starts at 01/10/16 22:12:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:12:01 ###########


########## Tcl recorder starts at 01/10/16 22:12:05 ##########

# Commands to make the Process: 
# Compile EDIF File
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:12:05 ###########


########## Tcl recorder starts at 01/10/16 22:12:22 ##########

# Commands to make the Process: 
# Fit Design
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:12:22 ###########


########## Tcl recorder starts at 01/10/16 22:16:56 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:16:56 ###########


########## Tcl recorder starts at 01/10/16 22:17:27 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:17:27 ###########


########## Tcl recorder starts at 01/10/16 22:17:32 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:17:32 ###########


########## Tcl recorder starts at 01/10/16 22:19:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:19:34 ###########


########## Tcl recorder starts at 01/10/16 22:19:46 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:19:46 ###########


########## Tcl recorder starts at 01/10/16 22:19:51 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:19:51 ###########


########## Tcl recorder starts at 01/10/16 22:21:22 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:21:22 ###########


########## Tcl recorder starts at 01/10/16 22:21:37 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:21:37 ###########


########## Tcl recorder starts at 01/10/16 22:22:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:22:11 ###########


########## Tcl recorder starts at 01/10/16 22:22:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:22:25 ###########


########## Tcl recorder starts at 01/10/16 22:22:31 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:22:31 ###########


########## Tcl recorder starts at 01/10/16 22:29:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:29:39 ###########


########## Tcl recorder starts at 01/10/16 22:29:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:29:43 ###########


########## Tcl recorder starts at 01/10/16 22:32:41 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:32:41 ###########


########## Tcl recorder starts at 01/10/16 22:32:45 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:32:45 ###########


########## Tcl recorder starts at 01/10/16 22:33:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:33:55 ###########


########## Tcl recorder starts at 01/10/16 22:33:58 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:33:58 ###########


########## Tcl recorder starts at 01/10/16 22:37:06 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:37:06 ###########


########## Tcl recorder starts at 01/10/16 22:37:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:37:17 ###########


########## Tcl recorder starts at 01/10/16 22:37:34 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:37:34 ###########


########## Tcl recorder starts at 01/10/16 22:41:58 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:41:58 ###########


########## Tcl recorder starts at 01/10/16 22:42:04 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 22:42:04 ###########


########## Tcl recorder starts at 01/10/16 23:27:45 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 23:27:45 ###########


########## Tcl recorder starts at 01/10/16 23:27:54 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 23:27:54 ###########


########## Tcl recorder starts at 01/10/16 23:48:35 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 23:48:35 ###########


########## Tcl recorder starts at 01/10/16 23:48:43 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 23:48:43 ###########


########## Tcl recorder starts at 01/10/16 23:50:55 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 23:50:55 ###########


########## Tcl recorder starts at 01/10/16 23:50:59 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/10/16 23:50:59 ###########


########## Tcl recorder starts at 01/11/16 00:05:39 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:05:39 ###########


########## Tcl recorder starts at 01/11/16 00:06:25 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:06:25 ###########


########## Tcl recorder starts at 01/11/16 00:06:29 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:06:29 ###########


########## Tcl recorder starts at 01/11/16 00:15:01 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:15:01 ###########


########## Tcl recorder starts at 01/11/16 00:15:04 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:15:04 ###########


########## Tcl recorder starts at 01/11/16 00:21:33 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:21:33 ###########


########## Tcl recorder starts at 01/11/16 00:21:39 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:21:39 ###########


########## Tcl recorder starts at 01/11/16 00:25:49 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:25:49 ###########


########## Tcl recorder starts at 01/11/16 00:26:47 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:26:47 ###########


########## Tcl recorder starts at 01/11/16 00:28:11 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:28:11 ###########


########## Tcl recorder starts at 01/11/16 00:28:14 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 01/11/16 00:28:14 ###########


########## Tcl recorder starts at 05/11/16 23:46:56 ##########

set version "2.0"
set proj_dir "D:/Projects/RGBMatrixPanelCPLD-PhotonBackpack/hardware"
cd $proj_dir

# Get directory paths
set pver $version
regsub -all {\.} $pver {_} pver
set lscfile "lsc_"
append lscfile $pver ".ini"
set lsvini_dir [lindex [array get env LSC_INI_PATH] 1]
set lsvini_path [file join $lsvini_dir $lscfile]
if {[catch {set fid [open $lsvini_path]} msg]} {
	 puts "File Open Error: $lsvini_path"
	 return false
} else {set data [read $fid]; close $fid }
foreach line [split $data '\n'] { 
	set lline [string tolower $line]
	set lline [string trim $lline]
	if {[string compare $lline "\[paths\]"] == 0} { set path 1; continue}
	if {$path && [regexp {^\[} $lline]} {set path 0; break}
	if {$path && [regexp {^bin} $lline]} {set cpld_bin $line; continue}
	if {$path && [regexp {^fpgapath} $lline]} {set fpga_dir $line; continue}
	if {$path && [regexp {^fpgabinpath} $lline]} {set fpga_bin $line}}

set cpld_bin [string range $cpld_bin [expr [string first "=" $cpld_bin]+1] end]
regsub -all "\"" $cpld_bin "" cpld_bin
set cpld_bin [file join $cpld_bin]
set install_dir [string range $cpld_bin 0 [expr [string first "ispcpld" $cpld_bin]-2]]
regsub -all "\"" $install_dir "" install_dir
set install_dir [file join $install_dir]
set fpga_dir [string range $fpga_dir [expr [string first "=" $fpga_dir]+1] end]
regsub -all "\"" $fpga_dir "" fpga_dir
set fpga_dir [file join $fpga_dir]
set fpga_bin [string range $fpga_bin [expr [string first "=" $fpga_bin]+1] end]
regsub -all "\"" $fpga_bin "" fpga_bin
set fpga_bin [file join $fpga_bin]

if {[string match "*$fpga_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$fpga_bin;$env(PATH)" }

if {[string match "*$cpld_bin;*" $env(PATH)] == 0 } {
   set env(PATH) "$cpld_bin;$env(PATH)" }

lappend auto_path [file join $install_dir "ispcpld" "tcltk" "lib" "ispwidget" "runproc"]
package require runcmd

# Commands to make the Process: 
# Constraint Editor
if [runCmd "\"$cpld_bin/blifstat\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.sif"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
# Application to view the Process: 
# Constraint Editor
if [catch {open lattice_cmd.rs2 w} rspFile] {
	puts stderr "Cannot create response file lattice_cmd.rs2: $rspFile"
} else {
	puts $rspFile "-nodal -src rgbmatrixpanel_cpld.bl5 -type BLIF -presrc rgbmatrixpanel_cpld.bl3 -crf rgbmatrixpanel_cpld.crf -sif rgbmatrixpanel_cpld.sif -devfile \"$install_dir/ispcpld/dat/lc4k/m4s_32_30.dev\" -lci rgbmatrixpanel_cpld.lct
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lciedit\" @lattice_cmd.rs2"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/11/16 23:46:56 ###########


########## Tcl recorder starts at 05/12/16 00:24:21 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/12/16 00:24:21 ###########


########## Tcl recorder starts at 05/12/16 01:39:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/12/16 01:39:34 ###########


########## Tcl recorder starts at 05/13/16 00:40:20 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/13/16 00:40:20 ###########


########## Tcl recorder starts at 05/15/16 22:40:17 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/15/16 22:40:17 ###########


########## Tcl recorder starts at 05/15/16 22:40:23 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/15/16 22:40:23 ###########


########## Tcl recorder starts at 05/15/16 22:40:31 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/15/16 22:40:31 ###########


########## Tcl recorder starts at 05/15/16 22:40:34 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/15/16 22:40:34 ###########


########## Tcl recorder starts at 05/15/16 22:40:41 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/15/16 22:40:41 ###########


########## Tcl recorder starts at 05/15/16 22:41:15 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/15/16 22:41:15 ###########


########## Tcl recorder starts at 05/15/16 22:41:19 ##########

# Commands to make the Process: 
# Fit Design
if [catch {open SPI_to_RGBMatrixPanel.cmd w} rspFile] {
	puts stderr "Cannot create response file SPI_to_RGBMatrixPanel.cmd: $rspFile"
} else {
	puts $rspFile "STYFILENAME: rgbmatrixpanel_cpld.sty
PROJECT: SPI_to_RGBMatrixPanel
WORKING_PATH: \"$proj_dir\"
MODULE: SPI_to_RGBMatrixPanel
VERILOG_FILE_LIST: \"$install_dir/ispcpld/../cae_library/synthesis/verilog/mach.v\" rgbmatrixpanel_cpld.h spi_to_rgbmatrixpanel.v
OUTPUT_FILE_NAME: SPI_to_RGBMatrixPanel
SUFFIX_NAME: edi
Vlog_std_v2001: true
FREQUENCY:  200
FANIN_LIMIT:  20
DISABLE_IO_INSERTION: false
MAX_TERMS_PER_MACROCELL:  16
MAP_LOGIC: false
SYMBOLIC_FSM_COMPILER: true
NUM_CRITICAL_PATHS:   3
AUTO_CONSTRAIN_IO: true
NUM_STARTEND_POINTS:   0
AREADELAY:  0
WRITE_PRF: true
RESOURCE_SHARING: true
COMPILER_COMPATIBLE: true
DUP: false
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/Synpwrap\" -rem -e SPI_to_RGBMatrixPanel -target ispmach4000b -pro "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete SPI_to_RGBMatrixPanel.cmd
if [runCmd "\"$cpld_bin/edif2blf\" -edf SPI_to_RGBMatrixPanel.edi -out SPI_to_RGBMatrixPanel.bl0 -err automake.err -log SPI_to_RGBMatrixPanel.log -prj rgbmatrixpanel_cpld -lib \"$install_dir/ispcpld/dat/mach.edn\" -net_Vcc VCC -net_GND GND -nbx -dse -tlw -cvt YES -xor"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" SPI_to_RGBMatrixPanel.bl0 -collapse none -reduce none -err automake.err  -keepwires"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblflink\" \"SPI_to_RGBMatrixPanel.bl1\" -o \"rgbmatrixpanel_cpld.bl2\" -omod \"rgbmatrixpanel_cpld\"  -err \"automake.err\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/impsrc\"  -prj rgbmatrixpanel_cpld -lci rgbmatrixpanel_cpld.lct -log rgbmatrixpanel_cpld.imp -err automake.err -tti rgbmatrixpanel_cpld.bl2 -dir $proj_dir"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -blifopt rgbmatrixpanel_cpld.b2_"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mblifopt\" rgbmatrixpanel_cpld.bl2 -sweep -mergefb -err automake.err -o rgbmatrixpanel_cpld.bl3 @rgbmatrixpanel_cpld.b2_ "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -diofft rgbmatrixpanel_cpld.d0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/mdiofft\" rgbmatrixpanel_cpld.bl3 -family AMDMACH -idev van -o rgbmatrixpanel_cpld.bl4 -oxrf rgbmatrixpanel_cpld.xrf -err automake.err @rgbmatrixpanel_cpld.d0 "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/abelvci\" -vci rgbmatrixpanel_cpld.lct -dev lc4k -prefit rgbmatrixpanel_cpld.l0"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/prefit\" -blif -inp rgbmatrixpanel_cpld.bl4 -out rgbmatrixpanel_cpld.bl5 -err automake.err -log rgbmatrixpanel_cpld.log -mod SPI_to_RGBMatrixPanel @rgbmatrixpanel_cpld.l0  -sc"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [catch {open rgbmatrixpanel_cpld.rs1 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs1: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -nojed -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [catch {open rgbmatrixpanel_cpld.rs2 w} rspFile] {
	puts stderr "Cannot create response file rgbmatrixpanel_cpld.rs2: $rspFile"
} else {
	puts $rspFile "-i rgbmatrixpanel_cpld.bl5 -lci rgbmatrixpanel_cpld.lct -d m4s_32_30 -lco rgbmatrixpanel_cpld.lco -html_rpt -fti rgbmatrixpanel_cpld.fti -fmt PLA -tto rgbmatrixpanel_cpld.tt4 -eqn rgbmatrixpanel_cpld.eq3 -tmv NoInput.tmv
-rpt_num 1
"
	close $rspFile
}
if [runCmd "\"$cpld_bin/lpf4k\" \"@rgbmatrixpanel_cpld.rs2\""] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
file delete rgbmatrixpanel_cpld.rs1
file delete rgbmatrixpanel_cpld.rs2
if [runCmd "\"$cpld_bin/tda\" -i rgbmatrixpanel_cpld.bl5 -o rgbmatrixpanel_cpld.tda -lci rgbmatrixpanel_cpld.lct -dev m4s_32_30 -family lc4k -mod SPI_to_RGBMatrixPanel -ovec NoInput.tmv -err tda.err "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}
if [runCmd "\"$cpld_bin/synsvf\" -exe \"$install_dir/ispvmsystem/ispufw\" -prj rgbmatrixpanel_cpld -if rgbmatrixpanel_cpld.jed -j2s -log rgbmatrixpanel_cpld.svl "] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/15/16 22:41:19 ###########


########## Tcl recorder starts at 05/15/16 23:59:05 ##########

# Commands to make the Process: 
# Hierarchy
if [runCmd "\"$cpld_bin/vlog2jhd\" spi_to_rgbmatrixpanel.v -p \"$install_dir/ispcpld/generic\" -predefine rgbmatrixpanel_cpld.h"] {
	return
} else {
	vwait done
	if [checkResult $done] {
		return
	}
}

########## Tcl recorder end at 05/15/16 23:59:05 ###########

