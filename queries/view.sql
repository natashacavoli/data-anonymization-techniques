create or replace view users_view as
    select
        id,
        uid,
        name,
        pseudonymise(address) as pseudonymise_address,
        faking(address) as faking_address,
        masking(phone, 7, '****') as masking_phone,
        age_f(birth_date) as generalization_age,
        variance(extract(year from age(birth_date))::integer, 0.20) as variance_age
    from
        users;

grant select on users_view to test;
