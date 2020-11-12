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

## How to
Create the functions, and use it whatever you like!
