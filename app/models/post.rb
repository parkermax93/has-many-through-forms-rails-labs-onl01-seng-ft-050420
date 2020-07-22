class Post < ActiveRecord::Base
  has_many :post_categories
  has_many :categories, through: :post_categories
  has_many :comments
  has_many :users, through: :comments
  accepts_nested_attributes_for :categories, reject_if: proc {|attr| attr['name'].blank?}


  def comments_attributes=(attributes)
      attributes.values.each do |attr|
        comment = Comment.find_or_create_by(attr)
        self.comment_attributes.build(comment: comment)
      end
  end

  def uniq_users

      self.comments.uniq { |comment| comment.user.id }
    
  end

end