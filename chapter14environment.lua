--[[Chapter14 环境]]
--lua将环境table 自身保存在一个全局变量 _G 中

for i,v in pairs(_G) do
    print(i,v)
end
--output
--[[string	table: 005AEBC0
xpcall	function: 007673C8
package	table: 005AE878
tostring	function: 00767328
print	function: 005ADFD0
os	table: 005AEB48
unpack	function: 00767388
require	function: 007678A8
getfenv	function: 005ADE70
setmetatable	function: 007672E8
next	function: 005ADF50
assert	function: 005ADD50
tonumber	function: 00767308
io	table: 005AEA08
rawequal	function: 005AE010
collectgarbage	function: 005ADD90
arg	table: 0076B3B8
getmetatable	function: 005ADEB0
module	function: 00767868
rawset	function: 00767228
math	table: 005AEC38
debug	table: 005AEC88
pcall	function: 005ADF90
table	table: 005AE918
newproxy	function: 005AE4E0
type	function: 00767348
coroutine	table: 005AE7D8
_G	table: 00761C88
select	function: 00767268
gcinfo	function: 005ADE30
pairs	function: 005AE4B0
rawget	function: 007671E8
loadstring	function: 005ADF30
ipairs	function: 00766E90
_VERSION	Lua 5.1
dofile	function: 005ADDB0
setfenv	function: 007672A8
load	function: 005ADEF0
error	function: 005ADDF0
loadfile	function: 005ADED0 ]]--

--14.1 具有动态名字的全局变量
--14.2 全局变量申明
--检查此赋值是否在主程序块
__newindex=function(t,n,v)
local w=debug.getinfo(2,"S").what
if w~="main" and w~="C" then
  error("attempt to write to undeclared variable"..n,2)
end
 rawset(t,n,v)  --可以绕过元表 赋值
end
--14.3 非全局的环境

--1.setfenv 第一个参数 除了可以指定为函数本身 还可以指定一个数字 表示当前函数调用栈中的层数 数字1当前函数 数字2表示调用当前函数的函数

a=1
setfenv (1,{g=_G})  --原来的全局变量环境 会被替换--失效

--print("5")  --attempt to call global 'print' (a nil value)
g.print("5")  --5
g.print (a)   --nil
g.print(g.a)  --1

--2.通过继承组装新环境
a=1 
local newgt={}
setmetatable(newgt,{__index=_G})
setfenv(1,newgt)
print(a)  --1   新环境继承了原来环境的print 和 a

a=10
print(a)  --10   新环境的a
print(_G.a) --1  原环境_G 的a  依旧是1
_G.a=20
print(_G.a)  --20