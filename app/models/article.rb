class Article < ApplicationRecord
	is_impressionable
	has_many :comments, :dependent => :delete_all
	has_many :taggings, :dependent => :delete_all
	has_many :tags, through: :taggings
	def self.search(search)
		where 'upper(title) LIKE ?', "%#{search}%".upcase
	end

	def all_tags=(names)
	  self.tags = names.split(",").map do |name|
	      Tag.where(name: name.strip).first_or_create!
	  end
	end

	def all_tags
	  self.tags.map(&:name).join(", ")
	end
	
	def self.tagged_with(name)
	  Tag.find_by_name!(name).articles
	end
end
