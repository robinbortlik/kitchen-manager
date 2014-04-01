class ProductUserExporter
  attr_accessor :product_users, :products, :users, :workbook, :sheet

  def initialize(product_users)
    self.product_users = product_users
    self.products = Product.all.sort_alphabetical_by(&:name)
    self.users = User.all.sort_alphabetical_by(&:last_name)
    self.workbook = Spreadsheet::Workbook.new
    self.sheet = workbook.create_worksheet name: Date.today.to_s
  end

  def generate
    sheet.row(0).concat([""] + products.map{|p| p.name.to_s} + ["Not paid", "Paid", "Sum"])
    not_paid_sum = 0
    is_paid_sum = 0
    sum_sum = 0
    products_sum = {}
    users.each_with_index do |u, i|
      pus = product_users.select_by(:user_id, u.id)
      tmp = products.map do |p|
        products_sum[p.id] ||= 0
        amount = pus.select_by(:product_id, p.id).length
        products_sum[p.id] += amount
        amount
      end
      is_paid = pus.select_by(:is_paid, true).sum(:price).to_f
      is_paid_sum += is_paid
      not_paid = pus.select_by(:is_paid, false).sum(:price).to_f + pus.select_by(:is_paid, nil).sum(:price).to_f
      not_paid_sum += not_paid
      sum = pus.sum(:price).to_f
      sum_sum += sum
      sheet.row(i+1).concat([u.name] + tmp + [not_paid, is_paid, sum])
    end

    sheet.row(users.length + 1).concat([""] + products_sum.values + [not_paid_sum, is_paid_sum, sum_sum])
    workbook.write(str = StringIO.new('', 'r+'))
    str.string
  end

end