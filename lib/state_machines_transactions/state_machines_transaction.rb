class StateMachinesTransaction < ActiveRecord::Base
  enum status: { success: 'success', failure: 'failure' }
  STATUS_COLOR = OpenStruct.new(success: 'green', failure: 'red')

  def status_color
    @_status_color ||= self.success? ? STATUS_COLOR.success : STATUS_COLOR.failure
  end
end
