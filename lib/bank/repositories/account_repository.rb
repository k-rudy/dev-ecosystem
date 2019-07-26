class AccountRepository < Hanami::Repository
  def find_or_create(params:)
    accounts.where(user_id: params[:user_id], number: params[:number]).first ||
      create(params)
  end
end
