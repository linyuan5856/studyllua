--[[Chapter 16 面向对象编程]]--

Account={balance=0}
function Account.withdraw( v )
  Account.balance=Account.balance-v 
end

--正常调用
--Account.withdraw(100)
--print(Account.balance) -- -100

--依赖于 全局变量 被改变后 不能继续工作
a=Account
Account=nil
a.withdraw(100)  --attempt to a global 'Account'(a nil value)

--解决方式  指定一个 '接受者'  self 或 this
Account2={balance=0}
function Account2.withdraw(self,v)
    self.balance=self.balance-v
end

b=Account2  Account2=nil
b.withdraw(b,100)  --tips  equals b:withdraw(100)  
print(b.balance)   -- -100

-- Lua 使用冒号 (:) 隐藏 self 参数


--[[16.1  类   16.2  继承]]--
Player={hp=0}

function Player:new(o )
o=o or {}
setmetatable(o,self)
self.__index=self
return o
end

function Player:AddHp(v)
   self.hp=self.hp+v
end

jam=Player:new()
jam:AddHp(10)
print(jam.hp) --10

--[[继承]]--
SuperPlayer=Player:new()  --Player的实例
chinacaptian=SuperPlayer:new{shield=100} --self 为 SuperPlayer

print(chinacaptian.hp) --0
print(chinacaptian.shield) --100

function SuperPlayer:AddHp(v)    --重写基类方法
    self.hp=self.shield+v+self.hp
end

chinacaptian:AddHp(10)
print(chinacaptian.hp) --110


--16.3  多重继承
local function search(k,list )
    for i=1,#list do
        local v=list[i][k]
        if  v then  return v end               
    end
end

function Creatclass( ... )
    local c={}
    local p={...}

    setmetatable(c,{__index=
    function(t,k) 
     return search(k,p)
    end
    })

    c.__index=c 

    function c:new(o)
        o=o or {}
       setmetatable(o,c)
       return o
    end
    return c 
end

--16.4  私密性
function FruitAccount(initValue)
local self ={amount=initValue}

local eat=function(v) self.amount=self.amount-v end
local buy=function(v) self.amount=self.amount+v end
local getTotal=function() return self.amount end

return {eat=eat,buy=buy,getTotal=getTotal}
end

apple=FruitAccount(5)
print(apple.getTotal())  --5
apple.eat(1)
print(apple.getTotal())  --4
apple.buy(500)
print(apple.getTotal())  --504

--16.5  单一方法(single-method)做法
