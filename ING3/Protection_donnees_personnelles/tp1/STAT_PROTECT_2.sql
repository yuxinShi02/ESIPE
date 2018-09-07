
drop view STATS_VIEW ;
drop table STATS;
create table STATS (name varchar(50), gender char(1), age NUMBER, insurance varchar(50), leucocyte NUMBER);
insert into STATS values('dubois', 'H', 55, 'MGEN', 3500); 
insert into STATS values('durand', 'F', 25, 'MGEN', 3000); 
insert into STATS values('mike', 'H', 35, 'MATMUT', 7000); 
insert into STATS values('john', 'F', 45, 'MATMUT', 5500); 
insert into STATS values('max', 'H', 65, 'MAIF', 2800); 
insert into STATS values('mat', 'F', 55, 'MGEN', 3200); 
insert into STATS values('fred', 'H', 55, 'MATMUT', 5000); 
insert into STATS values('berny', 'H', 55, 'MATMUT', 2500); 
insert into STATS values('franck', 'F', 64, 'MGEN', 3000); 
insert into STATS values('toufik', 'H', 57, 'MAIF', 4500); 

create view STATS_VIEW AS SELECT gender, insurance, leucocyte from STATS;

create or replace function ROW_COUNT ( where_clause IN varchar ) 
RETURN NUMBER
IS
  res NUMBER;
  query varchar(500);
begin
  res := 0 ;
  execute immediate 'select count(*) from STATS_VIEW where ' || where_clause || ' having count(*)>1 and count(*)<9  ' into res ;
  return res ;
end;
/

create or replace function SUM_LEUCOCYTE ( where_clause IN varchar ) 
RETURN NUMBER
IS
  res NUMBER;
  query varchar(500);
begin
  res := 0 ;
  execute immediate 'select sum(leucocyte)  from STATS_VIEW where ' || where_clause || ' having count(*)>1 and count(*)<9 ' into res ;
  return res ;
end;
/

CREATE or replace FUNCTION WHERE_CLAUSE ( where_clause IN varchar ) 
RETURN VARCHAR
IS
begin
  return where_clause ;
end;
/

drop user USER_STAT;
create user USER_STAT identified by oracle;
GRANT CREATE session, CREATE table, CREATE view, CREATE procedure TO USER_STAT;
GRANT all privileges on WHERE_CLAUSE TO USER_STAT;
GRANT all privileges on ROW_COUNT TO USER_STAT;
GRANT all privileges on SUM_LEUCOCYTE TO USER_STAT;
