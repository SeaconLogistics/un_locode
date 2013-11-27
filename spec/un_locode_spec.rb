require 'spec_helper'
require 'un_locode'

describe UnLocode::Locode do

  describe 'scopes' do

    describe 'retrieving locodes by name' do

      let!(:city) { UnLocode::Locode.create(name: 'Eindhoven', name_wo_diacritics: 'Eeindhoven') }
      let!(:other_city) { UnLocode::Locode.create(name: 'Weert') }

      subject { UnLocode::Locode.find_by_fuzzy_name(search_term) }

      context 'exact match' do
        let(:search_term) { city.name }
        its(:first) { should eql(city) }
        its(:count) { should eql(1) }
      end

      context 'fuzzy match' do
        let(:search_term) { city.name[1..4] }
        its(:first) { should eql(city) }
        its(:count) { should eql(1) }
      end

      [:name, :name_wo_diacritics, :alternative_name, :alternative_name_wo_diacritics].each do |attr|
        context "matches against the #{attr} name fields" do
          let!(:city) { UnLocode::Locode.create(attr => 'Eindhoven') }
          let(:search_term) { 'Eindhoven' }
          its(:first) { should eql(city) }
          its(:count) { should eql(1) }
        end
      end

    end

    context 'retrieving locodes by name and function' do
      let!(:port) { UnLocode::Locode.create(name: 'Eindhoven', port: true) }
      let!(:rail_terminal) { UnLocode::Locode.create(name: 'Eindhoven', rail_terminal: true) }

      context 'with supported functions' do
        subject { UnLocode::Locode.find_by_name_and_function(search_term, :port) }
        let(:search_term) { port.name }

        its(:first) { should eql(port) }
        its(:count) { should eql(1) }
      end

      context 'with unsupported function' do
        it 'raises an error' do
          expect { UnLocode::Locode.find_by_name_and_function(search_term, :derp) }.to raise_error
        end
      end
    end
  end

  describe 'as_json' do
    let!(:country) { UnLocode::Country.create name: 'Belgium', code: 'BE' }
    let!(:location) { UnLocode::Locode.create name: 'Eindhoven', port: true, country: country }

    subject { location.as_json }

    its(['country']) { should eql({'code' => 'BE', 'name' => 'Belgium'}) }
    it { should_not have_key('country_id') }
    it { should_not have_key('id') }
  end
end

