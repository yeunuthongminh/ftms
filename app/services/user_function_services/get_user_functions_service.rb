class UserFunctionServices::GetUserFunctionsService
  attr_reader :role

  def initialize role
    @role = role
  end

  def perform
    @functions ||= @role.functions.pluck :id
  end
end
