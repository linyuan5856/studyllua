--[[Chapter17 弱引用 table]]--

--弱引用table: 具有弱引用条目的table
--三种弱引用table  1.弱引用key的table 2.弱引用value的table 3.同事具有两种弱引用table

--  __mode="k"  table的key是弱引用
--  __mode="v"  table的value是弱引用
--lua 只会回收弱引用table中的对象 bool number string 不会被回收
a={}
b={__mode="k"}
setmetatable(a, b)  --a的key是弱引用

key={}
a[key]=1
print(key)  --table: 0055B4A8
key={}
print(key)  --table: 0055B548
a[key]=2

for k,v in pairs(a) do
    print(v)    --output  1,2
end

collectgarbage()

for k,v in pairs(a) do  --第一个key 被回收
    print(v)    --output  2
end

--17.1 备忘录
--eg Creat色彩
local mt={}
setmetatable(mt,{__mode="v"})
function CreatRGB(r,g,b )
local key=r.."-"..g.."-"..b
local res=mt[key]

 if res == nil then 
    res={R=r,G=g,B=b} 
    mt[key]=res
  end    
  return res
end

--test
t=CreatRGB(127,0,255)

for k,v in pairs(t) do 
    print(k.." -- "..v)
end 
--output 
--[[
B -- 255
G -- 0
R -- 127]]--

--17.2 对象属性
--17.3 回顾table的默认值
--1.使用一个弱引用 table ,将它和每个table的默认值关联起来
local defaults={}
setmetatable(defaults,{__mode="k"})
local mt={__index=function(t)
   return defaults[t]
end}

function SetDefault(t,d)
    defaults[t]=d
    setmetatable(t,mt)
end

--test:
t={}
SetDefault(t,10)
print(t[a]) --10

--2.对每种不同的默认值使用不同的元表
local mt={}
setmetatable(mt,{__mode="v"})
function SetDefault(t,d )
    local res=mt[d]

    if res==nil then
       res={__index=function()return d end }
       mt[d]=res
    end
    setmetatable(t,res)
end

--test
t={}
SetDefault(t,500)
print(t[b]) --500