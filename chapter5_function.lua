--chapter5 函数

--特殊情况调用函数...满足以下条件 可以省去（）
--1.函数只有一个参数
--2.参数是一个字面字符穿 或者 table构造式  

function foo(t )
    print(t.x)
end

foo {x=2}  --> foo({x=2})  

print "没括号"  --> print("没括号")


--函数调用 特殊语法————冒号操作符
o.foo(o,x)  --> o:foo(x)  把自己当做函数的第一个参数


--5.1 多重返回值 (Multiple results)
--(1)常规用法
function foo()
return 1,2
end

print(foo())  -- 1, 2
print(foo(),10) --1,10
print(foo().."x") --1x

x,y,z=foo()
print(x,y,z)  --1,2,nil

--(2)table 构造式可以结束一个函数返回的全部结果(函数调用作为 最后一个元素 才会发生 其他位置上的调用只产生一个结果值)
function Debug( ta )
   for k,v in ipairs(ta) do
print(k,v)
end
end

Debug {foo()}-取全部返回值
--output 
-- 1 1
-- 2 2

Debug {"x","y",foo()} --取全部返回值
--output
--1	x
--2	y
--3	1
--4	2

Debug {foo(),"A","B"} --只取第一个返回值
--output
--1 1
--2 A
--3 B

--(3)将一个函数调用放入一对 圆括号中 可以迫使它只返回一个返回值
function foo2()
return 1,2,3
end

print(foo2()) --1,2,3
print((foo2())) --1

--(4) 特殊函数 unpack(C语言实现)  接受一个数组作为参数 并从下标 1开始返回该数组所有元素

print(unpack{1,2,3},"4") -- 1,4  和上面一样 必须在最后才返回所有

--常规用法
f=string.find
r={"abc","c"}
print(f(unpack(r))) -->3 ,3  等同于 stirng.find("abc","c")

--在Lua中通过递归实现Unpack
function myunpack(arrary,index)
index=index or 1

if arrary[index] then 
return arrary[index],myunpack(arrary,index+1)
  end
end

print(myunpack({"monday","sunday","tiger"}))  -- monday sunday tiger


--5.2 变长参数 (variable number of arguments)
--变长参数 必须在 固定参数后 foo(p,...)
function add( ... )
    local sum=0
   for i,v in ipairs(...) do
       sum=sum+v
   end
   return sum
end

print(add {1,2,3,4,5}) --> 15

--5.3 具名实参
--将参数存入Table 传table给函数调用 