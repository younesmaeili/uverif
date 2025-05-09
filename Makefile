tclfile=./scripts/multicore_yosys_verific.tcl
srcfile=main
TARGET_DIR=./vscale/gensva
SOURCE_DIR=./build/sva/intra_hbi
export PATH := /coatcheck/src/:$(PATH)
init:
	@echo "============ initialization =================="
	make -f Makefile.revised init
	make -f Makefile.revised
	@echo "tclfile is $(tclfile)"
	sed -i "s~tcl.*~tcl ${tclfile}~" ./scripts/run.ys
	sed -i "s~set INTRAHBI .*~set INTRAHBI -a~" $(tclfile)
	sed -i "s~set INTERHBI .*~set INTERHBI -b~" $(tclfile)
intra_hbi:
	@echo "============ Intra HBI generation ============"
	sed -i "s~set INTRAHBI .*~set INTRAHBI -a~" $(tclfile)
	sed -i "s~set INTERHBI .*~set INTERHBI -b~" $(tclfile)
	yosys -s ./scripts/run.ys -m ./build/obj/$(srcfile).so > uverif.log
	cp -r $(SOURCE_DIR) $(TARGET_DIR)

inter_hbi:
	@echo "============ Iner HBI generation ============="
	sed -i "s~set INTRAHBI .*~set INTRAHBI -intradone~" $(tclfile)
	sed -i "s~set INTERHBI .*~set INTERHBI -b~" $(tclfile)
	yosys -s ./scripts/run.ys -m ./build/obj/$(srcfile).so > uverif.log

uspec:
	@echo "============= Uarch generation ==============="
	sed -i "s~set INTRAHBI .*~set INTRAHBI -intradone~" $(tclfile)
	sed -i "s~set INTERHBI .*~set INTERHBI -interdone~" $(tclfile)
	yosys -s ./scripts/run.ys -m ./build/obj/$(srcfile).so > uverif.log
	@echo "=============== FINISH ======================="
	@echo "> result at vscale.uarch"

eval_uspec:
	@echo "============= evaluate uspec ================="
	if [ ! -d "./rtlcheck" ]; then git clone https://github.com/ymanerka/rtlcheck.git; fi
	python3 scripts/pipecheck_test.py -uarch vscale.uarch

	
clean:
	make -f Makefile.revised clean
	rm -r build/
	rm -r rtlcheck/
	rm -r check_res/ 


