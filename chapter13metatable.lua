--[[元表与元方法]]--
t={}
print(getmetatable(t))  --nil
setmetatable(t,{})       --添加元表
print(getmetatable(t))  --table:007AB438  


--13.1 算数类的元方法 --
--[[ __add (加法) __mul(乘法) __sub(减法) __div(除法) __unm(相反数) __mod(取模) __pow(乘幂)]]--

set={}
local mt={}

--[[
setmetatable(set, metaT)
print(metaT)             --table: 004BB3E8
print(getmetatable(set)) --table: 004BB3E8
]]--

function set.new(t)
   local res={}
   setmetatable(res, mt)
   for _,v in pairs(t) do res[v]=true end
   return res
end


function set.union(x,y)
    local res=set.new{}
    for k in pairs(x) do res[k]=true end
    for k in pairs(y) do res[k]=true end    
    return res
end

function set.tostring(set)
local l={}
for e in pairs(set) do
l[#l+1]=e
end
  return "{"  .. table.concat(l,",") .. "}"
end

function set.print(s)
  print(set.tostring(s))
end


s1=set.new{20,30}
s2=set.new{20,3,4}

--print(getmetatable(s1))  --table: 003DB3E8
--print(getmetatable(s2))  --table: 003DB3E8
mt.__add=set.union
s3=s1+s2

set.print(s3)

--Lua查找元表的步骤  1.如果第一个值 有元表且有__add字段 2.如果第二个值 有元表且有__add字段 3.第一个第二个 都没有 引发错误

--13.2 关系类的元方法
--[[__eq 等于 __lt 小于 __lq 小于等于]]
--[[将 a~=b 转换为 not (a==b)  a>b转化为 b>a a>=b 转换为 b<=a ]]


--13.3 库定义的元方法
--[[__metatable  用户 只能getmetatable  不能设置 metatable]]

t={}
t.__metatable="you can just see me "
s={}
setmetatable(s, t)
print(getmetatable(s))  --you can just see me 
setmetatable(s,{})  --cannot change a protexted metatable

--13.4 table的访问方法
--13.4.1  __index 元方法
window={}
mt={}
setmetatable(window, mt)
window.property={width=10,height=20}
print(window.width)          --nil
mt.__index=window.property
print(window.width)          --10
print(rawget(window,width)) --nil  如果不希望访问table 涉及__index元方法 可以通过函数rawget

--13.4.2  __newindex 元方法
--13.4.3  具有默认值的table
local mt={__index=function (k) return k.___ end}
color={r=255,g=13,b=127}

function SetDefault(t,d)
t.___=d
setmetatable(t, mt)
end

print(color.r)          --255
print(color.a)          --nil
SetDefault(color,125)
print(color.a)          --125

--13.4.4  跟踪table的访问
--13.4.5  只读的table