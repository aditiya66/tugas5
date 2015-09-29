require "action_mailer"

    ActionMailer::Base.delivery_method = :smtp

    ActionMailer::Base.smtp_settings = {

       :address              => "smtp.mailgun.org",

      :port                 => 465,

      :domain               => "sandboxb081658465044b45a91bc6e0d614e797.mailgun.org",

      :user_name            => "postmaster@sandboxb081658465044b45a91bc6e0d614e797.mailgun.org",

      :password             => "3e585a983bf8c657816e1c9f611de0fb",

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
