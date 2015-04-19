class Company < ActiveRecord::Base
  has_many :offers
  attr_writer :uploaded_file
  before_save :parse_uploaded_file

  def parse_uploaded_file
    if @uploaded_file.present?
      xmlfile = File.open(@uploaded_file.path)
      doc = Nokogiri::XML(xmlfile)
      xml_offers = doc.xpath('.//offer[@type="vendor.model"]')
      xmlfile.close

      if self.offers.count > 0 && self.persisted?
	self.offers.destroy_all
      end

      xml_offers.each do |xml_offer|
	next if xml_offer.xpath('.//model').first.blank? || xml_offer.xpath('.//model').first.content.blank?
	next if xml_offer.xpath('.//picture').first.blank? || xml_offer.xpath('.//picture').first.content.blank?
	next if xml_offer.xpath('.//description').first.blank? || xml_offer.xpath('.//description').first.content.blank?
	next if xml_offer.xpath('.//url').first.blank? || xml_offer.xpath('.//url').first.content.blank?
	
	new_offer = Offer.create(title: xml_offer.xpath('.//model').first.content, picture: xml_offer.xpath('.//picture').first.content, description: xml_offer.xpath('.//description').first.content, url: xml_offer.xpath('.//url').first.content)
	self.offers << new_offer
	
      end
      
      self.last_file_date = Time.now

      if @uploaded_file.original_filename.present?
	self.last_file_name = @uploaded_file.original_filename.to_s
      end

    end
  end
end
