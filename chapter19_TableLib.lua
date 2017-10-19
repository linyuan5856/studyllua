--[[Chapter 19 table库]]
--19.1 插入和删除
function LogTable(t)
    for i,v in pairs(t) do
        print(i,v)
    end
    print("end")
end

A={10,20,30}
table.insert(A,1,0 ) --1 0,2 10,3 20 ,4 30
LogTable(A)
table.insert(A,100)  --1 0,2 10,3 20,4 30, 5 100   没有指定位置 默认插入末尾
LogTable(A)
table.remove(A,2)   --1 0,2 20,3 30,4 100,
LogTable(A)
table.remove(A)     --1 0 ,2 20,3 30    没有指定位置 默认删除末尾
LogTable(A)

--19.2 排序
--对数组排序
--默认按 小于排序

t={A=54,C=24,B=108}
a={}

for v in pairs(t) do
    a[#a+1]=v
end
table.sort(a)
for i,v in ipairs(a) do
    print(v)
end
--output  
--A
--B
--C


--19.3 连接
--table.concat( tablename, ", ", start_index, end_index )

function rconcat(l )
    if type(l) ~= "table" then return l end
     local res={}
     for i=1,#l do 
        res[i]=rconcat(l[i])
     end
     return table.concat( res, ", ")
end

--test

local s=rconcat { "I ",{"love","Coding"},{{" Very"},{"Much"}}}
print(s)
--output  
-- I , love, Coding,  Very, Much