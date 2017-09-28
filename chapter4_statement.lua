--chapter 4 语句

--4.1 赋值

--支持多重赋值
a,b,c=1,2,3
print(a)  --1 
print(b)  --2
print(c)  --3

-- 交换  赋值总是先对右边元素求值  才对左边的元素进行赋值
x,y="a","b"  
x,y=y,x

print(x)
print(y)

a,b,c =1,2  --值不够 多余的Key 赋值为nil
print(a)  --1 
print(b)  --2
print(c)  --nil

c=3
a,b =1,2,3  --Key不够 多余值抛弃
print(a)  --1 
print(b)  --2
print(c)  --3

--4.2 局部变量与块 (block)
local variable  --值为nil  隐式赋值

--4.3 控制结构

-- if for while 以 end 结尾  
--    repeat    以 until 结尾
-- lua 不支持 switch语句

--（1）repeat的用法 --
local index = 1
repeat
   print(index)
   index=index+1
   until index>2
   --output  
   --1
   --2

 --（2）数字型 for --
--exp1 初始值  exp2 目标值  exp3 步长(Optional 默认值为1)
for var=exp1,exp2,exp3 do 
end
--循环前 3个表达式一次性求值（只执行一次）

--(3) 泛型 for --
a={"a","b","c","d","e","f","g"}

for k,v in  ipairs(a) do 
print(k .. " || ".. v)
end

--output
--1 || a
--2 || b
--3 || c
--4 || d
--5 || e
--6 || f
--7 || g

--4.4 break 与 return

 function foo()
 --do sth            
  do return end  --执行到此结束
 --<其它语句>
 end