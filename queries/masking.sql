drop function if exists masking(value text, prefix integer, sub text);

create function
    masking(value text, prefix integer, sub text) returns text as
$$
    select
        case
            when user = 'postgres' then value::text
            else
                substring(value from 1 for prefix) || sub
        end
$$
language 'sql';

select
    substring('natasha' from 1 for 4) || '***' as name;
