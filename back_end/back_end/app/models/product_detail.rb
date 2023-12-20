class ProductDetail < ApplicationRecord
  belongs_to :product

  validates :product_name, presence: true, length: { in: 1..20 }
  validates :product_type, inclusion: { in: %w(杂志 教科书 小说 童话 戏剧 数学 计算机 漫画 自传) }

end
