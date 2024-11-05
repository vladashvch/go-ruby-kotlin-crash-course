# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/reporters'

def setup_reporters(reports_dir)
  Minitest::Reporters.use! [
    Minitest::Reporters::SpecReporter.new,
    Minitest::Reporters::HtmlReporter.new(
      reports_dir: reports_dir,
      output_filename: 'test_results.html',
      add_timestamp: true,
      color: true,
      mode: :clean
    )
  ]
end

def expected_age(birth_date)
  today = Date.today
  age = today.year - birth_date.year
  age -= 1 if (
    today.month < birth_date.month || 
    (today.month == birth_date.month && today.day < birth_date.day)
  )
  age
end
