class SearchesController <

　　def search
　　　@model = params[:model]
　　　@how = params[:how]
　　　@word = params[:word]
　　　if @model == 'user'
　　　  @user = User.search(search,word)
　　　else @model == 'book'
　　　  @book = Book.search(search,word)
　　  end
　　end

