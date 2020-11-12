drop function if exists age_f(date);

create function
    age_f(date) returns text as
$$
    select
        case
            when user = 'postgres' then $1::text
            else
                'between ' || extract(year from age(date_trunc('decade', $1::date) + '1 decade'::interval))::text
                || ' and ' || extract(year from age(date_trunc('decade', $1::date)))::text
        end
$$
language 'sql';

select
    date_trunc('decade', '1999-01-30'::date),
    age(date_trunc('decade', '1999-01-30'::date)),
    'between ' || extract(year from age(date_trunc('decade', '1999-01-30'::date) + '1 decade'::interval))::text
    || ' and ' || extract(year from age(date_trunc('decade', '1999-01-30'::date)))::text as age;
