create or replace view shuffling_users as

    with u as (
        select
            u.*,
            row_number() over (order by random()) as n
        from
            users u
    ),
    q as (
        select
            u.name,
            row_number() over (order by random()) as n
        from
            users u
    )
    
    select
        u.id,
        u.uid,
        u.address,
        u.phone,
        u.birth_date,
        case
            when user = 'postgres' then u.name::text
            else q.name::text
        end as name
    from
        u
        inner join q on q.n = u.n;

grant select on shuffling_users to test;
