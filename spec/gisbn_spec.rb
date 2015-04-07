require 'spec_helper'

describe "gisbn" do
  subject { Gisbn::Book.new "0262033844" }

  describe '#process' do
    let(:output) { "Introduction to Algorithms" }

    it 'book title' do
      expect(output.downcase).to eq subject.title.downcase
    end

    it 'book page count' do
      expect(output).to eq subject.page_count
    end
  end
end