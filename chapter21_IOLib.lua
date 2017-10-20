--[[Chapter21 I/O 库]]

--21.1 简单 I/O模型
s=io.input("chapter21file.txt")
print(s)                       -->file (77851BD8)
--io.write("EnjoyCoding")      --EnjoyCoding
print(io.read())               -->i like coding  //chapter21file的内容
s2=io.input("f:/Study/1.txt")  -->切换只读模式指定文件
print(s2)                      -->file (77B01BF8)
print(io.read())               -->1232
print(io.read("*line"))        -->nil  读取下一行

--io.read() //参数部分   "*all" 读取整个文件  "*line" 读取下一行 "*number" 读取一个数字   <num> 读取一个不超过<num>个字符的字符串

--io.write  和 print 的区别
--1.io.write 输出时 不会添加制表符 或回车等额外字符
--2.io.write 使用当前输出文件  而print 总是使用标准输出

--21.2 完整I/O模型
--io.popen(...)  第一个参数 文件名  第二个参数 模式字符串  r 读取 w 写入  a 追加  b 二进制文件
print(io.popen("chapter21file.txt","r"))-->打开了文档 返回 file (77E91BD8)

--读写操作
local f=assert(io.popen("chapter21file,txt","r"))
local t=f:read("*all")
print(t)  --乱码。。。 
f:close()

--21.2.1 性能小技巧
--用块来读取大文件
local lines,rest=f:read(BUFSIZE,"*line")-->rest 剩余部分

--eg
local BUFSIZE=2^13    --(2^9*2^4) ... 1024*8
print(BUFSIZE)        -->8192  8k

local f=io.input("chapter21file2.txt")

local cc,lc,wc=0,0,0 --字符,行,单词计数
while true do 
    local lines,rest=f:read(BUFSIZE,"*line");
    if not lines then break end
    if rest then lines=lines .. rest.. "\n" end
    cc=cc+#lines  --统计单词数
    local _,t=string.gsub( lines,"%S+","")
    wc=wc+t       --统计换行符
    _,t=string.gsub( lines,"\n","\n")
    lc=lc+t    --统计行
end

print("行数"..lc)            --69
print("字符串总数"..cc)      --18266
print("换行符数",wc)         --62

--21.2.2 二进制文件
--21.2.3 其他文件操作