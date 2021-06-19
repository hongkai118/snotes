安装和启动
	1. 安装MySQL
		a. 去官网下载Community（社区）版本
		b. 将Bin目录加入到环境变量
	
	2. 启动Mysql
		a. 启动服务器：运行mysqld.exe
		b. 启动客户端：mysql -u root -p
	3. 制作MySql windows服务
		a. 制作：mysqld --install
			i. 启动服务：
				1) 终端：net start MySQL
				2) 服务界面
			ii. 终止服务：net stop MySQL
			
		b. 卸载：mysqld --remove

连接-创建用户
	1. 默认：用户Root
	2. 创建用户：
		a. create user 'Kyle'@'192.168.1.1' identified by '123123';  #kyle可以在192.168.1.1这机器上登录
		b. create user 'Kyle'@'192.168.1.%' identified by '123123'; #可以在192.168.1.x这些机器上登录
		c. create user 'Kyle'@'%' identified by '123123'; #可以在所有机器登录
	3. 授权：
		a. grant select,insert,update on db1.t1 to 'kyle'@'%'
		b. grant all privileges on db1.t1 to 'kyle'@'%'
		c. revoke all privileges from db1.t1 to 'kyle'@'%'; 取消授权
		d. GRANT ALL PRIVILEGES ON *.* TO 'test'@'localhost'
		e. GRANT ALL PRIVILEGES ON db.* TO 'test'@'localhost'
		
	4. 刷新权限
		a. FLUSH PRIVILEGES
		



MYSQL的语法规范
	1. 不区分大小写，但建议关键字大写，表、列名小写
	2. 以分号结尾。
	3. 每条命令根据需要，可以进行缩进或换行。
	4. 注释
		a. 单行注释：#注释文字
		b. 单行注释：-- 注释文字
		c. 多行注释：/* 注释文字。。。。*/
	


