require 'spec_helper'

describe Sprig::Seed::Record do
  describe ".existing?" do
    let!(:existing) do
      Post.create(
        :title      => "Existing title",
        :content    => "Existing content",
        :published  => false
      )
    end

    it "returns true if the record has already been saved to the database" do
      subject = described_class.new_or_existing(Post, { title: "Existing title" }, { title: "Existing title" })

      subject.existing?.should == true
    end

    it "returns false if the record is new" do
      subject = described_class.new_or_existing(Post, { title: "New title" }, { title: "New title" })

      subject.existing?.should == false
    end
  end

  describe ".save" do
    describe "when we leave out a belongs_to dependency" do
      let(:subject){ described_class.new(Article, Sprig::Seed::AttributeCollection.new({body: "New body", user: nil})) }
      let(:result) { subject.save }

      it "sucessfullly saves the record" do
        result.should == true
      end
    end
  end
end
