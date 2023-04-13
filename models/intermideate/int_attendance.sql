with
    int_sessions as (select contact_id, count(distinct case when attendance_status = 'Present' then sessions_id else null end) as attendance_count, batches_id, first_name, last_name from {{ ref('int_sessions')}} group by contact_id, batches_id, first_name, last_name),
    int_batches_sessions_conducted as (select * from {{ ref('int_batches_sessions_conducted') }}),

int_attendance as (

    select *
    from int_sessions
    left join int_batches_sessions_conducted using (batches_id)
    
)
select contact_id, first_name, last_name, attendance_count, total_sessions, ((attendance_count / total_sessions)*100) as percentage_attendance
from int_attendance