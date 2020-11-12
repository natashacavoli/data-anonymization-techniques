drop function if exists pseudonymise(text);

create function
    pseudonymise(text) returns text as
$$
    select
        case
            when user = 'postgres' then $1
            else encode(digest($1 || to_char(current_timestamp, 'mmddyyyyhh24miss'), 'sha1'), 'hex')
        end
$$
language 'sql';

select
    digest('natasha' || to_char(current_timestamp, 'mmddyyyyhh24miss'), 'sha1'),
    encode(digest('natasha' || to_char(current_timestamp, 'mmddyyyyhh24miss'), 'sha1'), 'hex');
