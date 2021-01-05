class Employee < ApplicationRecord
    GENDERS = { other: 0, male: 1, female: 2 }

    # 属性を定義する方法の一つが列挙型
    enum gender: GENDERS #enum 
  
    # inclusion -> 与えられた集合に属性の値が含まれているかどうかを検証します。集合には任意のenumerableオブジェクトが使えます。
    # exclusion -> 与えられた集合に属性の値が「含まれていない」ことを検証します。集合には任意のenumerableオブジェクトが使えます。
    validates :gender, inclusion: { in: GENDERS.keys.concat(GENDERS.keys.map(&:to_s)) }, exclusion: { in: [nil] }
    validates :name, exclusion: { in: [nil, ""] }
    validates :department, exclusion: { in: [nil] }
    # numericality -> 属性に数値のみが使われていることを検証します
    validates :payment, numericality: true, exclusion: { in: [nil] }
    validates :note, exclusion: { in: [nil] }
end
