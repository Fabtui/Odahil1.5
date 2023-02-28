class ArticlesController < ApplicationController
  skip_before_action :authenticate_user!

  def index
    @articles = Article.all
  end

  def add_to_cart
    article = Article.find(params[:id])
    if session[:cart]
      if article.quantity > session[:cart].count(params[:id].to_i)
        session[:cart].push(article.id)
      else
        redirect_to articles_path, alert: "Désolé cet article n'est plus disponible"
      end
    else
      session[:cart] = [article.id]
    end
      redirect_to articles_path, notice: 'Article ajouté à votre panier'
  end

  def remove_to_cart
    session[:cart].delete_at(session[:cart].find_index(params[:id].to_i))
    redirect_to carts_path, notice: 'Article supprimé de votre panier'
  end
end