学习SQL语句规则
	1. 操作文件夹（数据库）
		a. 数据库常用命令
			a. create databases db2;
			b. create databases db2 default charset utf8;
			c. show databases; 
			d. drop database db2;   -- 删除数据库
		
		b. 数据库转存（备份、导入）
			a. 备份
				i. mysqldump -u root  db1 > db1.sql -p
				ii. mysqldump -u root -d db1 > db1.sql -p
			b. 导入
				i. create database db5; 先创建数据库
				ii. mysqldump -u root -d db5 < db1.sql -p
		
		
	2. 操作文件（表）
		a. 表的增删改查相关命令
			a. 显示表：
				1) show tables;
				2) desc tables
				3) Show create table xx;
				
			b. 表的创建
				1) create table t1(id int, name char(10)) default charset = utf8
				2) create table t1(id int, name char(10)) engine=innodb default charset = utf8
				3) create table t1(
					列名 类型 null, #可为空，默认可为空
					列名 类型 not null, #不可为空
					列名 类型 not null auto_increment primary key, #自增必须加主键
					id int, 
					name char(10),
					public timestamp #日期格式
				) engine=innodb default charset = utf8
				4) 举例
				create table if not exists t1(     #可以加if not exists判断下
					id int(10),
					cnd_name varchar(20)
					cnd_company varacher(50)
					cnd_depart varchar(20)
					package int(10),
				
			c. 表的修改
				1) 语法：alter table 表明 add | drop| modify |change column
				修改列名	alter table t1 change column cnd_name c_name varchar(20);
				修改列的约束或类型	alter table t1 modify  column package varchar(20);
				添加新列	alter table t1 add column title varcher(20);
				删除列	alter table t1 drop column title;
				修改表名	alter table t1 rename to t2;
			
			d. 表的删除
				1) drop table if exists t1;
			
			e. 表的复制
				仅复制表的结构	create table copy_t1 like t1;
				复制表的结构+内容 	create table copy2_t1 
					select * from t1;
				只复制部分数据	create table copy3_t1
					select id,au_name
					from t1
					where nation='中国';
				
			
			f. 清空表：
				1) delete from t1; 重新插上数据，自增列会继续自增
				2) truncate table t1; 自增列重新从1开始
			g. 删除表：
				1) drop table t1;
			h. 显示和更新表的内容
				1) desc t1;
				2) show create table t1;  #显示表如何创建
				3) show create table t1 \G; #显示表如何创建
				4) alter table t1 AUTO_INCREMENT = 1; 删除某行后，执行此条，再执行插入语句，就可以正常自增。
				5) alter table user add foreign key(pid) references province(pId);
				
		b. 数据类型
			i. 数字：
				1) tinyint:
					a) 有符号：-128~127
					b) 无符号：0~255
				2) int:
					a) 有符号：-2147483648~2147483647
					b) 无符号：0~4294967295
				3) bigint:很大的整数
				4) FLOAT：不精准浮点数
				5) DOUBLE：不精准浮点数
				6) Decimal:精准的浮点数,num decimal(10,5)表示：总共10位，其中小数点后有5位
			ii. 字符串：
				1) char(10):表示所有都占10个位置，速度快；支持255位
				2) varchar(10)：位最多占10个位置，省空间；支持255位
				3) text：支持很多位
				4) longtext: 更大的数据量
				5) 文件：文件村硬盘上，数据库存路径。
			iii. 时间类型：
				1) Timestamp: 年月日时分秒
				2) DATETIME: 年月日时分秒
				3) DATE:YYYY-MM-DD
			iv. 枚举ENUM：xx enum('L','M','S'),插入数据时能能选其中一个
			v. 集合Set: xx SET('a','b','c'), 插入数目时，可以ab,ac组合。

		
		c. 约束类型
			i. auto_increment: 自增
			ii. primary key: 约束（不能重复且不能为空）；加速查找
			iii. 外键(P10)
				1) 外键必须为唯一
				2) create table cnd(
				id int auto_increment primary key,
				industry char(32),
				depart char(32),
				cnd_name char(32),
				companty char(32),
				title char(32),
				CONSTRAINT fk_guanxi_teach FOREIGN KEY  (t_id) REFERENCES teacher(id),
				CONSTRAINT fk_guanxi_class FOREIGN KEY (class_id) REFERENCES	class(id)
				) engine = innodb default charset=utf8;
				
				3) 给已经建好的表格，后期加外键
					ALTER TABLE STORE_FRONTINFO
					  ADD CONSTRAINT FK_STORE_FR_REFERENCE_STORE_AR FOREIGN KEY (AREAID)
					  REFERENCES STORE_AREA (AREAID);
					
		d. MySQL中有两种引擎
			i. innodb：支持事务，出错时自动回滚
			ii. myisam：不支持事务。
	
		
			
	3. 操作文件（表）中内容
		a. 增：
			i. insert into t1(id,name) values(1,'内容')
			ii. insert into t11(name,age) values('alex',12),('root',18);
			iii. insert into t11(name,age) select name,age from tb11;
		b. 删：
			i. delete from t1
			ii. delete from t1 where id <6
			iii. delete from t1 where id >=2 or name='alex'
		c. 改
			i. update t1 set age =18;
			ii. update t1 set name='alex', age =18 where age=17 and name='xx'
			
		d. 查：
			i. 条件查询（where）
				1) 语法：select xx,xx, xx  from where xx='xxx'; # 条件查询
				2) 条件运算符：< > <> >= <=
					a) select xx,xx from t1 where salary>12000; >大于
					b) select xx,xx from t1 where id <> 90; #<>不等于
					
				3) 逻辑运算符：and\ or\ not
					a) select xx,xx from t1 where salary>=12000 and salary<=20000;
				4) 模糊查询：like\ between and\ in \ is null \is not null
					a) 通配符：
						i) %代表任意多个字符
						ii) _代表任意1个字符
						iii) escape '$'; 采用escape "任一字符" 作为转义符。
					b) like:
						i) 查询员工名中包含a的：select * from t1 where last_name like '%a%'; #%代表任意多个字符
						ii) 查询第三个字符为e,第五个字符为a的：select * from t1 where last_name like '__e_a%'; #_代表任意1个字符
						iii) 查询第二字符为_的员工：select xx from t1 where last_name like '_$_%' escape '$'; #采用escape "任一字符" 作为转义符。
					c) between and:
						i) select xx from t1 where employee_id between 100 and 120; #等于employee_id>=100 and employee <=120;
					d) in:
						i) select xx from t1 where job_id in ('xx', 'xx','xx')；xx表示不同值或连接，等于job_id='xx' or job_id='xx' or job_id='xx'
						ii) select xx,xx from t1 where id in (select id from tb11)
					e) is null:
						i) select xx from t1 where xx is null; #xx=null，<>无法判断null值
			ii. 分页查询（limit)
				1) select * from tb1 limit 10; #取前10条
				2) select * from tb1 limit 10，10; #从第10个开始，取10条
				3) select * from tb1 limit 20，10; #从第20个开始，取10条
				4) select * from tb1 limit 10 offset 20; #从20开始，取10条
				
			iii. 排序查询(order by)
				1) 语法：select xx from t1 [where xx='xxx'] order by 字段名 [asc | desc]；
					a) asc:正序
					b) desc:倒序
				2) 表达式排序，查询员工信息以总收入降序：select *,salary*12*(1+ifnull(commission_pct,0) 年薪 from t1 order by salary*12*(1+ifnull(commission_pct,0) desc；
				3) 别名排序，查询员工信息以总收入降序：select *,salary*12*(1+ifnull(commission_pct,0) 年薪 from t1 order by 年薪 desc；
				4) 函数排序，按员工姓名长度降序：select length(last_name) as 长度, last_name, salary from t1 order by length(last_name) desc;
				5) 多个字段排序，先按工资升序、再按员工编号降序：select * from t1 order by salary asc, employee_i
			iv. 分组查询（group by)
				1) 语法：
				select xx, group_function(xx) 
				from table 
				[where ..] #注意where一定放在from table后面
				group by 分组的列表 #支持多个字段分组，表达式支持函数
				[order by ..]; 
				
				2) 案例1：查询每个工种的最高工资
				select max(salary),job_id #按照job_id分组
				from t1
				group by job_id;
				3) 案例2：查询每个地点的部门个数
				select count(*), location_id
				from t1
				group by t1;
				4) 案例3：邮箱中包含a字符的，每个部门的平均工资
				select avg(salary), department_id
				from t1
				where email like "%a%"
				group by department_id
				5) 案例4：分组后再筛选---查询哪个部门的员工个数>2
				select count(*), department_id 
				from t1
				group by department_id
				having count(*) >2;
				6) 案例5：多个字段分组，查询每个部门每个工种的员工平均工资
				select avg(salary), department_id, job_id
				from t1
				group by department_id, job_id;
				7) 案例6：查询每个不为空的部门每个工种平均工资>10000的，排倒序。
				select avg(salary), department_id, job_id
				from t1
				where department_id is not null
				group by department_id, job_id
				having avg(salary)>10000
				order by avg(salary) desc;
				
			v. 连接查询（多表查询）：
				1) sql92标准：仅支持内连接。
					a) 等值连接
						i) 案例1：查询员工名和对应的部门名
						select last_name,department_name
						from t1,t2
						where t1.department_id=t2.department_id;
						ii) 案例2：为表取别名，查询员工名、工种、职位；
						（注意：如果起了别名，则查询字段就不能使用原来的表名）
						select e.last_name, e.job_id, j.job_title
						from t1 as e, t2 as j
						where e.job_id=j.job_id
				2) Sql99标准（推荐）：支持内连接+外连接（左外和右外）+交叉连接
					a) 语法：
					select xx,xx
					from 表1 别名
					join 表2 别名
					on 连接条件
					【where 筛选条件】
					【group by分组】
					【having 筛选条件】
					【order by 排序条件】
					
					b) 内连接：inner
					c) 外连接:
						i) 左外:left [outer]
						ii) 右外:right [outer]
						iii) 全外:full [outer]
					d) 交叉连接:cross
					
				3) 连表的另一种操作（推荐方式）
					a) left join: 
					select xx,xx from 
					t1 
					left join t2 on t1.id=t2.id #left join表示 以join左边（t1)表为准，全部显示
					
					
					b) right join:
					select xx,xx from
					 t1 
					right join t2 on t1.id=t2.id；#right join表示以join左右的表(t2)表为准，全部显示
					
					c) inner join:
					select xx,xx from
					t1 inner join t2 on t1.id=t2.id # inner join里面有空值的行就隐藏。
					
					d) 多表连接
					select xx,xxx,xx from 
					t1
					left join t2 on t1.name=t2.name
					left join t3 on t1.id = t3.id
					left join t4 on t2.id=t4.id
			
			vi. 常用查询命令
				1) show database;
				2) use 数据库名称
				3) show tables;
				4) select * from 表名：
				5) select xx, xx, xx from 表名;
				6) select database(); #查看自己在哪个数据库位置
				7) desc 表名；#查看表的属性
				8) select version(); 或mysql --version #查看版本
				9) `string` #加了`内容`后表示，就是字段，用来区分保留字。
				10) 查询常量、表达式
					a) select 100; #类似于print 100;
					b) select 'hello word'; #类似于print(hello world);
					c) select 100*98; #类似于print(100*98)
				11) 查询函数：
					a) select version(); #调用函数
					b) select ifnull(字段,结果） #如果“字段”为0，则显示“结果”
				12) 起别名（as或空）；
					a) select 100*98 as 结果；
					b) select xx as "number", xx as "my_name" from t1;
					c) select xx number, xx my_name from t1;
				13) 去重（distinct)：
					a) select distinct xx from t1;
				14) +号的作用：只有一个功能，为运算符
					a) select 100+90; #结果190
					b) select '123'+90; #结果213；
					c) select 'hello' + 90; #结果90,字符 转换失败则变为0
					d) seelct null + 90; #结果null, 只要一方为null 结果肯定为null
				15) 字段拼接（concat)
					a) 案例：查询员工姓和名连成一个字段，并显示为姓名
					select concat(last_name,first_name) as 姓名 from t1;
				
	4. 常见函数
		a. 语法：select 函数名（） [from 表]；
		b. 单行函数
			i. 字符函数：
				1) length获取字节长度:select length('xxxx'); 
				2) concat 拼接字符串: select concat('xx','_','xxx') as xx from t1; #用下划线连接
				3) upper\ lower: 大写、小写：select concat(upper(xx),lower(xx)) as xx from t1;
				4) substr、substring：截取字符，索引从1开始数。
					a) 返回"efg": select substr('abcdefg', 5) out_put; 
					b) 返回"bcd": select substr('abcdefg', 2,3) out_put; #注意3是长度不是位置
				5) instr：返回字串的起始位置，如果找不到返回0
					a) 返回3：select instr('abcdefg','cde') as out_put；
				6) trim: 去前后字符串，类似strip()
					a) 去前后空格返回abc：select trim('    abc    ') as out_put
					b) 去除前后指定字符，返回游a游： select trim('a' from 'aaaaaaa游a游aaaaaaa') as out_put;
				7) lpad: 左填充，用指定字符填充指定长度
					a) 返回******abc: select lpad ('abc', 10,'*') as out_put;
				8) rpad: 右填充，用指定字符填充指定长度
					a) 返回abc******: select rpad ('abc', 10,'*') as out_put;
				9) repalce: 替换。
					a) 返回今天是个好天气：select replace("今天是个好日子”,"好日子“，”好天气“）
			ii. 数学函数：
				1) round: 四舍五入
					a) select round(1.65); #返回1.6
					b) select round(1.567, 2); 返回1.57（2表示保留两位小数）
				2) ceil：向上取整
					a) select ceil(1.52); #返回2
				3) floor: 向下取整
					a) select floor(1.52); #返回1
				4) truncate ：截取数字
					a) select truncate(1.5999999,2); 返回1.59（2表示保留2位小数）
				5) mod：取余
					a) select mod(10,3); 返回1
			iii. 日期函数
				1) now：返回当前系统日期+时间
					a) select now();
				2) curdate: 返回当前系统日期，不包含时间
					a) select curdate();
				3) curtime: 返回当前时间，不包含日期
					a) select curtime();
				4) 获取指定部分：如年、月、日、小时、分钟、秒 
					a) select year(now()); #返回当前系统时间的年：2021
					b) select year('1998-1-1')；#返回：1998
					c) select month(now()); #返回当前系统时间月：5
					d) select MONTHNAME(now()); #返回当前系统时间月：May
					e) hour
					f) minute
					g) second
				
				5) str_to_date：将指定字符串转为日期。
					a) select STR_TO_DATE("3-2-1998","%m-%d-%Y"); #返回1998-03-02
				6) date_format: 将日期转变为字符串
					a) select date_format(now(),'%Y年%m月%d日'); #返回2021年05月15日；
				7) datediff(日期1，日期2）：日期1减日期2返回相差多少天。
					a) select DATEDIFF(now(),'1988-3-5') 天数; #返回相差的天数
				8) 日期格式符对照表：
					
			iv. 其他函数
				1) select version(); #当前版本
				2) select database(); #当前数据库
				3) select user(); #当前用户
			v. 流程控制函数：
				1) If函数：
					a) select if( 10<5, '大','小'); #返回小
					b) select if( 10>5, "大','小'); #返回大
				2) case函数：
					a) 方法一（类似于多重if):
					案例：查询员工工资，要求
						Ø 部门号=30，显示工资为1.1倍
						Ø 部门号=40，显示工资为1.2倍
						Ø 部门号=50，显示工资为1.3倍
						Ø 其他部门，显示工资为原来工资。
					实现方法：
					select salary 原始工资,department_id,
					case department_id
					when 30 then salary*1.1
					when 40 then salary*1.2
					when 50 then salary*1.3
					else salary
					end as 新工资
					from t1;
					b) 方法二（类似于多重if.. elif):
					案例：显示员工工资的级别情况，要求
						Ø 如果工资>20000, 显示为A级别
						Ø 如果工资>15000,显示为B级别
						Ø 如果工资>15000,显示为B级别
						Ø 否则，显示为D级别。
					实现方法：
					select salary,
					case
					when salary>20000 then 'A'
					when salary>15000 then 'B'
					when salary>10000 then 'C'
					else 'D'
					end as '工资级别'
					from t1;
				
		c. 组合函数（组函数、聚合函数）
			i. sum、avg、max、min、count:
				1) 简单使用
					a) select sum(salary) from t1;
					b) select avg(salary) from t1;
					c) select min(salary) from t1;
					d) select max(salary) from t1;
					e) select count(salary) from t1; #计算非空值的个数
					f) select sum(salary),avg(salary),min(salary) from t1;
				2) 特点:
					a) sum、avg处理数值；max、min、count处理任何类型
					b) 都忽略null值计算
					c) 都支持和distinct搭配去重
						i) select sum(distinct salaty) from t1; #去掉重复的工资后计算总额。
					d) count函数详细介绍：
						i) select count(*) from t1; 用于统计行数-->这种格式用得多
						ii) select count(1) from t1; 也是用于统计行数
					e) 和分组函数一同查询的字段要求是group by后的字段。
