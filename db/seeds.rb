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
price_arr = [500, 1000, 300]
total_num_arr = [30, 50, 100]
store_users = StoreUser.all
10.times do
  name = products.sample
  price = price_arr.sample
  total_num = total_num_arr.sample
  store_users.each { |user| user.products.create!(name: name,
                                                  price: price,
                                                  total_num: total_num) }
end


customer_user = CustomerUser.create!(name:  "Example Customer",
                               phone: "07012345678",
                               email: "customer@railstutorial.org",
                               password:              "foobar",
                               password_confirmation: "foobar")

49.times do |n|
  name  = Faker::Name.name
  phone = '07012345678'
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  CustomerUser.create!(name:  name,
                    phone: phone,
                    email: email,
                    password:              password,
                    password_confirmation: password)
end


