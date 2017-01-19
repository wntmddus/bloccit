class FavoriteMailer < ApplicationMailer
  default from: "wntmddussla@hotmail.com"

  def new_comment(user, post, comment)

 # #18
     headers["Message-ID"] = "<comments/#{comment.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<post/#{post.id}@your-app-name.example>"
     headers["References"] = "<post/#{post.id}@your-app-name.example>"

     @user = user
     @post = post
     @comment = comment

 # #19
     mail(to: user.email, subject: "New comment on #{post.title}")
   end
   def new_post(post, user)
     headers["Message-ID"] = "<post/#{post.id}@your-app-name.example>"
     headers["In-Reply-To"] = "<topic/#{post.topic.id}@your-app-name.example>"
     headers["References"] = "<topic/#{post.topic.id}@your-app-name.example>"

     @post = post
     mail(to: user.email, subject: "You have created a new post, #{post.title}")
   end
end
