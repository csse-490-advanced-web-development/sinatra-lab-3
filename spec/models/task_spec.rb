require_relative "../spec_helper"

describe "Task" do
  describe "#create" do
    describe "with valid data" do
      before do
        Task.count.should eq 0  # Sanity check that we haven't got orphaned records hanging around
        Task.create(description: 'Eat breakfast')
      end

      it "should create a task" do
        Task.count.should be 1
      end

      it "should save the description we passed in" do
        Task.first.description.should eq "Eat breakfast"
      end
    end

    describe "without a description", skip: "Step 30: Unskip this test and the one below" do
      let(:task){ Task.new }
      before { task.save }

      it { task.should_not be_valid }
      it { task.errors[:description].should include "can't be blank" }
    end

    describe "with a blank description", skip: "Step 30: Unskip this test and the one above" do
      let(:task){ Task.new(description: "    ") }
      before { task.save }

      it { task.should_not be_valid }
      it { task.errors[:description].should include "can't be blank" }
    end
  end
end
