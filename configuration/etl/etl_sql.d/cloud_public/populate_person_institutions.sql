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
         LEFT JOIN ${SOURCE_SCHEMA}.person_institutions existing
             ON existing.person_id = p.person_id AND
                existing.institution_id = i.institution_id
WHERE cte.lev > 1
AND existing.person_institution_id IS NULL
ORDER BY p.person_id, i.institution_id;
