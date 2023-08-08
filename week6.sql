use week6;

drop trigger if exists insert_register;
delimiter //
create trigger insert_register
after insert on register_detail for each row
begin
  declare total float;
  select sum(credit) into total from register_detail
  join section using (section_id)
  join course using (course_id)
  where register_id = new.register_id;
  
  update register set credit_total = total where register_id = new.register_id;
end//
delimiter ;

show triggers;

insert into register_detail value (NULL, 3, 2);
