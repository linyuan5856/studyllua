--[[Chapter 2 类型与值
nil
boolean
number
string
userdata
function
thread
table
]]--

-- 2.1 nil--
--2.2 boolean--
--2.3 number--
--lua 没有整数类型  使用双精度表示一个整数
4 
0.4 
4.57e-3  
0.3e12  
5e+20

--2.4 string--
--lua 的字符串是不可变的值  可以转义字符
s="string"

--可以通过数值来指定 字符串中的字符
--alo\n123  =  \97 lo \10 \04923

print("\97lo\10\04923")
--output
--alo
--123

--lua 提供运行时 数字和 字符串的转换
print("10"+1)    --11
print("10+1")    --10+1
print("hello"+1) --exception 无法转换

-- ..字符串连接符
print(10 .. 20) -- 1020 

--2.5 table(表)--

a={}
a.x=10 -- 等同于 a{"x"}=10
a.x a[x] --两者不相等  前者 a["x"] 字符串为Key  后者是 变量作为Key

-- lua 数组 以1 位索引的初始值 “#” 用于返回一个数组或 线性表的最后一个索引值

b={}
b[1]=1
b[2]=2
b[3]=3

for i=1,#b do
    print(b[i])
end

 --b[#b] 最后一个索引的值
print("last value: " .. b[#b])  --3
b[#b]=nil --删除最后一个值
print("last value: " .. b[#b]) --2
b[#b+1]="newValue" --添加新的值 到列表末尾
print("last value: " .. b[#b]) --newvalue

--2.6 function (函数)--
--2.7 userdata（自定义类型） 和thread(线程)