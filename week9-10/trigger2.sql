drop table if exists order_item;
drop table if exists order_summary;
drop function if exists inc_order_summ;
drop function if exists dec_order_summ;

--create shopping cart table
create table order_item(
    id serial not null,
    name text not null,
    quantity integer not null,
    per_unit_price real not null
);

--create order summary table
create table order_summary(
    num_items integer not null,
    total_price real not null
);

--Trigger function
create function inc_order_summ()
    returns trigger
    language PLPGSQL
as $$
BEGIN
    update order_summary set num_items = num_items + new.quantity;
    update order_summary set total_price = total_price + (new.per_unit_price*new.quantity);
    return null;
END;
$$;

create function dec_order_summ()
    returns trigger
    language PLPGSQL
as $$
BEGIN
    update order_summary set num_items = num_items - old.quantity;
    update order_summary set total_price = total_price - (old.per_unit_price*old.quantity);
    return old;
END;
$$;

--Create the triggers
create trigger tr_tblOrderItem_ForInsert
after insert
on order_item
for each row
execute procedure inc_order_summ();

create trigger tr_tblOrderItem_ForDelete
after delete
on order_item
for each row
execute procedure dec_order_summ();

--insert statements
insert into order_summary(num_items,total_price) values(0,0);
insert into order_item(name,quantity,per_unit_price) values('redmi_note7pro',1,14000),('apples',7,35),('oreo',3,20),('pens',5,1.5),('socks',2,50),('apple_s6',1,20000),('hair_gel',2,100);

--display tables
select * from order_item;
select * from order_summary;

--delete commands
delete from order_item where name like 'socks';
delete from order_item where name like 'apple_s6';
delete from order_item where name like 'hair_gel';

--display tables
select * from order_item;
select * from order_summary;

