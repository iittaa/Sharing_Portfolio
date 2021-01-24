class ContactsController < ApplicationController
  def new
    @contact = Contact.new
  end

  def create
    @contact =Contact.new(contact_params)
    if @contact.save
      redirect_to new_contact_path
      ContactMailer.contact_mail(@contact).deliver_now
      flash[:success] = "お問い合わせメールを送信しました！"
    else
      redirect_to new_contact_path
      flash[:warning] = "ユーザー名とお問い合わせ内容を入力してください。"
    end
  end

  private
  def contact_params
    params.require(:contact).permit(:name, :email, :message)
  end
end
