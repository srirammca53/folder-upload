class Upload < ActiveRecord::Base
 
attr_accessible :folder, :folder_password , :folder_days

has_attached_file :folder
  validates_presence_of :folder_file_name, :folder_password, :folder_days


  validates_length_of :folder_password, :in => 3..12

  validates_numericality_of :folder_days
end
