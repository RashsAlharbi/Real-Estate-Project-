
CREATE SCHEMA real_estate ;

use real_estate;

CREATE TABLE sales_office(  
num VARCHAR(10) NOT NULL,  
location  VARCHAR(45) NOT NULL,  
PRIMARY KEY (num));

CREATE TABLE employee(  
id VARCHAR(10) NOT NULL, 
 ename VARCHAR(45) NOT NULL,  
 office_num VARCHAR(45) NOT NULL, 
 manage_id VARCHAR(45) NULL,  
 PRIMARY KEY (id), 
 FOREIGN KEY (office_num) REFERENCES sales_office(num));

ALTER TABLE employee 
ADD CONSTRAINT manage_id FOREIGN KEY (manage_id) REFERENCES employee(id);

  
  CREATE TABLE property (
  id VARCHAR(10) NOT NULL,
  address VARCHAR(45) NOT NULL,
  city VARCHAR(45) NOT NULL,
  state VARCHAR(45) NOT NULL, 
  zip VARCHAR(45) NULL,
  office_num VARCHAR(45) NOT NULL,
  PRIMARY KEY (id),   
  FOREIGN KEY (office_num)    REFERENCES sales_office(num) );
  
  CREATE TABLE owners (
  id VARCHAR(10) NOT NULL, 
  oname VARCHAR(45) NOT NULL,
   age VARCHAR(3) NOT NULL,
  PRIMARY KEY (id));
  
  CREATE TABLE owner_property (
  prop_id VARCHAR(10) NOT NULL,
  own_id VARCHAR(10) NOT NULL,
  percent_owned VARCHAR(45) NOT NULL, 
  FOREIGN KEY (prop_id)    REFERENCES property(id) ,
  FOREIGN KEY (own_id)    REFERENCES owners (id)  );
  
INSERT INTO sales_office (num, location) VALUES ('o1', 'saudi');
INSERT INTO sales_office  (num, location) VALUES ('o2', 'emarite');
INSERT INTO sales_office  (num, location) VALUES ('o3', 'qatar');
INSERT INTO sales_office  (num, location) VALUES ('o4', 'egypt'); 
INSERT INTO sales_office  (num, location) VALUES ('o5', 'kuate');

INSERT INTO employee (id, ename, office_num) VALUES ('e1', 'seham', 'o1');
INSERT INTO employee (id, ename, office_num) VALUES ('e2', 'hanan', 'o1');
INSERT INTO employee (id, ename, office_num,manage_id) VALUES ('e3', 'fares', 'o3', 'e2');

INSERT INTO property (id, address, city, state, zip, office_num) VALUES ('p1', 'saudi', 'riyadh', 's45', '258', 'o1');
INSERT INTO property (id, address, city, state, zip, office_num)  VALUES ('p2', 'qatar', 'sharika', 'd155', '6845', 'o2');
INSERT INTO property (id, address, city, state, zip, office_num)  VALUES ('p3', 'egypt', 'cairo', 'k584', '6948', 'o4') ;
INSERT INTO property (id, address, city, state, zip, office_num)  VALUES ('p4', 'saudi', 'riyadh', 'st2345', '5256', 'o1');

INSERT INTO owners (id, oname,age) VALUES ('ow1', 'mohamed','33');
INSERT INTO owners (id, oname,age) VALUES ('ow2', 'ahmed','42');
INSERT INTO owners (id, oname,age) VALUES ('ow3', 'rehab','55');


insert into owner_property values('p2','ow1','50'),('p1','ow1','50'),('p3','ow3','70');

update property set city='gaddah' where id='p1';

delete from sales_office where num='o5';

select num,s.location,p.address
from sales_office s inner join property p
on p.office_num = s.num
group by num;

create view propertyofowner as
select o.oname,p.id,op.percent_owned
from owners o inner join property p inner join owner_property op
on op.own_id=o.id and op.prop_id=p.id;

select ename,office_num 
from employee
where office_num in 
(select num from sales_office)
order by ename;
