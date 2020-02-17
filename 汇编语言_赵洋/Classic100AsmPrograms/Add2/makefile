#NMAKE工具的描述文件
NAME = Add2				#指定输出文件
EXE = $(NAME).exe			#需要的EXE文件
OBJ = $(NAME).obj			#需要的OBJ文件
LST = $(NAME).lst			#可选的LST文件
CRF = $(NAME).crf			#可选的CRF文件
MAP = $(NAME).map                       #可选的MAP文件
DEF =   				#可选的DEF文件
LIB = NUL				#可选的LIB文件

LINK_FLAG = ,$(EXE),$(MAP),$(DEF),$(LIB)#链接选项
ML_FLAG   = $(OBJ) $(LST) $(CRF)	#编译选项

#定义依赖关系和执行命令
$(EXE): $(OBJ)
	Link $(OBJ) $(LINK_FLAG) 

#定义汇编编译和资源编译得默认规则
.asm.obj:
	masm $< $(ML_FLAG)

#清除临时文件
clean:
	del *.MAP
	del *.CRF
	del *.LST
	del *.OBJ
	del *.BAK