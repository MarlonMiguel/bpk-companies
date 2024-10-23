class User < ApplicationRecord
  has_and_belongs_to_many :categories
  has_many :products
  has_one_attached :profile_image

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[admin vendedor].freeze

  validates :role, inclusion: { in: ROLES }
  validates :name, presence: true
  validates :phone, presence: true

  def admin?
    role == 'admin' 
  end

  def active_for_authentication?
    super && active?
  end

  def inactive_message
    active? ? super : :inactive
  end

end
