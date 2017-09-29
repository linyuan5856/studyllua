--[[Chpater 9  协同程序]]--

--9.1 协同程序基础

--4种状态 suspended,running,dead,normal 
co=coroutine.create( function() print("hi") end ) -->创造一个匿名函数

print(co)  -->thread :0054BBB0
print(coroutine.status( co ))  -->suspended
coroutine.resume(co) -->hi
print(coroutine.status( co ))  --> dead

-- yield  让协同挂起

co2=coroutine.create( function()
    for i=1,4 do
        print("co2  ",i)
        coroutine.yield( ) end
end
 )
 print(coroutine.status( co2 ))  --> suspended
 coroutine.resume( co2) -->1
 coroutine.resume( co2) -->2
 coroutine.resume( co2) -->3
 print(coroutine.status( co2 ))  --> suspended
 coroutine.resume( co2) -->4
 print(coroutine.status( co2 ))  --> suspended
 coroutine.resume( co2) -->无输出
 
 
 --当一个协同程序A 唤醒 另一个 协同程序 B，协同程序A 处于特殊状态， “正常”状态

 --协同程序可以通过 resume -yield交换数据

 co3=coroutine.create( function(a,b,c) print(a,b,c) end )
 coroutine.resume( co3,1,2,3) 
 -->【output】 1,2,3 
 --》可以像协同内的 匿名函数传参数

 co4=coroutine.create( function(a,b,c)  coroutine.yield( a,b,c) end )
 print(coroutine.resume( co4 ,"today","yesterday","tommorow"))
-->【output】 true	today	yesterday	tommorow
-->true|false 表示函数是否执行错误  后面的是对应yild的参数

--当一个协同程序结束时 resume的返回值 = 它的主函数所返回的值 
co5=coroutine.create(function() return 5,6 end)
print(coroutine.resume( co5,"a","b")) --> true 5 6

co6=coroutine.create(function()  coroutine.yield("test") return 5,6 end)
print(coroutine.resume( co6,"a","b")) -->true test  (第一个yield返回)
print(coroutine.resume( co6,"a","b")) -->true 5 6   （程序执行完毕 return）

co7=coroutine.create(function()  coroutine.yield("test") end)
print(coroutine.resume( co7,"a","b")) -->true test  (第一个yield返回)
print(coroutine.resume( co7,"a","b")) -->true   （程序执行完毕 无return的值）


--9.2 管道 (pipe) 与 过滤器 (filter)

--9.3 以协同程序实现 迭代器
t={1,2,3,4}
--1. 通过递归实现对一个数组全部排序方式的实现

function sort( a ,n)
    n=n or #a
    if  n<=1 then
    tell (a)       
    else  
    for i=1,n do
     a[i] ,a[n]=a[n] ,a[i]
     sort(a,n-1)
     a[n] ,a[i]=a[i], a[n] 
    end   
 end
end

function tell (a)
local s=""
for i=1,#a do
s=s.." "..a[i]; 
 end
  print(s)
end

sort(t)

--output
 --2 3 4 1
 --3 2 4 1
 --3 4 2 1
 --4 3 2 1
 --2 4 3 1
 --4 2 3 1
 --4 3 1 2
 --3 4 1 2
 --3 1 4 2
 --1 3 4 2
 --4 1 3 2
 --1 4 3 2
 --2 4 1 3
 --4 2 1 3
 --4 1 2 3
 --1 4 2 3
 --2 1 4 3
 --1 2 4 3
 --2 3 1 4
 --3 2 1 4
 --3 1 2 4
 --1 3 2 4
 --2 1 3 4
 --1 2 3 4

 --2. 迭代器方式加入  --coroutine.create 方式
 function sort( a ,n)
    n=n or #a
    if  n<=1 then
    coroutine.yield(a)   
    else  
    for i=1,n do
     a[i] ,a[n]=a[n] ,a[i]
     sort(a,n-1)
     a[n] ,a[i]=a[i], a[n] 
    end   
 end
end

function iter(a)
local co=coroutine.create( function() sort(a)end)
return function ()
    r,v=coroutine.resume(co)
   return v
 end
end

function tell (a)
local s=""
for i=1,#a do
s=s.." "..a[i]; 
 end
  print(s)
end

for element in iter {1,2,3} do
     tell(element)
     end

--output
--2 3 1
--3 2 1
--3 1 2
--1 3 2
--2 1 3
--1 2 3

-- 3.迭代器方式加入  --coroutine.warp 方式
 function sort( a ,n)
    n=n or #a
    if  n<=1 then
    coroutine.yield(a)   
    else  
    for i=1,n do
     a[i] ,a[n]=a[n] ,a[i]
     sort(a,n-1)
     a[n] ,a[i]=a[i], a[n] 
    end   
 end
end

function iter(a)
return coroutine.wrap(function() sort(a)end) --直接返回 方法
end

function tell (a)
local s=""
for i=1,#a do
s=s.." "..a[i]; 
 end
  print(s)
end

for element in iter {1,2,3} do
     tell(element)
     end

 --output 和上面一样 略

--4. warp 和creat 的区别
c1=coroutine.create( function () end )
c2=coroutine.wrap( function () end )
print(c1) -->thread: 0024D4C0    Tread
print(c2) -->function: 0024D5A0  方法



--9.4 非抢先试的(non-preemptive) 多线程
