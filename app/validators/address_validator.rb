class AddressValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if value.include?(" ")
      record.errors[:address] << (options[:message] || "はスペース入れないでください")
    end

    unless value=~/\A(\d{3}-\d{4})+(.+?[都道府県])+(.+?[市区町村])+(.+)/
      record.errors[:address] << (options[:message] || "は「XXX-XXXX東京都港区芝浦...」のように記入し、「X」には数字を入れてください。(記入例：123-4567東京都港区芝浦三丁目1番21号)")
    end

    if value=~/\A(\d{3}-\d{4})+(.+?[都道府県])+(.+?[市区町村])\z/
       record.errors[:address] << (options[:message] || "は番地まで記入してください。(記入例：123-4567東京都港区芝浦三丁目1番21号)")
    end

    unless value=~/\A(\d{3}-\d{4})/
      record.errors[:address] << (options[:message] || "の郵便番号は正しくないです。(記入例：123-4567)")
    end
  end
end
