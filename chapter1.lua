--Begin Study
print("hello world")

--1.1 程序块（Chunk）
--1.2 词法规范
a=1 b=2
print(a+b.. " first")

a=1; b=2;
print((a+b) .. " second")

-- 可以分隔符 也可以不加

--1.3 全局变量 

print(b)  -- nil 访问为初始化的变量 --》 nil

b=10
print(b)  -- 10

--1.4解释器程序

--文件第一行 以#开头 解释器忽略这行
--useage  lua [选项参数] [脚本[参数]]
--[[ -e 在命令行中 输入代码
     -l 加载库文件
     -i 在运行完其他命令行参数后 进入交互模式
  ]]
