require 'spec_helper'

module Cb
  describe Cb::CompanyApi do
    context '.find_by_did' do
      it 'should load a job in a blank search', :vcr => { :cassette_name => 'company/find_by_did' } do

        company = Cb.company.find_by_did('c7g6mv76nc5vylrzpwh')

        company.did.length.should >= 19
        company.name.length.nil?.should == false
      end

      it 'should not load job for a bad did', :vcr => { :cassette_name => 'job/bad_did' } do
        company = Cb.company.find_by_did('bogus_did')

        puts "cb_response: #{company.cb_response}"

        company.cb_response.errors.is_a?(Array).should == true
        company.cb_response.errors.first.include?('This Company has an Error').should == true
      end
    end
  end
end
