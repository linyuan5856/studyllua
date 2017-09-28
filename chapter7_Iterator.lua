--Chapter 7 迭代器 和 泛型 for

--7.1 迭代器 与 closure

t={10,20,30}

function getvalue( ... )
    local t=...
    local index=0
    return function() index=index+1  return t[index] 
    end
end


function iterator()
    local foo=getvalue(t);
    while true do 
    local element=foo()
    if element then
        print(element)
    else break end
    end
end 

iterator()
--output
-- 10
-- 20
-- 30

-- 7.2 泛型 for的语义

-- for var_1,....,var_n in <explist> do <block> end
-- 一个迭代器函数  一个恒定状态 (invariant state) 一个控制变量 (control variable)
-- _f(迭代器函数),_s（恒定状态）,_v（控制别量）=<explist>

--》等价于 伪代码
 do 
 local _f,_s,_v=<explist> --对表达式求值
 while true do 
 local v,v1,...vn=_f(_s,_v)
 _v=v
  if _v ==nil then break end
  print(v1,....,vn)
  end
 end

 --7.3 无状态的迭代器

t={"data1","data2","data3"}

function myipairs(t)
 return iterator,t,0
end

function iterator(s,v) --s 恒定状态  v 控制变量
v=v+1 
local element=s[v]
if element then 
 return v,element
 end
end

for k,v in myipairs(t) do 
    print(k,v)
end

--output
-- 1 data1
-- 2 data2
-- 3 data3

 --7.4 具有复杂状态的迭代器
 --就是用table 存多个状态 将control变量放进table里面
t2={"k","i","s","s"}

function getMultipleStates(t)
    local newt={a=t,pos=1}
    return interator_multiple,newt;
end

function interator_multiple(newt)
local element=newt.a[newt.pos];
    if element then
    newt.pos=newt.pos+1; 
    return newt,element;
    end
end

for k,v in getMultipleStates(t2) do
    print(v)
end
--output
--k
--i
--s
--s

--7.5 真正的迭代器
