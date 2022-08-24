class EmailVerificationCodeJob < ApplicationJob
  retry_on AlwaysRetryException, attempts: :unlimited

  def perform(verification_code)
    # send verification code to user email
  end
end