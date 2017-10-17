--[[Chapter15 模块 与 包 ]]
--15.1 Require 函数
--require 函数的行为 伪代码

function require(name)
    if not package.loaded[name] then 
    local  loader = findloader(name)
    if loader==nil then 
        error("unable to load module" .. name)
    end
    package.loaded[name]=true
    local res=loader[name]

    if res ~= nil then 
        package.loaded[name]=res
    end
end
return package.loaded[name]
end

--搜索文件路径
--eg:
"?:?.lua;c:\windows\?;/usr/local/lua/?/?.lua"
 require "sql"

 --会尝试打开的文件路径
 sql
 sql.lua
 c:\windows\sql
 /usr/local/lua/sql/sql.lua 

 --15.2 编写模块的基本方法
 --1.必须显示的将模块名放到每个函数定义中  2.一个函数在调用另一个模块的一个函数时 必须限定被调用函数的名称

 --[[eg1]]--
 local M={}
 complex=M

 M.i={r=0,i=1}  --定义一个常量
 
 function M.new(r,i ) return {r=r,i=i} end

 function M.add(c1,c2)
     return M.new(c1.r+c2.r,c1.i+c2.i)
 end

 return complex  
  --[[end]]--

 --[[eg2避免写模块名]]--
 local modelname=" "
 local M={}
 _G[modelname]=M
 --as before
 --[[end]]--

 --[[eg2消除return 语句]]--
 local modelname=" "
 local M={}
 _G[modelname]=M
 package.loaded[modelname]=M
  --[[end]]--

  --15.3 使用环境
   local modelname=""
   local M={}
   _G[modelname]=M
   package.loaded[modelname]=M
   setfenv(1,M)

   function add()  --此时申明函数add 为包的add函数 
       -- body
   end
   
   --访问这种独占环境的方法
   --1.继承
   local modelname=""
   local M={}
   _G[modelname]=M
   package.loaded[modelname]=M
   setmetatable(M,{__index=_G})  --setmetatable 一定要在 setfenv 前
   setfenv(1,M)

   --2.申明局部变量访问_G
   local modelname=""
   local M={}
   _G[modelname]=M
   package.loaded[modelname]=M
    local _G=_G
    setfenv(1,M)
  
  --3.更正规的方法 运行速度最快  局部变量保存需要用到的函数或者模块
     --模块设置
     local modelname=""
     local M={}
     _G[modelname]=M
     package.loaded[modelname]=M

    --导入
    local sqrt=math.sqrt
    local io=io

    --终止访问
     setfenv(1,M)

  --15.4 module函数

   -- module(...)  
   --等价于  (默认情况不提供外部访问)
   --[[
      local modelname=""
      local M={}
      _G[modelname]=M
      package.loaded[modelname]=M
      setfenv(1,M)
     ]] --

     module(...,package.seeall)  -- 等价于 setmetatable(M,{__index=_G}) 实现外部访问
    
  --15.5 子模块与包