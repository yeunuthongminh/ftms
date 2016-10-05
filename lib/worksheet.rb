class Worksheet
  attr_accessor :rows

  def initialize dates = [], user
    @dates = dates.blank? ? [Date.today.beginning_of_month] : dates
    @rows = Hash.new
    Employee.includes(:category).assignees_manage_by_user(user).each do |employee|
      @rows[employee.id] ||= Array.new
      @rows[employee.id] << Row.new(employee, @dates)
    end
    load_worksheet user
  end

  def add_data_to_row price
    add_price_to_row price
  end

  def array
    @rows.values.flatten.map &:data
  end

  def json
    @rows.to_json
  end

  private
  def rows_of employee_ids
    [employee_ids.map {|employee_id| @rows[employee_id]}].flatten
  end

  def load_worksheet user
    prices = AssigneeQuery.new(@dates).call user
    prices.each{|price| add_price_to_row price}
  end

  def add_price_to_row price
    employee_rows = @rows[price.employee_id] || Array.new
    index = employee_rows.index{|row| row.can_insert_or_change_with? price}

    if index.nil?
      row = Row.new price.employee, @dates
      employee_rows << row
    else
      row = employee_rows[index]
    end

    row.insert_price price
  end
end
