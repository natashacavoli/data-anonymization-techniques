drop function if exists faking(text);

create function
    faking(text) returns text as
$$
    select
        case
            when user = 'postgres' then $1::text
            else
                name
        end
    from
        somewhere
    order by
        random()
    limit 1
$$
language 'sql';
