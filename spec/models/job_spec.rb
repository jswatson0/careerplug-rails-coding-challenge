require 'spec_helper'
require 'factory_girl_rails'

describe Job do
  before :each do
    @user = FactoryGirl.create(:user)
    @job = Job.create(
      name: "Dog Walker",
      description: "Must be able to walk 20 dogs at the same time",
      status: 1,
      employment_type: 1,
      user: @user
    )
  end

  it 'is valid with a name, description, status, employment type, and user' do
    job = Job.create(
      name: "Dog Walker",
      description: "Must be able to walk 20 dogs at the same time",
      status: 1,
      employment_type: 1,
      user: @user
    )
    expect(job).to be_valid
  end

  it 'is invalid without a name' do
    job = Job.create(
      description: "Must be able to walk 20 dogs at the same time",
      status: 1,
      employment_type: 1
    )
    expect(job).to be_invalid
  end

  it 'is invalid without a description' do
    job = Job.create(
      name: "Dog Walker",
      status: 1,
      employment_type: 1
    )
    expect(job).to be_invalid
  end

   it 'returns a set of jobs specific to a user' do
     # tests `user_jobs` class method
     user_jobs = Array.new Job.user_jobs(@user)
     expect(user_jobs.first["user_id" ]).to eq @user.id
   end

  it 'returns jobs that match search input' do
    expect(Job.search('dog').first).to eq @job
  end
end