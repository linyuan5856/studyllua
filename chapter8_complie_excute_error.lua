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
local a=0
f=loadstring("a=a+1;print(a)")
g=function()  a=a+1 print(a)   end
f() -->33
g() -->1

--loadstring 接受变长参数
foo=assert(loadstring("local x=... return x"))
print(foo(2)) -->2

--load函数不会引发错误 只会返回 nil和一条错误信息
print(loadstring("i i")) --> nil	[string "i i"]:1: '=' expected near 'i'
print(loadfile("i i"))   --> nil	cannot open i i: No such file or directory


--8.2 C代码
--Lua提供的所有动态链接功能 都在函数 package.loadlib(path,"fooName")

print(package.loadlib("F:\Work\Lua5.1.4_b\lua-5.1.4\src\lgc.c","reallymarkobject"))

--8.3 错误 ERROR

assert(v[, message])-- v 为true 返回该参数 为 false  引发一个错误  第二个参数 message为错误信息

--等同于 if not <condition> then error end


--8.4 错误处理和异常
--pcall 以保护模式 调用第一个参数 如果正常 pcall返回true 以及 函数调用的返回值  否则 返回false 和错误信息

--8.5 错误消息和追溯
