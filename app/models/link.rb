class Link < ActiveRecord::Base


  def self.search(value = "")
    where("title ILIKE ?", "%#{value}%")
  end

end
