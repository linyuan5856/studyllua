--[[Chapter22 操作系统库]]--
--文件操作 
os.remove(...) --删除文件
os.rename(...)  --文件更名

--22.1 日期和时间
--用table作为参数调用 table 有效字段 
--[[
year 完整年份
month 01-12
day   01-31
hour  00-23
min   00-59
sec   00-59
isdst Bool值 是否为 夏令时
前三个字段必要 其它默认为中午 12:00:00
]]--

print(os.time{year=2017 ,month=10, day=20})-->1508472000
print(os.time{year=1970, month=1,  day=1}) -->14400(4 hour)

--"*t" 生成一个日期table
t=os.date("*t",1508472000)

for k,v in pairs(t) do
    print(k,v)
end
--output
--[[
    hour	12
    min	0
    wday	6     --星期几  1表示 星期天
    day	20
    month	10
    year	2017
    sec	0
    yday	293   --一年的第多少天
    isdst	false
]]

print(os.date("today is %A,in %B"))  -->today is Friday,in October
print(os.date("%x",906000490))       -->09/17/98
--[[
%a
abbreviated weekday name (e.g., Wed)
%A
full weekday name (e.g., Wednesday)
%b
abbreviated month name (e.g., Sep)
%B
full month name (e.g., September)
%c
date and time (e.g., 09/16/98 23:48:10)
%d
day of the month (16) [01-31]
%H
hour, using a 24-hour clock (23) [00-23]
%I
hour, using a 12-hour clock (11) [01-12]
%M
minute (48) [00-59]
%m
month (09) [01-12]
%p
either "am" or "pm" (pm)
%S
second (10) [00-61]
%w
weekday (3) [0-6 = Sunday-Saturday]
%x
date (e.g., 09/16/98)
%X
time (e.g., 23:48:10)
%Y
full year (1998)
%y
two-digit year (98) [00-99]
%%
the character '%'
]]


--clock 计时功能
print(os.clock())  --返回当前CPU的秒数 
local x=os.clock()
local s=0

for i=1,10000000 do s=s+1 end
print(string.format( "elapsed time: %.2f\n",os.clock()-x)) --0.08


--22.2 其他系统调用
os.exit() --终止当前程序执行

os.getenv() --获取一个环境变量的值 并接受一个变量名 没有定义 返回nil
print(os.getenv("print"))-->nil

os.execute()-->运行一条系统命令
--eg
function creatDir(name )      
    os.execute("mkdir",..name)
end

