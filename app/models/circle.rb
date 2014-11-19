class Circle < ActiveRecord::Base
  belongs_to :creator, class_name: "user"
end
