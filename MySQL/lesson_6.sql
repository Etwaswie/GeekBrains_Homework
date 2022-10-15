use vk_full;

select * from posts_likes;
select * from messages;

-- Задача 1.
select from_user_id, count(*) as msg from messages where to_user_id = 11 group by from_user_id order by msg desc limit 1;

select * from posts;
select * from profiles;

-- Задача 2
select distinct user_id from posts as user_with_posts;

select user_id from profiles as under_ten where timestampdiff(year, birthday, now()) <= 10 and user_id in (select distinct user_id from posts as user_with_posts);
select count(*) from posts_likes where user_id in 
(select user_id from profiles as under_ten where timestampdiff(year, birthday, now()) <= 10 and user_id in 
(select distinct user_id from posts as user_with_posts)) and like_type = 1;

select * from posts_likes where user_id = 6 or user_id = 11;

select count(*) from posts_likes where user_id in 
(select user_id from profiles as under_ten where timestampdiff(year, birthday, now()) <= 10 and user_id in 
(select distinct user_id from posts as user_with_posts)) and like_type = 1;

-- Задача 3
select user_id, like_type, gender, count(*) as cnt_likes from posts_likes join profiles using(user_id) where like_type = 1 group by user_id order by gender;
select gender, sum(cnt_likes) from (select user_id, like_type, gender, count(*) as cnt_likes from posts_likes join profiles using(user_id) where like_type = 1 group by user_id) as likes group by gender;