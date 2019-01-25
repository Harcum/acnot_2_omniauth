class NotificationsGrid

  include Datagrid

  scope do
    # the select().uniq is necessary because otherwise mutiple rows come back for sections with more than 1 instructor
    Notification.order("created_at desc").joins(:student).joins(:notification_viewers).joins(:creator).joins(:section)
    .select('[notifications].*,[section_students].section, [section_students].session').uniq
  end
  
  # this is how the sql connector forms the join. Note that the 2nd join to people uses an alias [creators_notifications]
  # SELECT COUNT(*) FROM [notifications] INNER JOIN [people] ON [people].[id] = [notifications].[person_id] 
  # INNER JOIN [notification_viewers] ON [notification_viewers].[notification_id] = [notifications].[id] 
  # INNER JOIN [people] [creators_notifications] ON [creators_notifications].[id] = [notifications].[created_by] 
  # WHERE ([notification_viewers].person_id = 13058)

  
  
    

  filter(:created_at, :date, :range => true , header: "Notifications created between")
  filter(:name, :string , header: "Filter by student name") do |value|
    self.where(["[people].first_name + ' '  +  [people].last_name like ?", "%"+value+"%"])
  end
  
  filter(:open_actions, :boolean, header: "Hide Completed Actions") do |value|
    self.where(["[notification_viewers].assignee_open > 1 - ?", value])
  end


  column(:student) do |object|
    object.student.full_name
  end
  
  # sorts barf because of join when section is null
  column(:session, :order => "[section_students].session") do |object|
    object.section ? object.section.session : ""
  end
  
  column(:section, :order => "[section_students].section") do |object|
    object.section ? object.section.section : ""
  end
  
  column(:creator, :order => "[creators_notifications].last_name") do |object|
    object.creator.full_name
  end

  column(:created_at) do |model|
    model.created_at.to_date
  end
  
  column(:reasons, :html => true, :header =>"Reasons") do |n|
    render "reasons", :n => n
  end
    
   column(:actions, :html => true, :header =>"Actions") do |n|
    render "actions", :n => n
  end
  
  column(:icons, :html => true, :header =>"") do |n|
    render "icons", :n => n, :nv => n.notification_viewers.where("person_id = #{@current_user_id}").take
  end
  
  
  
  
  
  
  
  
   
end

