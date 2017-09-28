--[[  Chapter 8  编译 错误 与 执行]]

-- 8.1 编译
-- loadfile 函数 会从一个文件加载lua代码块并编译 将编译结果当做一个函数返回（返回错误值 不处理错误）
-- dofile 先 loadfile 再执行文件代码  (处理错误)
--loadstring 函数 从一个字符串读取代码
i=0
s="i=i+1"
f=loadstring(s)
f()
print(i)

--loadstring  在全局环境编译 它的字符串
a=32
local a=32
f=loadstring("a=a+1;print(a)")
g=fuction() a=a+1 print(a) end
f()
g()