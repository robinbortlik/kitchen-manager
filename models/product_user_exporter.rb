class ProductUserExporter
  attr_accessor :product_users, :products, :users

  def initialize(product_users)
    self.product_users = product_users
    self.products = Product.all.sort_alphabetical_by(&:name)
    self.users = User.all.sort_alphabetical_by(&:last_name)
  end

  def generate
    csv_string = CSV.generate(encoding: "windows-1250", col_sep: ";") do |csv|
      csv << [""] + products.map{|p| p.name.to_s.encode("windows-1250")} + ["Not paid", "Paid", "Sum"]
      users.each do |u|
        pus = product_users.select_by(:user_id, u.id)
        tmp = products.map {|p| pus.select_by(:product_id, p.id).length }
        is_paid = pus.select_by(:is_paid, true).sum(:price).to_f
        not_paid =pus.select_by(:is_paid, false).sum(:price).to_f + pus.select_by(:is_paid, nil).sum(:price).to_f
        sum = pus.sum(:price).to_f
        csv << [u.name.encode("windows-1250")] + tmp + [not_paid, is_paid, sum]
      end
      csv
    end
    csv_string
  end

end