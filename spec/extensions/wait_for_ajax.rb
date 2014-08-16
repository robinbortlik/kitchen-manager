module WaitForAjax
  def wait_for_ajax
    Timeout.timeout(Capybara.default_wait_time) do
      loop until finished_all_ajax_requests?
    end
    Timeout.timeout(Capybara.default_wait_time) do
      loop until no_changes_in_html_structure?
    end
  end

  def finished_all_ajax_requests?
    page.evaluate_script('jQuery.active').zero?
  end

  def no_changes_in_html_structure?
    old_value = page.evaluate_script("$('html').html()")
    sleep 0.2
    new_value = page.evaluate_script("$('html').html()")
    old_value == new_value
  end
end

RSpec.configure do |config|
  config.include WaitForAjax, type: :feature
end