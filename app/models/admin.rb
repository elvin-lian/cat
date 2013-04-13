# encoding: utf-8
class Admin < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :name, :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body

  validates_presence_of :email, :name
  validates_uniqueness_of :email, :name

  def self.roles
    %w(super_admin manager)
  end

  def self.roles_human
    {'超级管理员' => 'super_admin', '管理员' => 'manager'}
  end

end
