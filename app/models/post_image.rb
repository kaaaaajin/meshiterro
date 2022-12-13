class PostImage < ApplicationRecord
  
  has_one_attached :image
  # ActiveStorageを使って画像を表示する際には、どのモデルに対して画像を使うのかを宣言する必要
  belongs_to :user
   
  def get_image
    unless image.attached?
      file_path = Rails.root.join('app/assets/images/no_image.jpg')
      image.attach(io: File.open(file_path), filename: 'default-image.jpg', content_type: 'image/jpeg')
    end
    image
  end
end
