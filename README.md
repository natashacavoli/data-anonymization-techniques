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

## How to
Create the functions, and use it whatever you like!
