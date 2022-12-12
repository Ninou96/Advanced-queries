-- List each pair of actors that have worked together.
CREATE VIEW pair_of_actors AS
select film_id, fa1.actor_id as actor_id1 , fa2.actor_id as actor_id2 from film_actor fa1
join film_actor fa2 using (actor_id)
where fa1.actor_id <> fa2.actor_id; 

-- For each film, list actor that has acted in more films.
select * from film_actor;
select actor_id , count(film_id) as count from film_actor
group by actor_id
order by count desc;
select fa.actor_id , fa.film_id, count(film_id) from film_actor fa
join (select actor_id , count(film_id) as count from film_actor
group by actor_id
)sub1
USING (actor_id)
order by film_id;
select *, rank() over(partition by film_id order by count(film_id) desc) as ranking
from (
select fa.actor_id , fa.film_id, count(film_id) from film_actor fa
join
 (select actor_id , count(film_id) as count from film_actor
group by actor_id
)sub1
USING (actor_id)
)sub2;
select actor_id, film_id, count(film_id)
from (
 select *, rank() over(partition by film_id order by count(film_id) desc) as ranking
 from (
 select fa.actor_id , fa.film_id, count(film_id) from film_actor fa
 join
 (select actor_id , count(film_id) as count from film_actor
group by actor_id
       )sub1
      USING (actor_id)
     )sub2
)sub3
where ranking = 1;


