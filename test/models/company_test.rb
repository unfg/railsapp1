require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "save wihout file upload" do
    company = Company.new(title: "company one")
    assert company.save
  end

  test "save with correct file format and data" do
    company = Company.new(title: "company one")

    file = File.new(Rails.root + 'test/fixtures/files/YML-1.xml')
    xml_file = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
    file.close
    company.uploaded_file = xml_file

    assert company.save && company.offers.count > 0 && company.last_file_date.present? && company.last_file_name == "YML-1.xml"
  end

  test "update created company info" do
    company1 = Company.find_by title: "company1"

    file = File.new(Rails.root + 'test/fixtures/files/YML-1.xml')
    xml_file = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
    file.close
    company1.uploaded_file = xml_file

    assert company1.save && company1.offers.count > 0 && company1.last_file_date.present? && company1.last_file_name == "YML-1.xml"
  end

  test "no offers in uploaded file" do
    company = Company.new(title: "company one")

    file = File.new(Rails.root + 'test/fixtures/files/YML-2.xml')  
    xml_file = ActionDispatch::Http::UploadedFile.new(:tempfile => file, :filename => File.basename(file))
    file.close
    company.uploaded_file = xml_file

    assert company.save && company.offers.count == 0 && company.last_file_date.present? && company.last_file_name == "YML-2.xml"
  end
end
