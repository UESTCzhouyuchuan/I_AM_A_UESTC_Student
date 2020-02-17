#NMAKE工具的描述文件
NAME = Common					#指定输出文件
MOD1 = Main					#指定输出文件
MOD2 = Sub					#指定输出文件
EXE  = $(NAME).exe				#需要的EXE文件
OBJS = $(MOD1).obj $(MOD2).obj			#需要的OBJ文件
MAP  = $(NAME).map				#可选的MAP文件
LST  = $(NAME).lst				#可选的LST文件
CRF  = $(NAME).crf				#可选的CRF文件
LIB  = NUL.lib					#可选的LIB文件


LINK_FLAG = ,$(EXE),$(MAP),,$(LIB)		#链接选项
ML_FLAG   = ,,$(LST),$(CRF)			#编译选项

#定义依赖关系和执行命令
$(EXE): $(OBJS)
	Link $(OBJS) $(LINK_FLAG)

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