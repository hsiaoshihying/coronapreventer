store_user = StoreUser.create!(name:  "Example Store",
                               phone: "07012345678",
                               address: "108-0014東京都港区芝浦三丁目1番21号",
                               email: "store@railstutorial.org",
                               password:              "foobar",
                               password_confirmation: "foobar")
49.times do |n|
  name  = Faker::Name.name
  phone = '07012345678'
  address = "108-0014東京都港区芝浦三丁目1番21号"
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  StoreUser.create!(name:  name,
                       phone: phone,
                       address: address,
                       email: email,
                       password:              password,
                       password_confirmation: password)
end

products = ["マスク", "ハンドソープ", "殺菌グッズ"]
price_arr = [500, 1000, 300, 50, 770, 1300]
total_num_arr = [30, 50, 100, 20, 10, 60]
store_users = StoreUser.all
created_time_arr = [Time.zone.now, 10.days.ago, 1.months.ago, 2.months.ago]
10.times do
  name = products.sample
  price = price_arr.sample
  total_num = total_num_arr.sample
  created_time = created_time_arr.sample
  store_users.each { |user| user.products.create!(name: name,
                                                  price: price,
                                                  total_num: total_num,
                                                  created_at: created_time) }
end


50.times do |n|
  mynumber = 12.times.map{rand(0...10)}.join
  name  = Faker::Name.name
  address = "108-0014東京都港区芝浦三丁目1番" + (n+1).to_s + "号"
  PersonalInfo.create!(mynumber: mynumber,
                       name:  name,
                       address: address)
end

customer_user = CustomerUser.create!(name:  PersonalInfo.first.name,
                               phone: "07012345678",
                               email: "customer@railstutorial.org",
                               address: "108-0014東京都港区芝浦三丁目1番1号",
                               mynumber: PersonalInfo.first.mynumber,
                               password:              "foobar",
                               password_confirmation: "foobar")

29.times do |n|
  name  = PersonalInfo.find(n+2).name
  phone = '07012345678'
  email = "example-#{n+1}@railstutorial.org"
  address = "108-0014東京都港区芝浦三丁目1番" + (n+2).to_s + "号"
  mynumber = PersonalInfo.find(n+2).mynumber
  password = "password"
  CustomerUser.create!(name:  name,
                    phone: phone,
                    email: email,
                    address: address,
                    mynumber: mynumber,
                    password:              password,
                    password_confirmation: password)
end


