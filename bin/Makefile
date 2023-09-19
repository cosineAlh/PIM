kernal = 3
channel = 10
IMG_H = 8
IMG_W = 8

all: gen simh simv

testcases:
	python3 ../tools/testcase.py $(kernal) $(channel) $(IMG_H) $(IMG_W)

gen: testcases
	python3 ../tools/sp_gen.py $(kernal) $(channel) $(IMG_H) $(IMG_W)

simh:
	hspice -i ../src/sp/test.sp -o ../src/logs/test.lis

s2v:
	python3 ../tools/S2V.py $(kernal) $(channel) $(IMG_H) $(IMG_W)

iv: s2v
	iverilog -o ../build/testbench.out -f ../src/vsrc/verilog_file.f

simv: iv
	vvp ../build/testbench.out

test:
	python3 ../test/test.py $(IMG_H) $(IMG_W)

clean:
	rm -rf ../src/logs/* ../build/* ./*.out ./*.err
