class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :organized_events, class_name: "Event", foreign_key: "organizer_id"
  has_many :attendances
  has_many :events, through: :attendances
  validates_format_of :email, with: /@/, on: :create 

end
