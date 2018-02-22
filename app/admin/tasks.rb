ActiveAdmin.register Task do
  permit_params :course_id, :title, :description, :video_url, :image

  index do
    selectable_column
    column :id
    column :title
    column :video_url
    actions
  end

  show do
    attributes_table do
      row :title
      row :description
      row :video_url
      row :image do
        task.image.present? ? image_tag(task.image.url, height: 300) : content_tag(:span, 'No Image')
      end
    end
  end

  form do |f|
    f.inputs do
      f.input :course_id, as: :select, collection: Course.all, include_blank: false
      f.input :title
      f.input :description
      f.input :video_url
      f.input :image, hint: task.image.present? ? image_tag(task.image.url, height: 100) : content_tag(:span, 'No Image')
    end
    f.actions
  end
end
