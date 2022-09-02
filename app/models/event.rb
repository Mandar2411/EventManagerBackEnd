class Event < ApplicationRecord
    validates :title, presence: true
    validates :description, presence: true, length: { minimum: 10 }
    validates :venue, presence: true
    validates :event_type, presence: true
    validates :start_date, presence: true
    validates :end_date, presence: true
    validates :fee, presence: true
    validates :image_url, presence: true

    has_many :taggings, dependent: :destroy
    has_many :tags, through: :taggings

    has_many :registrations, dependent: :destroy
    has_many :users, through: :registrations
  
    def self.tagged_with(name)
      Tag.find_by!(name: name).events
    end
  
    def self.tag_counts
      Tag.select('tags.*, count(taggings.tag_id) as count').joins(:taggings).group('taggings.tag_id')
    end
  
    def tag_list
      tags.map(&:name).join(', ')
    end
  
    def tag_list=(names)
      self.tags = names.split(',').map do |n|
        Tag.where(name: n.strip).first_or_create!
      end
    end
  end
  