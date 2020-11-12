# Data anonymization techniques
Techniques of data anonymization using PostgreSQL

## Extensions
```sql
create extension if not exists pgcrypto;
```

## Tables Examples
```sql
create table users (
    id serial primary key,
    uid uuid not null default gen_random_uuid(),
    name character varying(75) not null,
    address character varying(75),
    phone character varying(12),
    birth_date date
);

alter table users ADD constraint unique_uid
    unique (uid);

create table somewhere (
    id serial primary key,
    name character varying(75) not null
);

```

## Roles
Create an user to connect, in addition to the owner.
```sql
create user test;
```

## Functions

#### Data Masking
```sql
drop function if exists masking(value text, prefix integer, sub text);

create function
    masking(value text, prefix integer, sub text) returns text as
$$
    select
        case
            when user = 'your owner' then value::text
            else
                substring(value from 1 for prefix) || sub
        end
$$
language 'sql';
```

#### Pseudonymization
```sql
drop function if exists pseudonymise(text);

create function
    pseudonymise(text) returns text as
$$
    select
        case
            when user = 'your owner' then $1
            else encode(digest($1 || to_char(current_timestamp, 'mmddyyyyhh24miss'), 'sha1'), 'hex')
        end
$$
language 'sql';
```

#### Generalization
```sql
drop function if exists age_f(date);

create function
    age_f(date) returns text as
$$
    select
        case
            when user = 'your owner' then $1::text
            else
                'between ' || extract(year from age(date_trunc('decade', $1::date) + '1 decade'::interval))::text
                || ' and ' || extract(year from age(date_trunc('decade', $1::date)))::text
        end
$$
language 'sql';
```

#### Variance
```sql
drop function if exists variance(num integer, factor double precision);

create function
    variance(num integer, factor double precision) returns integer as
$$
    select
        case
            when user = 'your owner' then num::integer
            else
                (num::integer * (1 + (2 * random() - 1) * factor))::integer
        end
$$
language 'sql';
```

#### Faking
```sql
drop function if exists faking(text);

create function
    faking(text) returns text as
$$
    select
        case
            when user = 'your owner' then $1::text
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
```

## How to
Create the functions, and use it whatever you like!
