create table event_category
(
  event_name varchar(50),
  category varchar(100)
);


create table physician_speciality
(
  physician_id int,
  speciality varchar(50)
);


create table patient_treatment
(
  patient_id int,
  event_name varchar(50),
  physician_id int
);


insert into event_category values ('Chemotherapy','Procedure');
insert into event_category values ('Radiation','Procedure');
insert into event_category values ('Immunosuppressants','Prescription');
insert into event_category values ('BTKI','Prescription');
insert into event_category values ('Biopsy','Test');


insert into physician_speciality values (1000,'Radiologist');
insert into physician_speciality values (2000,'Oncologist');
insert into physician_speciality values (3000,'Hermatologist');
insert into physician_speciality values (4000,'Oncologist');
insert into physician_speciality values (5000,'Pathologist');
insert into physician_speciality values (6000,'Oncologist');


insert into patient_treatment values (1,'Radiation', 1000);
insert into patient_treatment values (2,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 1000);
insert into patient_treatment values (3,'Immunosuppressants', 2000);
insert into patient_treatment values (4,'BTKI', 3000);
insert into patient_treatment values (5,'Radiation', 4000);
insert into patient_treatment values (4,'Chemotherapy', 2000);
insert into patient_treatment values (1,'Biopsy', 5000);
insert into patient_treatment values (6,'Chemotherapy', 6000);




select * from patient_treatment;
select * from event_category;
select * from physician_speciality;


#Question: From the following 3 tables (event_category, physician_speciality, patient_treatment), write a SQL query to get the histogram of 
-- specialties of the unique physicians who have done the procedures but never did prescribe anything.

Using the patient treatment and event category table, identify all the physicians who have done “Prescription”. Have this recorded in a sub query. 

Then in the main query join the patient treatment, 
event category and physician speciality table to identify all the physician 
who have done “Procedure”. From these physicians, remove those physicians 
you got from sub query to return the physicians who have done Procedure but never did Prescription.



select ps.speciality, count(*)
from patient_treatment pt
join event_category e on pt.event_name = e.event_name
join physician_speciality ps on ps.physician_id = pt.physician_id
where e.category ='Procedure'and pt.physician_id not in (select pt2.physician_id
                                            from patient_treatment pt2
                                            join event_category e2
                                            on pt2.event_name = e2.event_name
                                            where e2.category ='Prescription')
group by ps.speciality











