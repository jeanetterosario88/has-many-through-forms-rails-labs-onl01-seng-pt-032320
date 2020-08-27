class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments

  accepts_nested_attributes_for :users, reject_if: proc { |attributes| attributes['user'].blank? }
  accepts_nested_attributes_for :categories


  def categories_attributes=(category_attributes)
    category_attributes.values.each do |category_attribute|
      # binding.pry
      category = Category.find_or_create_by(category_attribute) unless category_attribute[:name] == ""
      self.post_categories.build(category: category)
    end
  end

end
