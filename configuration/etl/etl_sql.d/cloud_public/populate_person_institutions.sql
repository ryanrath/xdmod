/**
 Recursive CTE that let's us break up the staging_persons.institutions comma seperated values into seperate rows for
 the same person_id. This is so we can populate the person_institutions table.
*/
INSERT INTO ${SOURCE_SCHEMA}.person_institutions(person_id, institution_id)
with recursive cte as (
    select id, '                   ' as institution, concat(institutions, ',') as institutions, 1 as lev
    from ${SOURCE_SCHEMA}.staging_persons
    union all
    select id,
           substring_index(institutions, ',', 1),
           substr(institutions, instr(institutions, ',') + 1), lev + 1
    from cte
    where institutions like '%,%'
)
SELECT p.person_id,
       i.institution_id
FROM cte
         JOIN ${SOURCE_SCHEMA}.persons p ON p.id = cte.id
         JOIN ${SOURCE_SCHEMA}.institutions i ON i.id = cte.institution
WHERE cte.lev > 1
ORDER BY p.person_id, i.institution_id;
