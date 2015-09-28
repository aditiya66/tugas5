require "action_mailer"

    ActionMailer::Base.delivery_method = :smtp

    ActionMailer::Base.smtp_settings = {

      :address              => "smtp.gmail.com",

      :port                 => 465,

      :domain               => '@gmail.com',

      :user_name            => 'aditiyanugraha56@gmail.com',

      :password             => 'destrak123',

      :authentication       => "plain",

      :ssl                  => true,

      :tls                  => true,

      :enable_starttls_auto => true

    }






class ConfirmationMailer < ApplicationMailer
	 def confirm_email(target_email, activation_token)

            @activation_token = activation_token

            mail(:to => target_email,

                        :from => "adit.legeg@gmail.com",

                        :subject => "[Training - Rails 4]") do |format|

                            format.html { render 'confirm_email'}

                        end

        end
end
