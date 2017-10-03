--[[Chapter 11 数据结构]]--

-- 11.1 数组
-- 11.2 矩阵与多维数组
N=3
M=4
--1. 数组套数组  
--实现一个 3*4 矩阵
matrix={}
for i=1,N do
    matrix[i]={}
    for j=1,M do
        matrix[i][j]=i..j
    end
end

print(matrix[2][2]) -- > 22

--2.两个索引 合并为一个索引 将第一个索引 乘以一个 适当的量+ 第二个索引
matrix2={}
for i=1,N do
    for j=1,M do
        matrix[i*N+j]=i..j
    end
end
print(matrix[2*N+2]) -- > 22

-- 11.3 链表
list=nil
data=nil

function creatData()
for i=1,5 do 
list={value="data"..i,next=list}
 end
end

function logList()
 while list do 
  print(list.value)
  list=list.next
  end
end

creatData()
logList()
--output
--data5
--data4
--data3
--data2
--data1

-- 11.4 队列与双向队列
-- 11.5 集合与 无序组
-- 11.6 字符串缓冲
-- 11.7 图