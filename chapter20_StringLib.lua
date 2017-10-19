--[[CHapter20 字符串库]]--
--20.1 基础字符串数
--1.string.rep
a="iloveyou"
newa=string.rep( a,3 )
print(newa)  --iloveyouiloveyouiloveyou
--2.string.lower
up="ABCDefg"
newup=string.lower(up)
print(newup)--abcdefg
--3.string.upper
--4.string.sub
--string.sub( s, i[, j] )  提取 i 到 j 的字符  负数 代表从尾部开始
s="ilovecoding"
s1=string.sub(s,1,1)
print(s1)  --i
s2=string.sub(s,1,5)
print(s2)  --ilove
s3=string.sub(s,2,-7)
print(s3)  --love
--5.string.char  数值-》字符 string.byte 字符-》数值
print(string.char( 97 ))         --a
print(string.byte( "abcd" ))     --97   默认第一个字符 a=97(ASCII)
print(string.byte( "abcd",3))    --99   第二个参数 表示转化第几个字符
print(string.byte( "abcdef",2,4))  --98 99 100  第二个参数到第三个参数索引
--6.string.format
--%d  十进制数  
--%x  十六进制
--%o  八进制
--%f  浮点数
--%s  字符串
print(string.format("pi=%.4f",math.pi))  -->pi=3.1416  //.4f 指定是 4位小数浮点数
print(string.format("%02d/%02d/%04d",3,11,1928))-->03/11/1928 不足会补位多了不会少

--20.2 模式匹配 
--20.2.1 stirng.find
s="hello world"
i,j=string.find(s,"hello") 
print(i .." ".. j)            -->1 ,5 
print(string.sub( s, i, j))   -->hello

k1,k2=string.find(s,"Hello")
print(k1) -->nil   //大小写要匹配   找到返回nil 

k3,k4=string.find(s,"hello",2)
print(k3)  --nil   //第三个参数 从第几个索引开始查找

--20.2.2 string.match
day="this day is 19/10/2017"
target=string.match(day,"%d+/%d+/%d+")
print(target)-->19/10/2017

--20.2.3 string.gsub
s="i like eating eating"
s1,count=string.gsub( s,"eating","coding")
print(s1) -->i like coding coding
print(count)-->2  //匹配到总次数
s2=string.gsub( s,"eating","coding",1 )-->第四个参数 表示 替换次数
print(s2) -->i like coding eating 

--20.2.4 string.gmatch
s="i am 18 years old"
for v in string.gmatch( s,"%a+" ) do  -->%a+ 匹配一个或多个 字母
     print(v)
end
-->output
--i
--am
--years
--old

--20.3 模式
--%a 字母  
--%c 控制字符 
--%d 数字 
--%l 小写字母 
--%p 标点符号 
--%u 大写字母  
--%w 字母和数字符号 
-- 大写字母 表示他们的补集

--(1)在一对方括号内可以创造自己的 字符分类   --> [content]
--[%w_] 字母 数字 下划线
--[01]   二进制
s="I like eat a Apple"

s2,count=string.gsub( s,"[AEIOU]","")  -->匹配大写的元音字母
print(s2)    -->like eat a pple
print(count)  -->2

--(2)字符集包含范围 
a="[0-9]"  --> 0，1，2,3,4,5,6,7,8,9   //等同于 %d  
b="[0-7]"  -->八进制数

--(3)字符集 补集  符号^
"[^0-7]" -->所有非八进制数字的字符
"[^\n]"  -->所有非换行符的字符
"[^%s]"=="[%S]"  -->简单分类 直接大写

--（4）修饰符
--"+"  重复1次或多次
--"*"  重复0次或多次
--"-"  重复0次或多次
--"?"  出现0或1次

s="( )"-->匹配写法 "%(%s*%)"    //%s* 匹配0次或多次

--20.4 捕获
--20.5 替换
--string.gsub 第三个参数 还可以是 函数 或者table
--(1) 函数  --调用时的参数就是捕获到的内容  该函数的返回值作为要替换的字符串
function transfer(s)
    local res=s or ""
    return res .. "New"
end

s=string.gsub( "A  B  C","B",transfer)
print(s) -->A BNew C


--(2) table --每次捕获的内容为key  在table中查找将对应的value作为要替换的字符串
t={mum="Lisa"}

s=string.gsub( "mum is a good woman","mum",t)

print(s) -->Lisa is a good woman

--20.5.1 URL编码
--20.5.2 tab扩展
--20.6 技巧
