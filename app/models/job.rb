# == Schema Information
#
# Table name: jobs
#
#  id              :integer          not null, primary key
#  name            :string
#  status          :integer
#  description     :text
#  employment_type :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Job < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user


  enum status: [:active, :inactive]
  enum employment_type: [:full_time, :part_time]

  validates_presence_of :name, :description, :status, :employment_type, :user

  def self.search(query)
    # TODO: throw a much wider net when searching for mathces (i.e. multiple terms and partial matches)
    where("name like ?", "%#{query}%")
  end

  def self.user_jobs(user, *args)
    if !args.empty?
      if  args.select {|arg| arg["search"]}
        @jobs = Job.search(args[0][:search]).where(user_id: user.id).order(created_at: :desc)
      end
    else
      @jobs = user.jobs.order(created_at: :desc)
    end
  end
end
