--3.1 算数表达式

--[[ + - * / ^(指数) %(取摸) ]]
--取模操作符定义  a%b=a-math.floor(a/b)*b
x=5.32
print(x/1)  --5.32
print(x%1)  --0.32 取小数
print(x-x%1)  --5  取整数

y=math.pi
print(y)      --3.141592653898
print(y%0.01)  --0.001592653589793 (保留16位 双精度)
print(y-y%0.01) --3.14 取后2位小数
print(y-y%0.0001) --3.1415 取后4位小数


--3.2 关系操作符
-- 》 《 《= 》= == ~=

--3.3 逻辑操作符
--and or not  所有关系运算符 都将 false 和 nil 当做 假 
--and  or 短路求值（有需要采取评估第二个操作数）
--and  如果第一个操作符 为假 返回第一个。不然返回第二个 
-- or  如果第一个操作符 为真 返回第一个；不然返回第二个

x=nil 
v=5
x=x or v  --等于 if not x then x=v end

print(x) --5 

--类似C#三元运算  a?b:c

a=5 b=3
max=a>b and a or b   
print(max)  --5

--not nil     -->true
--not false   -->true
--not 0       -->false
--not not nil -->false


--3.4 字符串连接
--3.5 优先级
--3.6 table 构造式
--(1)等价写法
test={v1=1,v2=2}
--等价 test={} test.v1=1 test.v2=2
print(test["v1"])--1  字符串Key
print(test.v1)  --1   字符串Key
print(test[v1]) --nil 未申明的变量 Key

--(2)构造数组 下标 默认从1开始
days={"sunday" ,"monday", "tuesday", "wednesday", "thursday" ,"fridaty" ,"saturday"}
print(days[1])--"sunday" 

-- (3)创造链表
local list=nil
for i=1,#days do
    list={next=list,value=days[i]}
end

while list do
print(list .value)
list =list .next
end

--output
--saturday
--fridaty
--thursday
--wednesday
--tuesday
--monday
--sunday