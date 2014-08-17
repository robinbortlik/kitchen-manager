module CustomHelpers
  def visit_admin
    visit '/admin'
    wait_for_ajax
  end

  def set_date_input(selector, date)
    execute_script("
      $('#{selector} input').val('#{date}');
      $('#{selector} input').trigger('change');
    ")
  end

end