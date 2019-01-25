json.extract! student_attribute, :id, :id, :birth_date, :curriculum, :address_line_1, :address_line_2, :city, :state, :zip_code, :matric_date, :resident_commuter, :emergency_contact_name, :emergency_contact_number, :emergency_contact_relationship, :advisor, :personal_email, :harcum_email, :phone_numbers, :created_at, :updated_at
json.url student_attribute_url(student_attribute, format: :json)
