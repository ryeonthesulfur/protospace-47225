class PrototypesController < ApplicationController
before_action :authenticate_user!, except: [:index, :show] #ログインしていないユーザーは、投稿一覧と投稿詳細以外のページにアクセスできないようにする。
before_action :set_proto, only: [:show, :edit, :update, :destroy] #show, edit, updateアクションが呼び出される前に、set_protoメソッドを実行するようにする。set_protoメソッドは、該当するプロトタイプを見つけて@prototypeに代入する。
before_action :move_to_index, only: [:edit, :update, :destroy]  #ログインしてないユーザー且つログイン中のユーザーが投稿主と一致しない場合は、編集・更新・削除をしようとすると、その前に、indexアクションにリダイレクトされるようにする。

  def index
    @prototypes = Prototype.all
  end
  

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
      @comments = @prototype.comments
      @comment = Comment.new
  end

  def edit
  end

  def update
    if @prototype.update(prototype_params)
       redirect_to prototype_path(@prototype)
    else
       render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @prototype.destroy
    redirect_to root_path
  end


  private


  def set_proto
      @prototype = Prototype.find(params[:id])
  end


  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

def move_to_index
  unless user_signed_in? && current_user.id == @prototype.user_id
    redirect_to action: :index
  end
end

end


=begin

destroyアクション内において、本当は

prototype = Prototype.find(params[:id])
prototype.destroy

と書くことで、インスタンス変数を使う場合（ビューとデータのやり取りをする場合）との差別化を図りたかったが、それはできなかった。

なぜならば、「:destroy」の記述が無いままである set_proto メソッドが作動する際は、
@prototype の中身を空のまま用意して move_to_index メソッドで本人チェックをするからである。

destroyアクションの作動については、
@prototype が空のため、move_to_index メソッドによる本人チェックの時点で
空のデータの user_id は分からないというエラーになるのである。
=end