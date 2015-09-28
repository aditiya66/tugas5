class Article < ActiveRecord::Base
# Article.create(title: "Kabayan", content: "kabayan jomblo clalu")


#  article_new = Article.new
# article_new.title = "Semar Astana Nyar"
# article_new.content = "kelaparan - kelaparan semar berteriak sambil berharap ada yang memberi makan"
# article_new.save

# validates :title,presence:true,
# 			length: {minimum: 5}
# 	validates :content,presence:true,
# 			length: {minimum: 10}
# 			validates :status, presence: true


#      scope :status_active, -> {where(status: 'active')}
					


#         has_many :comments, dependent: :destroy



  has_many :comments, dependent: :destroy

        validates :title, presence: true, length: { minimum: 5 }

        validates :content, presence: true, length: { minimum: 10 }

        validates :status, presence: true

        scope :status_active, -> {where(status: 'active')}
end
