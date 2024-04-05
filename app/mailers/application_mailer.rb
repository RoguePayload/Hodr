class ApplicationMailer < ActionMailer::Base
  default to: 'admin@hodr.me', from: 'website@hodr.me'

  def contact_email(contact)
    @contact = contact
    mail(subject: 'New Contact Message from Website')
  end
end
