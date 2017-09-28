--Chpater 6 深入函数

function foo(x)  return x*2end
--等同于 
foo=function (x) return x*2 end 

print(foo(3)) --> 6

--6.1 闭合函数 （Closure） 闭包

function Closure()
local i=1;
 return function()  i=i+1 return i end
  end

  c=Closure();

  print(c())--->2
  print(c())--->3
  print(c())--->4
  

  --6.2 非全局的函数 （non-global function)

  --1.放在table中 三种写法
 --第一种
   lib={}
   lib.foo=funtion(x,y) return x+y end
   lib.goo=funtion(x,y) return x-y end
   
 --第二种
   lib=
   {
   foo=funtion(x,y) return x+y end
   goo=funtion(x,y) return x-y end
   }

 -- 第三种
   function lib.foo(x,y) return x+y end
   function lib.goo(x,y) return x-y end
    
    --2.局部变量
    local f=function() end-->等于 local function f()  end

  -- lua展开局部函数定义的语法糖的时候 是对于局部函数定于进行展开
  local function foo(<参数>) <函数体> end

  -->展开后
    local foo
    foo=function(<参数>) <函数体> end
    
    --递归中容易犯的错误
    local foo=function(x) 
     return x+foo()  -->报错 foo 尚未定义
     end

     --6.3 正确的尾调用 （消除堆栈 防止溢出）
     --一个函数调用 是另一个函数的最后一个动作时 该调用才算是一个尾调用

     --eg.
     function f(x) return g(x) end --g(x) 为最后调用  且 return 了 

     function f(x)  g(x) end --没有返回 不是尾调用