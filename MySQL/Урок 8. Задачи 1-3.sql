use lesson_7;
select * from users;

-- Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который 
-- больше всех общался с выбранным пользователем (написал ему сообщений).

select * from messages;
select * from users;
select * from profiles;

select firstname, lastname, mess.count as "Количество сообщений" from 
	(select id, from_user_id, to_user_id, count(*) as count from messages
	group by from_user_id) as mess
join users
    where to_user_id = 1 and mess.from_user_id = users.id
order by count desc limit 1;


-- Подсчитать общее количество лайков, которые получили пользователи младше 10 лет

select count(*) as likes_under_10 from likes join 
(select * from profiles
where datediff(now(), birthday) < 10*365) as under_10
where likes.user_id = under_10.user_id;

select * from profiles
where datediff(now(), birthday) < 10*365; -- пользователи младше 10 лет


-- Определить кто больше поставил лайков (всего): мужчины или женщины.
select * from profiles;
select * from likes;

select profiles.gender, count(*) as "Количество" from likes join profiles
	using (user_id)
	where profiles.gender = 'f'
		union
select profiles.gender, count(*) as "Количество" from likes join profiles
	using (user_id)
	where profiles.gender = 'm';

