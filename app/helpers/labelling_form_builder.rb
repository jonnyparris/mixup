class LabellingFormBuilder < ActionView::Helpers::FormBuilder

  def text_field_with_label(attribute, options={})
    label(attribute) + text_field(attribute, options={})
  end

  def email_field_with_label(attribute, options={})
    label(attribute) + email_field(attribute, options={})
  end

  def password_field_with_label(attribute, options={})
    label(attribute) + password_field(attribute, options={})
  end

  def url_field_with_label(attribute, options={})
    label(attribute) + url_field(attribute, options={})
  end

end
