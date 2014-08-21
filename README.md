[![Build Status](https://secure.travis-ci.org/robinbortlik/kitchen-manager.png?branch=master)](https://secure.travis-ci.org/robinbortlik/kitchen-manager)

# Kitchen manager

Electronic stroke board for kitchen or common rooms in companies
It is small application developed in EmberJS which will help us to manage food spend in our company's kitchen


## How to run application

```ruby
  # clone repositor
  git clone https://github.com/robinbortlik/kitchen-manager.git

  # go to directory
  cd kitchen-manager

  # start server
  puma

  # open browser
  localhost:9292
```

## Setup application

```ruby
  # start console
  ./console

  # set currency
  AppSetting.currency = '$'

  # set admin login name
  AppSetting.admin_name = 'new_admin_name'

  # set admin password
  AppSetting.password = 'new_admin_password'
```

## How to use application

1. Go to localhost:9292/admin
2. Add users
3. Add products
4. Go to home and create your first order
5. On localhost:9292/admin you will see the overview what was ordered by who and how much it cost

## Screenshots
1. Select user
<img src="https://s3.amazonaws.com/robinbortlik_github/Kitchen+Manager+1.png" alt="Select user">

2. Create your order
<img src="https://s3.amazonaws.com/robinbortlik_github/Kitchen+Manager+2.png" alt="Create your order">

3. Overview
<img src="https://s3.amazonaws.com/robinbortlik_github/Kitchen+Manager+3.png" alt="Overview">

4. Admin Product Form
<img src="https://s3.amazonaws.com/robinbortlik_github/Kitchen+Manager+7.png" alt="Admin product form">
