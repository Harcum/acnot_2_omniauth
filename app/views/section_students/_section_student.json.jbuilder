json.extract! section_student, :id, :id, :student_id, :instructor_id, :advisor_id, :start_date, :end_date, :session, :section, :curriculum, :present, :absent, :created_at, :updated_at
json.url section_student_url(section_student, format: :json)
