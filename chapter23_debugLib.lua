--[[Chapter23 调试库]]--

--23.1 自省机制
--debug.getinfo()  1.参数是函数 2.参数是栈层

function  foo(i )
    t=debug.getinfo( foo)
    for k,v in pairs(t) do
        print(k,v)
    end
    return 1+i
end

foo(1)
--output
--[[
nups	0
what	Lua
func	function: 0052BCD8
lastlinedefined	7
source	@f:\Study\Lua\studyllua\tempCodeRunnerFile.lua
currentline	-1
namewhat	
linedefined	1
short_src	f:\Study\Lua\studyllua\tempCodeRunnerFile.lua
]]

--23.1.1 访问局部变量
--debug.getlocal( [thread],f[, local] ) //第一个参数:函数栈层 第二个参数：变量的索引
--局部变量在函数中的出现顺序为它们的编号  a,b,x,a -->1,2,3,4
function foo( a,b )
    local x
    do local c=a-b end   --c不在作用域内
    local a=1
    while true do 
        local name,value=debug.getlocal(1,a）
        if not name then break end 
        print(name,value)
        a=a+1
    end
end

foo(10,20)
--output
--[[
a	10
b	20
x	nil
a	4
]]

debug.setlocal( [thead,]level, local, value )--同get  第三个参数为新的 value

--23.1.2 访问非局部变量
debug.getupvalue( f, up )  --第一个参数:函数  第二个参数:变量索引
debug.setupvalue( f, up, value )

--23.1.3 访问其他协同程序
co=coroutine.create( function()local x=10 
    coroutine.yield(  ) 
    error("some error")
end
)

coroutine.resume(co)
print(debug.traceback( co))
--output
--[[
    stack traceback:
	[C]: in function 'yield'
	f:\Study\Lua\studyllua\tempCodeRunnerFile.lua:2: in function <f:\Study\Lua\studyllua\tempCodeRunnerFile.lua:1>
]]
print(coroutine.resume(co))
--output
--[[
    stack traceback:
	[C]: in function 'yield'
	f:\Study\Lua\studyllua\tempCodeRunnerFile.lua:2: in function <f:\Study\Lua\studyllua\tempCodeRunnerFile.lua:1>
false	f:\Study\Lua\studyllua\tempCodeRunnerFile.lua:3: some error
]]

--23.2 钩子
--call ,return ,line ,count
function trace(event,line)
    local s=debug.getinfo(2).short_src;
    print(s..":"..line)
end

debug.sethook(trace, "l" )

print("hello world") 
--[[
f:\Study\Lua\studyllua\tempCodeRunnerFile.lua:8
hello world
]]

--23.3 性能剖析
