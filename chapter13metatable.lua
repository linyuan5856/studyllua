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