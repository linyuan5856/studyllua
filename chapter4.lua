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