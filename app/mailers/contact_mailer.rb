class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    mail(
      to: 'onepanman.0723@au.com',
      subject: 'お問い合わせ内容'
    )
  end
end
