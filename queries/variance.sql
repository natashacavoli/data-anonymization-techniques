drop function if exists variance(num integer, factor double precision);

create function
    variance(num integer, factor double precision) returns integer as
$$
    select
        case
            when user = 'postgres' then num::integer
            else
                (num::integer * (1 + (2 * random() - 1) * factor))::integer
        end
$$
language 'sql';

select
    (20::integer * (1 + (2 * random() - 1) * 0.10))::integer variance
