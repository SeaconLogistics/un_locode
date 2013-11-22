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

  end

end
