class MynumberValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.include?("-")
      record.errors[:mynumber] << (options[:message] || "はハイフン(-)入れないでください")
    end

    unless value=~/\A\d{12}\z/
      record.errors[:mynumber] << (options[:message] || "は12桁の数字を入れてください。(記入例：012345678912)")
    end

  end
end
