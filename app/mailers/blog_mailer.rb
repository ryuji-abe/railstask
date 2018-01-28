class BlogMailer < ApplicationMailer
  def created_blog_mail(created_blog)
   @created_blog = created_blog
   user_info = User.find(@created_blog.user_id)
   user_email = user_info.email
   puts user_email

   mail to: user_email, subject: "ブログ作成完了メール"
  end
end
