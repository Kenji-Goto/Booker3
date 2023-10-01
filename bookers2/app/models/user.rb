class User < ApplicationRecord
  has_many :books , dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  
  validates :name,presence: true
  validates :name,length: {minimum:2}
  validates :name,length: {maximum:20}
  validates :name,uniqueness: true
  validates :introduction,length: {maximum:50}
  
  

  has_one_attached :profile_image
  
  def get_profile_image(width, height)
  unless profile_image.attached?
    file_path = Rails.root.join('app/assets/images/no_image.jpg')
    profile_image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
  end
  profile_image.variant(resize_to_limit: [width, height]).processed
  end
  
  
end
