def to_url string
  return root_path                                if string == "the homepage"
  return mobilizations_path                       if string == "the mobilizations page"
  return mobilization_path(@mobilization)         if string == "this mobilization page"
  return mobilization_path(1)                     if string == "the first mobilization page"
  return new_mobilization_path                    if string == "new mobilization page"
  return edit_mobilization_path(@mobilization)    if string == "edit mobilization page"
  return edit_profile_path                        if string == "edit profile page"
  return user_path(@user)                         if string == "this user page"
  return user_path(@current_user)                 if string == "my profile page"
  return new_badge_path                           if string == "the new badge page"
  return badge_path(Badge.order(:id).last)        if string == "this new badge page"
  return badges_path                              if string == "the badges page"
  return new_task_type_path                       if string == "the new task type page"
  return task_type_path(TaskType.order(:id).last) if string == "this new task type page"
  return "/meurio_accounts"
end
