-- Добавила таблицы "Реакции", "Типы реакций" и "Статусы". 
-- Реакции позволяют пользователям отправлять другому пользователю некую оценку профиля.
-- В типах реакций хранятся значения, доступные к отправке. Это похоже на разные виды лайков на посты (в виде смайликов)
-- Статусы позволяют пользователю написать какой-то статус в своем профиле

CREATE TABLE reaction_types(
id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
reaction_type VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO reaction_types VALUES (DEFAULT, "LIKE");
INSERT INTO reaction_types VALUES (DEFAULT, "UNLIKE");
INSERT INTO reaction_types VALUES (DEFAULT, "WOW");
INSERT INTO reaction_types VALUES (DEFAULT, "AWFUL");

CREATE TABLE reactions(
from_user_id BIGINT UNSIGNED NOT NULL,
to_user_id BIGINT UNSIGNED NOT NULL,
reaction_types_id INT UNSIGNED NOT NULL,
foreign key (reaction_types_id) references reaction_types (id),
foreign key (from_user_id) references user (id),
foreign key (to_user_id) references user (id)
);

insert into reactions values (1, 2, 1);
insert into reactions values (2, 1, 3);
insert into reactions values (1, 2, 2);

create table statuses(
id serial primary key,
owner_id bigint unsigned not null,
txt text not null,
created_at datetime not null default now(),
foreign key (owner_id) references user (id)
);

insert into statuses values (default, 1, "It's my birthday", default);
insert into statuses values (default, 2, "Happy birthday, Boris!", default);

