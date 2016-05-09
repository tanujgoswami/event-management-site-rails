class User < ActiveRecord::Base
  has_many :organized_events, class_name: "Event",
                              foreign_key: "organizer_id"

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
